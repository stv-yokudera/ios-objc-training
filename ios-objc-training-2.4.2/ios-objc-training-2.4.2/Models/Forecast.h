//
//  Forecast.h
//  ios-objc-training-2.4.2
//
//  Created by OkuderaYuki on 2017/09/15.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Forecast : NSObject
@property (nonatomic) NSString *dateString;
@property (nonatomic) NSString *telop;
@property (nonatomic) NSURL *imageURL;
@end
