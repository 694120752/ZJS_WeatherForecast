//
//  TRDataManager.m
//  WeatherForecast
//
//  Created by tarena on 16/2/19.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRDataManager.h"
#import "TRCityGroup.h"
#import "TRDaily.h"
#import "TRHourly.h"
@implementation TRDataManager
//plist中读数据
static NSArray * _cityGroups = nil;
+ (NSArray *)getAllCityGroups {
    if (!_cityGroups) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"cityGroups.plist" ofType:nil];
        NSArray *cityGroupArray = [NSArray arrayWithContentsOfFile:plistPath];
        NSMutableArray *mutableArray = [NSMutableArray array];
        for (NSDictionary *dic in cityGroupArray) {
            
            TRCityGroup *cityGroup = [TRCityGroup new];
            [cityGroup setValuesForKeysWithDictionary:dic];
            [mutableArray addObject:cityGroup];
        }
        _cityGroups = [mutableArray copy];
    }
    return _cityGroups;
}

+ (NSArray *)getAllDailyData:(id)responseObject {
    //从resoponseObject取出weather对应值(数组)
    NSArray *weatherArray = responseObject[@"data"][@"weather"];
    //字典 -> TRDaily
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in weatherArray) {
        TRDaily *daily = [TRDaily parseDailyJson:dic];
        [array addObject:daily];
    }
    //返回
    return [array copy];
}

+ (NSArray *)getAllHourlyData:(id)responseObject{
    NSArray* hourlyArray=responseObject[@"data"][@"weather"][0][@"hourly"];
    NSMutableArray* mutableArray=[NSMutableArray array];
    for (NSDictionary* dic in hourlyArray) {
        TRHourly* hourly=[TRHourly parseHourlyJson:dic];
        [mutableArray addObject:hourly];
    }
    return [mutableArray copy];
}









@end
