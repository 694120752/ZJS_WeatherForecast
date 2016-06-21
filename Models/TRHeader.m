//
//  TRHeader.m
//  WeatherForecast
//
//  Created by 张精申 on 16/2/21.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRHeader.h"

@implementation TRHeader
+(TRHeader* )getHearData:(id)responseObject{
    return [[self alloc]getHearData:responseObject];
}
-(TRHeader* )getHearData:(id)responseObject{
    self.cityName = responseObject[@"data"][@"request"][0][@"query"];
//#warning 没图的话试试加个[0]太乱看不清了
    self.iconUrlStr=responseObject[@"data"][@"current_condition"][0][@"weatherIconUrl"][0][@"value"];
    self.weatherDesc = responseObject[@"data"][@"current_condition"][0][@"weatherDesc"][0][@"value"];
    NSString *currentTemp = responseObject[@"data"][@"current_condition"][0][@"temp_C"];
    self.weatherTemp = [NSString stringWithFormat:@"%@˚", currentTemp];
    self.maxTemp  = responseObject[@"data"][@"weather"][0][@"maxtempC"];
    self.minTemp  = responseObject[@"data"][@"weather"][0][@"mintempC"];
    
    
    return  self;
    
}
@end
