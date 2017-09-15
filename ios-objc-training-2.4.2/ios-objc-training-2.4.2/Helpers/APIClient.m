//
//  APIClient.m
//  ios-objc-training-2.4.2
//
//  Created by OkuderaYuki on 2017/09/15.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

#import "APIClient.h"
#import "AFNetworking.h"

@implementation APIClient

+ (void)getRequest:(NSString *)urlString
        parameters:(id)parameters
           success:(void (^)(id responseObject))success
           failure:(void (^)(NSError *error))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlString
      parameters:parameters
        progress:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             success(responseObject);
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             failure(error);
         }];
}

@end
