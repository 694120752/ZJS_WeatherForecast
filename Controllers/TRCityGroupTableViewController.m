//
//  TRCityGroupTableViewController.m
//  WeatherForecast
//
//  Created by 张精申 on 16/2/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRCityGroupTableViewController.h"
#import "TRDataManager.h"
#import "TRCityGroup.h"

@interface TRCityGroupTableViewController ()
@property (nonatomic, strong) NSArray *cityGroupArray;
@end

@implementation TRCityGroupTableViewController

- (NSArray *)cityGroupArray {
    if (!_cityGroupArray) {
        _cityGroupArray = [TRDataManager getAllCityGroups];
    }
    return _cityGroupArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //title
    self.navigationItem.title = @"城市列表";
    //返回Item
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(clickBackItem)];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)clickBackItem {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
//城市数组的下标和tableView的section一一对应
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cityGroupArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //获取数组中对应section那一项
    TRCityGroup *cityGroup = self.cityGroupArray[section];

    return cityGroup.cities.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    //设置文本(取到那个section的那一行)
    TRCityGroup *cityGroup = self.cityGroupArray[indexPath.section];
    cell.textLabel.text = cityGroup.cities[indexPath.row];
    
    return cell;
}

//设置section的Header的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    TRCityGroup *cityGroup = self.cityGroupArray[section];
    return cityGroup.title;
}
//设置tableView的索引数组
- (nullable NSArray <NSString *>*)sectionIndexTitlesForTableView:(UITableView *)tableView {
    //需求:NSArray[@"热门",@"A",....@"Z"]
    NSMutableArray *mutablArray = [NSMutableArray array];
    for (TRCityGroup *cityGroup in self.cityGroupArray) {
        [mutablArray addObject:cityGroup.title];
    }
    return [mutablArray copy];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TRCityGroup* cityGroup=self.cityGroupArray[indexPath.section];
    
    //发送通知(通知中心)
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"DidCityChange" object:self userInfo:@{@"CityName":cityGroup.cities[indexPath.row]}];
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
