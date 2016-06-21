//
//  TRMainViewController.m
//  WeatherForecast
//
//  Created by 张精申 on 16/2/19.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRMainViewController.h"
#import "TRHeaderView.h"
#import "RESideMenu.h"
#import "TRLocationManager.h"
#import "TRNetworkManager.h"
#import "MBProgressHUD.h"
#import "TRDataManager.h"
#import "TRDaily.h"
#import "TRHourly.h"
#import "TRHeader.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import <CoreLocation/CoreLocation.h>
@interface TRMainViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
//记录请求url
@property (nonatomic, strong) NSString *urlStr;
//每天数组
@property (nonatomic, strong) NSArray *dailyArray;
//每小时数组
@property (nonatomic, strong) NSArray *hourlyArray;
//headerView
@property(nonatomic,strong)TRHeaderView* headerView;
//用户的位置
@property(nonatomic,strong)CLLocation* userLocation;
//地理编码
@property(nonatomic,strong)CLGeocoder* geocoder;
@end

@implementation TRMainViewController
-(CLGeocoder *)geocoder{
    if (_geocoder==nil) {
        _geocoder=[CLGeocoder new];
    }
    return _geocoder;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self listenNotification];
    
   
    
    [self createTableView];
    [self createHeaderView];
    [self createBottomRefreshControl];
    
   // [self getLocationAndSendRequest];
}
#pragma mark - 和通知相关的方法
-(void)listenNotification{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didCityChange:) name:@"DidCityChange" object:nil];
}
-(void)didCityChange:(NSNotification *)notification{

    [self.sideMenuViewController hideMenuViewController];
    
    NSString* cityName=notification.userInfo[@"CityName"];
    
    [self.geocoder geocodeAddressString:cityName completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark* placemark=[placemarks lastObject];
        //拼接URL
        self.urlStr = [NSString stringWithFormat:@"http://api.worldweatheronline.com/free/v2/weather.ashx?q=%f,%f&num_of_days=5&format=json&tp=4&key=e3ba7614cb1c609b6db982b314255", placemark.location.coordinate.latitude, placemark.location.coordinate.latitude];
            //重新发送请求
        self.userLocation=placemark.location;
        [self sendRequestToServer];
        self.headerView.cityLabel.text=placemark.addressDictionary[@"City"];
    }];
    


}
#pragma mark - 和服务器相关方法
- (void)getLocationAndSendRequest {
    [TRLocationManager getUserLocation:^(double lat, double log) {
        self.userLocation=[[CLLocation alloc]initWithLatitude:lat longitude:log];
        //合成请求的url
        self.urlStr = [NSString stringWithFormat:@"http://api.worldweatheronline.com/free/v2/weather.ashx?q=%f,%f&num_of_days=5&format=json&tp=4&key=e3ba7614cb1c609b6db982b314255", lat, log];
        //发送用户所在位置请求;
        
        [self sendRequestToServer];
       
    }];
}
- (void)sendRequestToServer {
    [TRNetworkManager sendRequestWithUrl:self.urlStr parameters:nil success:^(id responseObject) {
        NSLog(@"成功返回");
        
        //更新头部视图
        [self parseAndUpdateHeaderView:responseObject];
       // NSLog(@"头部方法调用完毕");
       // NSLog(@"%@",responseObject);
        
        //调用数据管理类接口
        self.dailyArray = [TRDataManager getAllDailyData:responseObject];
        self.hourlyArray = [TRDataManager getAllHourlyData:responseObject];
        [self.tableView reloadData];
        //停止下拉刷新动画
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        //timeout(网络问题)
        NSLog(@"失败:%@", error.userInfo);
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"网络繁忙，请稍后再试";
        hud.margin = 10.0;
        [hud hide:YES afterDelay:3];
        
        //停止下拉刷新动画
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - 和界面相关方法

-(void)parseAndUpdateHeaderView:(id)responseObject{
    TRHeader* hh=[TRHeader getHearData:responseObject];
  //  NSLog(@"11111111111111111%@",hh.weatherTemp);
    if(self.userLocation){
        [self.geocoder reverseGeocodeLocation:self.userLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            CLPlacemark* placemark=[placemarks lastObject];
            //获取城市名字
            self.headerView.cityLabel.text=placemark.addressDictionary[@"City"];
        }];
    }
    [self.headerView.iconView sd_setImageWithURL:[NSURL URLWithString:hh.iconUrlStr] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    self.headerView.conditionsLabel.text=hh.weatherDesc;
    self.headerView.temperatureLabel.text=hh.weatherTemp;
    self.headerView.hiloLabel.text = [NSString stringWithFormat:@"%@° / %@°",hh.minTemp, hh.maxTemp];
    NSLog(@"头部数据更新完毕");
    //[self.view addSubview:self.headerView];
}


- (void)createBottomRefreshControl {
    //第二个参数给定下拉刷新触发方法
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getLocationAndSendRequest)];
    //显示动画(触发selector方法)
    [header beginRefreshing];
    //显示到tableView
    self.tableView.mj_header = header;
}

- (void)createHeaderView {
    self.headerView = [[TRHeaderView alloc] initWithFrame:SCREEN_BOUNDS];
    [self.headerView.menuButton addTarget:self action:@selector(clickMenuButton) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableHeaderView = self.headerView;
}
- (void)clickMenuButton {
    
    [self.sideMenuViewController presentLeftMenuViewController];
}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:SCREEN_BOUNDS];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.pagingEnabled=YES;
    [self.view addSubview:self.tableView];
}
#pragma mark - Delegate / DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? self.hourlyArray.count+1: self.dailyArray.count+1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    //设置cell背景颜色/字体颜色/选中状态
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //设置cell的文本
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"Hourly Forecast";
            cell.detailTextLabel.text=nil;
            cell.imageView.image=nil;
        } else {
            TRHourly* hourly=self.hourlyArray[indexPath.row-1];
            cell.textLabel.text=hourly.time;
            cell.detailTextLabel.text=hourly.tempC;
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:hourly.iconUrl] placeholderImage:[UIImage imageNamed:@"placeholder"]];
            
        }

    } else {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"Daily Forecast";
        } else {
            //第1个section的非0行
            //获取对应行的每天数据
            TRDaily *daily = self.dailyArray[indexPath.row - 1];
            cell.textLabel.text = daily.date;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@/%@", daily.maxTempC, daily.mintempC];
            
            //设置cell的imageView
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:daily.iconUrl] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger cellCount = [self tableView:tableView numberOfRowsInSection:indexPath.section];
    
    return SCREEN_HEIGHT / cellCount;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
