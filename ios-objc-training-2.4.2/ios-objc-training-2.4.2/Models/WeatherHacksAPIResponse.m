//
//  WeatherHacksAPIResponse.m
//  ios-objc-training-2.4.2
//
//  Created by OkuderaYuki on 2017/09/16.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

#import "WeatherHacksAPIResponse.h"

@interface WeatherHacksAPIResponse()
@property (nonatomic, readwrite) NSMutableArray<Forecast *> *forecasts;
@property (nonatomic, readwrite) NSString *title;
@property (nonatomic, readwrite) NSString *text;
@end

@implementation WeatherHacksAPIResponse

#pragma mark - initializer

- (instancetype)initWithResponseObject:(NSDictionary<NSString *, id> *)responseObject {
    self = [super init];
    if (self) {
        
        self.forecasts = [@[] mutableCopy];
        for (NSDictionary<NSString *, id> *forecastDic in responseObject[@"forecasts"]) {
            Forecast *forecast = [Forecast new];
            forecast.dateString = forecastDic[@"date"];
            forecast.telop = forecastDic[@"telop"];
            forecast.imageURL = [NSURL URLWithString:forecastDic[@"image"][@"url"]];
            [self.forecasts addObject:forecast];
        }
        self.title = responseObject[@"title"];
        self.text = responseObject[@"description"][@"text"];
    }
    return self;
}
@end
