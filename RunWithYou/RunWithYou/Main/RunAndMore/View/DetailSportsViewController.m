//
//  DetailSportsViewController.m
//  RUNwithu
//
//  Created by mty on 15/9/7.
//  Copyright (c) 2015年 mty. All rights reserved.
//

#import "DetailSportsViewController.h"
#import "DateView.h"
#import "TimeView.h"

@interface DetailSportsViewController () {
    
    UILabel *_dateLabel; // 日期Label
    
    UILabel *_timeLabel; // 时间Label
    
    UIView *_deletionOrcompletionView; // 创建取消视图以及确定视图
    
    UIButton *_deletionBtn; // 取消按钮
    
    UIButton *_completionBtn; // 确定按钮
}


@end

@implementation DetailSportsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self _createNavigationItem];
    
    [self _createSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -  自定制左边按钮 以及 响应方法

// 自定义左侧按钮
- (void)_createNavigationItem {
    
    NSString *title = self.sportsModel.name;
    
    // 自定义左侧按钮
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]
                                  initWithTitle:title
                                  style:UIBarButtonItemStylePlain
                                  target:self
                                  action:@selector(popButtonAction:)];
    // 设置导航栏右侧按钮
    self.navigationItem.leftBarButtonItem = leftItem;
}

//  左边按钮 响应方法
- (void)popButtonAction:(UIButton *)button {
    
    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark - 创建子视图
- (void)_createSubviews {
    
    // 日期Label
    _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, kWidth/2-20, 100)];
    
    _dateLabel.backgroundColor = [UIColor orangeColor];
    
    _dateLabel.textAlignment = NSTextAlignmentCenter;
    
    _dateLabel.text = @"2015年9月8日";
    
    [self.view addSubview:_dateLabel];
    
    // 添加button 覆盖在Label上
    UIButton *dateBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, kWidth/2-20, 100)];
    
    dateBtn.backgroundColor = [UIColor clearColor];
    
    [dateBtn addTarget:self action:@selector(showDate:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:dateBtn];
    
    
    // 时间Label
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kWidth/2, 100, kWidth/2-10, 100)];
    
    _timeLabel.backgroundColor = [UIColor orangeColor];
    
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    
    _timeLabel.text = @"17:00";
    
    [self.view addSubview:_timeLabel];
    
    // 添加button 覆盖在Label上
    UIButton *timeBtn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth/2, 100, kWidth/2-10, 100)];
    
    timeBtn.backgroundColor = [UIColor clearColor];
    
    timeBtn.tag = 101;
    
    [timeBtn addTarget:self action:@selector(showTime:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:timeBtn];
    
    
    // 创建取消视图以及确定视图
    _deletionOrcompletionView = [[UIView alloc] initWithFrame:CGRectMake(0, 500, kWidth, 100)];
    
    [self.view addSubview:_deletionOrcompletionView];
    
    // 取消按钮
    _deletionBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, kWidth/2-20, 100)];
    
    [_deletionBtn setTitle:@"取消" forState:UIControlStateNormal];
    
    _deletionBtn.backgroundColor = [UIColor orangeColor];
    
    [_deletionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [_deletionBtn addTarget:self action:@selector(deletionBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_deletionOrcompletionView addSubview:_deletionBtn];
    
    // 确定按钮
    _completionBtn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth/2, 0, kWidth/2-10, 100)];
    
    [_completionBtn setTitle:@"完成" forState:UIControlStateNormal];
    
    _completionBtn.backgroundColor = [UIColor orangeColor];
    
    [_completionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [_completionBtn addTarget:self action:@selector(completionBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_deletionOrcompletionView addSubview:_completionBtn];
}

#pragma mark - button 响应方法
// 日期button响应方法
- (void)showDate:(UIButton *)button {
   
    NSLog(@"showDate");
    
    DateView *dateView = [[DateView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    
    dateView.backgroundColor = [UIColor lightGrayColor];
    
    dateView.alpha = 0.7;
    
    [self.view addSubview:dateView];
}

// 时间button响应方法
- (void)showTime:(UIButton *)button {
    
    NSLog(@"showTime");
    
    TimeView *timeView = [[TimeView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    
    timeView.backgroundColor = [UIColor lightGrayColor];
    
    timeView.alpha = 0.7;
    
    [self.view addSubview:timeView];

}

// 取消按钮
- (void)deletionBtnAction:(UIButton *)button {
    
    [self.navigationController popViewControllerAnimated:YES];
}

// 确定按钮 (可以用HUD试一下)
- (void)completionBtnAction:(UIButton *)button {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"活动添加成功" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alertView show];
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
