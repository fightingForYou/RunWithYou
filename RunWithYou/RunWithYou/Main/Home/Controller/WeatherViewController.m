//
//  WeatherViewController.m
//  RunWithYou
//
//  Created by 卡神 on 15/8/28.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "WeatherViewController.h"

@interface WeatherViewController ()
{
    NSDictionary *weatherDic;
}
@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"weather.jpeg"]];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"cityName"]) {
        self.cityName.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"cityName"];
        [self getData];
    }
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"9f27fa6b0bd84f835ec3c260db6fc2b2" forHTTPHeaderField: @"apikey"];
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
                               } else {
                                   weatherDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                   [self become];
                               }
                           }];
}

- (void)become{
    NSString *success = [weatherDic valueForKey:@"errMsg"];
    if ([success isEqualToString:@"success"]){
        NSDictionary *data = [weatherDic valueForKey:@"retData"];
        _weather.text = [data valueForKey:@"weather"];
        
        NSNumber *Htem = [data valueForKey:@"h_tmp"];
        _maxTem.text = [NSString stringWithFormat:@"%li",[Htem integerValue]];
        NSNumber *Ltem = [data valueForKey:@"l_tmp"];
        _minTem.text = [NSString stringWithFormat:@"%li",[Ltem integerValue]];
        
        _wind.text = [data valueForKey:@"WS"];
    }
    NSString *PMS = [weatherDic valueForKey:@"retMsg"];
    if ([PMS isEqualToString:@"success"]) {
        NSDictionary *data = [weatherDic valueForKey:@"retData"];
        _aqi.text = [[data objectForKey:@"aqi"] stringValue];
        _level.text = [data objectForKey:@"level"];
    }

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)getData{
    NSString *httpUrl = @"http://apis.baidu.com/apistore/weatherservice/cityname";
    NSString *part = [self.cityName.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *httpArg = [@"cityname=" stringByAppendingString:part];
    [self request: httpUrl withHttpArg: httpArg];
    
    
    NSString *httpPMUrl = @"http://apis.baidu.com/apistore/aqiservice/aqi";
    NSString *httpPMArg = [@"city=" stringByAppendingString:part];
    [self request: httpPMUrl withHttpArg: httpPMArg];
    [[NSUserDefaults standardUserDefaults] setObject:self.cityName.text forKey:@"cityName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)get:(id)sender {
    [self getData];
    
    [self.view endEditing:YES];

}
@end
