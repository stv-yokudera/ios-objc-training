//
//  WeatherHacksAPI.m
//  ios-objc-training-2.4.2
//
//  Created by OkuderaYuki on 2017/09/15.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

#import "APIClient.h"
#import "WeatherHacksAPI.h"

@interface WeatherHacksAPI ()
@property (nonatomic) WeatherHacksAPIResponse *response;
@end

static NSString *const baseUrlString = @"http://weather.livedoor.com/forecast/webservice/json/v1";
@implementation WeatherHacksAPI

#pragma mark - initializer

- (instancetype)initWithCityId:(NSInteger)cityId {
    self = [super init];
    if (self) {
        self.cityId = cityId;
    }
    return self;
}

#pragma mark - public methods

- (void)load {
    
    __weak typeof(self) wself = self;
    [APIClient getRequest:baseUrlString parameters:[self parameters] success:^(id responseObject) {
        NSLog(@"%@", responseObject);
        wself.response = [[WeatherHacksAPIResponse alloc] initWithResponseObject:responseObject];
        [wself.delegate didSuccess:wself.response];
        
    } failure:^(NSError *error) {
        [wself.delegate didFailure:error];
    }];
}

#pragma mark - private methods

/**
 リクエストパラメータ生成

 @return リクエストパラメータ(NSDictionary<NSString *, NSString *> *)
 */
- (NSDictionary<NSString *, NSString *> *)parameters {
    return @{
             @"city": @(self.cityId).stringValue
             };
}

@end
