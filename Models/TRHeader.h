//
//  TRHeader.h
//  WeatherForecast
//
//  Created by 张精申 on 16/2/21.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRHeader : NSObject
@property(nonatomic,strong)NSString* cityName;
@property(nonatomic,strong)NSString* iconUrlStr;
@property(nonatomic,strong)NSString* weatherDesc;
@property(nonatomic,strong)NSString* weatherTemp;
@property(nonatomic,strong)NSString* maxTemp;
@property(nonatomic,strong)NSString* minTemp;
+(TRHeader* )getHearData:(id)responseObject;
@end
