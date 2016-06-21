//
//  TRDataManager.h
//  WeatherForecast
//
//  Created by tarena on 16/2/19.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRDataManager : NSObject
+ (NSArray *)getAllCityGroups;
+ (NSArray *)getAllDailyData:(id)responseObject;
+ (NSArray *)getAllHourlyData:(id)responseObject;






@end
