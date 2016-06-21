//
//  TRHourly.h
//  WeatherForecast
//
//  Created by 张精申 on 16/2/21.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRHourly : NSObject
@property(nonatomic,strong)NSString* time;
@property(nonatomic,strong)NSString* tempC;
@property(nonatomic,strong)NSString* iconUrl;


+(TRHourly* )parseHourlyJson:(NSDictionary*)dic;

@end
