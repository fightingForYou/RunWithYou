//
//  HomeViewController.m
//  RunWithYou
//
//  Created by 卡神 on 15/8/27.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "HomeViewController.h"
#import "UAProgressView.h"
#import "AppDelegate.h"
#import <AVOSCloud/AVOSCloud.h>
#import "LogInView.h"
@interface HomeViewController ()
{
    MotionServer* _motionServer;
    NSDate* _beginDate;
    
}
@property (nonatomic, strong) UIView *centralView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.edgesForExtendedLayout = NO;
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser != nil) {
        // 允许用户使用应用
    } else {
        LogInView *view = [[LogInView alloc] initWithFrame:self.view.bounds];
        [view show];
    }
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"homeBG.jpg"]];
    [self _creatSubview];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receaveNotification:) name:@"nowStepChanged" object:nil];
    //[self createProgress];

    // Do any additional setup after loading the view.
}

- (void)leftAction{
    AppDelegate *myDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (myDelegate.LeftSlideVC.closed) {
        [myDelegate.LeftSlideVC openLeftView];
    }
    else {
        [myDelegate.LeftSlideVC closeLeftView];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    AppDelegate *myDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [myDelegate.LeftSlideVC setPanEnabled:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    AppDelegate *myDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [myDelegate.LeftSlideVC setPanEnabled:NO];
}

- (void)_creatSubview{
    
    self.targetValueLabel.text = @"0 step";
    self.completedValueLabel.text = @"0 step";
    
    [self _createNavigationItems];
    [self _creatMotionServer];
    
}

#pragma mark - 计步器通知处理
- (void)receaveNotification:(NSNotification*)notification{
    
    float nowsteps = [[notification object] floatValue];
    NSLog(@"%f",nowsteps);
    
    float progress = nowsteps/self.runningTarget;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.progressView.progress = progress;
        self.completedValueLabel.text = [NSString stringWithFormat:@"%.0f",nowsteps];
        AVUser *user = [AVUser currentUser];
        [user setObject:[NSNumber numberWithFloat:nowsteps] forKey:@"number"];
        [user save];
    });
    
}


#pragma mark - CreateSubviews

- (void)_createNavigationItems {
    
    
    //NavigationBar Items
    UIButton *calendarBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [calendarBtn setImage:[UIImage imageNamed:@"home_run"] forState:UIControlStateNormal];
    [calendarBtn addTarget:self action:@selector(runBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* calendarItem = [[UIBarButtonItem alloc] initWithCustomView:calendarBtn];
    self.navigationItem.rightBarButtonItem = calendarItem;
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    UIButton *left = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 30, 30)];
    [left setImage:[UIImage imageNamed:@"weather"] forState:UIControlStateNormal];
    //leftLabel.textColor = [UIColor whiteColor];
    [leftView addSubview:left];
    UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftAction)];
    [leftView addGestureRecognizer:leftTap];
    [left addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftView];
}

#pragma mark - NavigationBtn 按钮响应方法

- (void)runBtnAction:(UIButton *)button {
    
    if (!self.isRunning) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"制定计划" message:@"本次运动目标步数为" delegate:self cancelButtonTitle:@"我不跑啦" otherButtonTitles:@"确定", nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alert show];
        
    }else{
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"不跑了吗？" message:@"停止跑步" delegate:self cancelButtonTitle:@"我还要跑" otherButtonTitles:@"确定", nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1 && !self.isRunning) {
        //获取设定的目标运动距离
        UITextField* fl = [alertView textFieldAtIndex:0];
        _runningTarget = fl.text.integerValue;
        //设定计步器方法
        
        self.targetValueLabel.text = [NSString stringWithFormat:@"%ld step",_runningTarget];
        
        [_motionServer beginRunning];
        _running = YES;
    }else if(buttonIndex == 1 && self.isRunning){
        
        [_motionServer.timer invalidate];
        
        self.todayCompleted += _motionServer.nowstep;
        _motionServer.nowstep = 0;
    
        self.todayTotalSteps.text = [NSString stringWithFormat:@" %ld 步",_todayCompleted];
        
        self.running = NO;
        
       
    }
     [self resignFirstResponder];
}

#pragma mark - 计步器

- (void)_creatMotionServer{
    
    _motionServer = [MotionServer shareMotionServer];
    
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

@end
