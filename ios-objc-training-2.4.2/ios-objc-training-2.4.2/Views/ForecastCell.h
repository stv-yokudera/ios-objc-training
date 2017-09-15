//
//  ForecastCell.h
//  ios-objc-training-2.4.2
//
//  Created by OkuderaYuki on 2017/09/15.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForecastCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *telopLabel;
@property (weak, nonatomic) IBOutlet UIImageView *forecastImageView;

/**
 * cellのidentifierを取得する
 *
 * (reuse identifierは、Cellクラスのクラス名と合わせる前提)
 *
 * @return cell identifier
 */
+ (NSString *)identifier;
@end
