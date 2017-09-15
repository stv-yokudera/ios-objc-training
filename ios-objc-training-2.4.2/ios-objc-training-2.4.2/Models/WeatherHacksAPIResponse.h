//
//  WeatherHacksAPIResponse.h
//  ios-objc-training-2.4.2
//
//  Created by OkuderaYuki on 2017/09/16.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Forecast.h"

@interface WeatherHacksAPIResponse : NSObject
@property (nonatomic) NSMutableArray<Forecast *> *forecasts;
@property (nonatomic) NSString *text;

- (instancetype)initWithResponseObject:(NSDictionary<NSString *, id> *)responseObject;
@end
