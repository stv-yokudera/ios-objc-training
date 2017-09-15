//
//  APIClient.h
//  ios-objc-training-2.4.2
//
//  Created by OkuderaYuki on 2017/09/15.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIClient : NSObject

/**
 GETリクエスト

 @param urlString リクエストURL
 @param parameters リクエストパラメータ
 @param success 成功時のハンドラー (void (^)(id responseObject))
 @param failure 失敗時のハンドラー (void (^)(NSError *error))
 */
+ (void)getRequest:(NSString *)urlString
        parameters:(id)parameters
           success:(void (^)(id responseObject))success
           failure:(void (^)(NSError *error))failure;
@end
