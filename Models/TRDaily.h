//
//  TRDaily.h
//  WeatherForecast
//
//  Created by tarena on 16/2/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRDaily : NSObject

//日期
@property (nonatomic, strong) NSString *date;
//最高
@property (nonatomic, strong) NSString *maxTempC;
//最低
@property (nonatomic, strong) NSString *mintempC;
//图标url
@property (nonatomic, strong) NSString *iconUrl;

//给定每天字典，返回解析好的每天对象
+ (TRDaily *)parseDailyJson:(NSDictionary *)dic;
















@end
