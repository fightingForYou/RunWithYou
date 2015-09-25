//
//  HomeViewController.h
//  RunWithYou
//
//  Created by 卡神 on 15/8/27.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"
#import "TargetProgressView.h"
#import "MotionServer.h"
@interface HomeViewController : BaseViewController<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *targetValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *completedValueLabel;
@property (weak, nonatomic) IBOutlet TargetProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *todayTotalSteps;

@property (nonatomic,assign)NSInteger runningTarget;
@property (nonatomic,assign)NSInteger todayCompleted;


@property (nonatomic,assign,getter=isRunning)BOOL running;
@end
