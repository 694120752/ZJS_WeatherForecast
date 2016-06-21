//
//  TRLeftViewController.m
//  WeatherForecast
//
//  Created by 张精申 on 16/2/19.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRLeftViewController.h"
#import "TRDataManager.h"
#import "TRCityGroupTableViewController.h"

static const CGFloat cellHeight = 50;
static const int cellCount = 2;

@interface TRLeftViewController ()<UITableViewDelegate, UITableViewDataSource>
//存储cell文本数组
@property (nonatomic, strong) NSArray *cellTextArray;
//存储cell图片名字
@property (nonatomic, strong) NSArray *cellImageArray;
@end

@implementation TRLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //验证城市组数组
    //NSArray *cityArray = [TRDataManager getAllCityGroups];
    
    self.cellTextArray = @[@"切换城市", @"其他"];
    self.cellImageArray = @[@"IconSettings", @"IconProfile"];
    
    //创建/添加tableView
    [self createTableView];
}
- (void)createTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (SCREEN_HEIGHT-cellHeight*cellCount)/2, SCREEN_WIDTH, cellHeight*cellCount)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor clearColor];
    //设置seperatorStyle
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
}

#pragma mark - Delegate / DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return cellCount;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = self.cellTextArray[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:self.cellImageArray[indexPath.row]];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return cellHeight;
}

//点中“切换城市”触发方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        //创建城市组对象;显示
        TRCityGroupTableViewController *cityGroupController = [TRCityGroupTableViewController new];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:cityGroupController];
        [self presentViewController:navController animated:YES completion:nil];
    }
}







@end
