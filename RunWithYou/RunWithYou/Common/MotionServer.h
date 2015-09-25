//
//  MotionServer.h
//  RUNwithu
//
//  Created by 冲锋只需勇气 on 15/9/9.
//  Copyright (c) 2015年 mty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>
typedef void(^runType)(NSInteger step);

@interface MotionServer : NSObject
{
    CMPedometer* pedometer;
}

@property(nonatomic,strong)NSDate* begindate;
@property(nonatomic,strong)NSTimer* timer;

@property(nonatomic,assign)NSInteger nowstep;
@property(nonatomic,copy)runType block;

+ (instancetype)shareMotionServer;

- (void)beginRunning;

@end
