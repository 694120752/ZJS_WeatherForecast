//
//  TRHourly.m
//  WeatherForecast
//
//  Created by 张精申 on 16/2/21.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRHourly.h"

@implementation TRHourly
+(TRHourly* )parseHourlyJson:(NSDictionary*)dic{
    return [[self alloc]parseHourlyJson:dic];
}
-(TRHourly* )parseHourlyJson:(NSDictionary*)dic{
    NSString* iconUrl=dic[@"weatherIconUrl"][0][@"value"];
    self.iconUrl=iconUrl;
    int time=[dic[@"time"]intValue]/100;
    self.time=[NSString stringWithFormat:@"%d:00",time];
    NSString* tempC=dic[@"tempC"];
    self.tempC=[tempC stringByAppendingString:@"˚"];
    
    return  self;
}
@end
