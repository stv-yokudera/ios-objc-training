//
//  WeatherHacksAPI.h
//  ios-objc-training-2.4.2
//
//  Created by OkuderaYuki on 2017/09/15.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherHacksAPIResponse.h"

/**
 APIリクエスト結果をViewControllerに通知するデリゲート
 */
@protocol WeatherHacksAPIDelegate <NSObject>
- (void)didSuccess:(WeatherHacksAPIResponse *)response;
- (void)didFailure:(NSError *)error;
@end

@interface WeatherHacksAPI : NSObject

@property (weak, nonatomic) id<WeatherHacksAPIDelegate> delegate;
@property (nonatomic) NSInteger cityId;

- (instancetype)initWithCityId:(NSInteger)cityId;

/**
 APIリクエスト実行
 */
- (void)load;
@end
