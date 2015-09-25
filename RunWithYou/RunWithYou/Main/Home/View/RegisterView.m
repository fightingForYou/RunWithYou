//
//  RegisterView.m
//  RunWithYou
//
//  Created by 我真的不是傻逼 on 15/9/10.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "RegisterView.h"
#import <AVOSCloud/AVOSCloud.h>

@implementation RegisterView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView{
    self.backgroundColor = [UIColor orangeColor];
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(50, 70, 50, 50)];
    UILabel *password = [[UILabel alloc] initWithFrame:CGRectMake(50, 130, 50, 50)];
    name.text = @"账号:";
    password.text = @"密码:";
    
    userName = [[UITextField alloc] initWithFrame:CGRectMake(120, 80, 120, 35)];
    userName.backgroundColor = [UIColor whiteColor];
    userPassword = [[UITextField alloc] initWithFrame:CGRectMake(120, 140, 120, 35)];
    userPassword.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(250/2, 235, 50, 50)];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:name];
    [self addSubview:password];
    [self addSubview:userName];
    [self addSubview:userPassword];
    [self addSubview:btn];
}

- (void)btnAction{
    if (userName.text.length > 0 && userPassword.text.length > 0) {
        AVUser *user = [AVUser user];
        user.username = userName.text;
        user.password = userPassword.text;
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"注册成功");
            } else {
                NSLog(@"%@",error);
            }
        }];
    }

    [self removeFromSuperview];
}

- (void)show{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGPoint p = window.center;
    p.y -= 50;
    self.center = p;
    [window addSubview:self];
    self.transform = CGAffineTransformMakeScale(.6, .6);
    [UIView animateWithDuration:.2 animations:^{
        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    } completion:^(BOOL finished) {
        if (finished) {
            self.transform = CGAffineTransformMakeScale(1, 1);
        }
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
