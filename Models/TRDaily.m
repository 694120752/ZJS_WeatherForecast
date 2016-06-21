//
//  TRDaily.m
//  WeatherForecast
//
//  Created by tarena on 16/2/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRDaily.h"

@implementation TRDaily

+ (TRDaily *)parseDailyJson:(NSDictionary *)dic {
    return [[self alloc] parseDailyJson:dic];
}
- (TRDaily *)parseDailyJson:(NSDictionary *)dic {
    self.date = dic[@"date"];
    //option/alt + k => ˚
    self.maxTempC = [NSString stringWithFormat:@"%@˚", dic[@"maxtempC"]];
    self.mintempC = [NSString stringWithFormat:@"%@˚", dic[@"mintempC"]];
    self.iconUrl = dic[@"hourly"][0][@"weatherIconUrl"][0][@"value"];
    return self;
}








@end
