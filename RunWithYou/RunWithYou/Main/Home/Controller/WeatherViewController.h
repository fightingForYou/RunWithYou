//
//  WeatherViewController.h
//  RunWithYou
//
//  Created by 卡神 on 15/8/28.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *cityName;
@property (weak, nonatomic) IBOutlet UILabel *weather;
@property (weak, nonatomic) IBOutlet UILabel *maxTem;
@property (weak, nonatomic) IBOutlet UILabel *minTem;
@property (weak, nonatomic) IBOutlet UILabel *aqi;
@property (weak, nonatomic) IBOutlet UILabel *level;
@property (weak, nonatomic) IBOutlet UILabel *wind;
- (IBAction)get:(id)sender;

@end
