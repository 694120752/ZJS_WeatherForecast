//
//  TRNetworkManager.h
//  WeatherForecast
//
//  Created by tarena on 16/2/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRNetworkManager : NSObject

//封装AFNetworking的get方法
+ (void)sendRequestWithUrl:(NSString *)urlStr parameters:(NSDictionary *)dic success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;










@end
