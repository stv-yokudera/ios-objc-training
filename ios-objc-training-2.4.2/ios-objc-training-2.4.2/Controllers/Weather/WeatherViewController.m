//
//  WeatherViewController.m
//  ios-objc-training-2.4.2
//
//  Created by OkuderaYuki on 2017/09/15.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

#import "Forecast.h"
#import "ForecastCell.h"
#import "WeatherHacksAPI.h"
#import "WeatherViewController.h"

@interface WeatherViewController () <WeatherHacksAPIDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic) WeatherHacksAPI *weatherHacksAPI;
@property (nonatomic) NSArray<Forecast *> *forecasts;
@property (nonatomic) NSString *sectionTitle;
@end

@implementation WeatherViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@ [LINE: %d] %s", [self class], __LINE__, __FUNCTION__);
    [self setup];
}

#pragma mark - private methods

- (void)setup {
    NSLog(@"%@ [LINE: %d] %s", [self class], __LINE__, __FUNCTION__);
    
    self.weatherHacksAPI = [[WeatherHacksAPI alloc] initWithCityId:130010];
    self.weatherHacksAPI.delegate = self;
    [self.weatherHacksAPI load];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%@ [LINE: %d] %s", [self class], __LINE__, __FUNCTION__);
    
    return self.forecasts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@ [LINE: %d] %s", [self class], __LINE__, __FUNCTION__);
    
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSLog(@"%@ [LINE: %d] %s", [self class], __LINE__, __FUNCTION__);
    
    return self.sectionTitle;
}

#pragma mark - WeatherHacksAPIDelegate

- (void)didSuccess:(WeatherHacksAPIResponse *)response {
    NSLog(@"%@ [LINE: %d] %s", [self class], __LINE__, __FUNCTION__);
    
    NSString *weatherSummary = NSLocalizedString(@"Weather_Summary", nil);
    self.textView.text = [NSString stringWithFormat:weatherSummary, response.text];
    
    self.sectionTitle = response.title;
    self.forecasts = response.forecasts;
    [self.tableView reloadData];
    
}

- (void)didFailure:(NSError *)error {
    NSLog(@"%@ [LINE: %d] %s", [self class], __LINE__, __FUNCTION__);
    
    NSLog(@"error: %@", error);
}

@end
