//
//  MotionServer.m
//  RUNwithu
//
//  Created by 冲锋只需勇气 on 15/9/9.
//  Copyright (c) 2015年 mty. All rights reserved.
//

#import "MotionServer.h"

@implementation MotionServer


+ (instancetype)shareMotionServer{
    
    static MotionServer* motionServer = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        motionServer = [[[self class] alloc] init];
    });
    
    return motionServer;
}


- (void)beginRunning{

    pedometer = [[CMPedometer alloc] init];
    if ([CMPedometer isStepCountingAvailable]) {
        NSLog(@"Yes");
    }else{
        NSLog(@"No");
    }
    _begindate = [[NSDate alloc] init];
    
    [pedometer startPedometerUpdatesFromDate:_begindate
                                 withHandler:^(CMPedometerData *pedometerData, NSError *error) {
                                     
                                     if (error) {
                                         NSLog(@"%@",error);
                                     }
                                 }];
    
    //启动定时器，每一秒查看一次总步数
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateAction) userInfo:nil repeats:YES];
    
}

//每一秒回报一次记录步数，对数据使用block方法
- (void)updateAction{
    
    NSDate* dateNow = [[NSDate alloc] init];
    [pedometer queryPedometerDataFromDate:_begindate toDate:dateNow withHandler:^(CMPedometerData *pedometerData, NSError *error) {
        NSNumber* number = pedometerData.numberOfSteps;
        NSInteger stemps = number.integerValue;
        NSLog(@"%ld",stemps);
        
        //set方法重写了
        [self setNowstep:stemps];
    }];

}

- (void)setNowstep:(NSInteger)nowstep{
    
    if (!(nowstep == _nowstep)) {
        
        _nowstep = nowstep;
        
        NSNumber* temp = [NSNumber numberWithUnsignedInteger:nowstep];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"nowStepChanged" object:temp];
        
    }
}






@end
