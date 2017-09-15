//
//  ViewController.m
//  ios-objc-training-2.4.2
//
//  Created by OkuderaYuki on 2017/09/15.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

#import "Forecast.h"
#import "ForecastCell.h"
#import "ViewController.h"
#import "WeatherHacksAPI.h"

@interface ViewController () <WeatherHacksAPIDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic) WeatherHacksAPI *weatherHacksAPI;
@property (nonatomic) NSArray<Forecast *> *forecasts;
@end

@implementation ViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

#pragma mark - private methods

- (void)setup {
    self.weatherHacksAPI = [[WeatherHacksAPI alloc] initWithCityId:130010];
    self.weatherHacksAPI.delegate = self;
    [self.weatherHacksAPI load];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.forecasts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ForecastCell *cell = (ForecastCell *)[tableView dequeueReusableCellWithIdentifier:[ForecastCell identifier]
                                                                         forIndexPath:indexPath];
    
    cell.forecastImageView.image = nil;
    
    __weak typeof(self) wself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL: wself.forecasts[indexPath.row].imageURL];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.forecastImageView.image = [UIImage imageWithData:imageData];;
            [cell layoutSubviews];
        });
    });
    
    cell.dateLabel.text = self.forecasts[indexPath.row].dateString;
    cell.telopLabel.text = self.forecasts[indexPath.row].telop;
    
    return cell;
}

#pragma mark - WeatherHacksAPIDelegate

- (void)didSuccess:(WeatherHacksAPIResponse *)response {
    NSLog(@"forecasts: %@", response.forecasts);
    NSLog(@"text: %@", response.text);
    
    self.forecasts = response.forecasts;
    [self.tableView reloadData];
    self.textView.text = response.text;
}

- (void)didFailure:(NSError *)error {
    NSLog(@"error: %@", error);
}

@end
