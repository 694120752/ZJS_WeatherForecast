//
//  TRNetworkManager.m
//  WeatherForecast
//
//  Created by tarena on 16/2/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRNetworkManager.h"
#import "AFNetworking.h"

@implementation TRNetworkManager

+ (void)sendRequestWithUrl:(NSString *)urlStr parameters:(NSDictionary *)dic success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlStr parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //服务器成功返回
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //失败
        failure(error);
    }];
    
    
}







@end
