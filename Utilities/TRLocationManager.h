//
//  TRLocationManager.h
//  Demo03-GetLocation
//
//  Created by tarena on 16/2/17.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface TRLocationManager : NSObject

//用户的经纬度
+ (void)getUserLocation:(void(^)(double lat, double log))locationBlock;

//用户的城市的名字(反地理编码)
+ (void)getUserCityName:(void(^)(NSString *cityName))cityBlock;










@end
