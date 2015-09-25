//
//  InputView.m
//  RunWithYou
//
//  Created by 我真的不是傻逼 on 15/9/5.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "InputView.h"

@implementation InputView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView{
    self.backgroundColor = [UIColor orangeColor];
    UILabel *weight = [[UILabel alloc] initWithFrame:CGRectMake(50, 70, 50, 50)];
    UILabel *height = [[UILabel alloc] initWithFrame:CGRectMake(50, 130, 50, 50)];
    weight.text = @"体重:";
    height.text = @"身高:";
    
    _weight = [[UITextField alloc] initWithFrame:CGRectMake(120, 80, 120, 35)];
    _weight.backgroundColor = [UIColor whiteColor];
    _height = [[UITextField alloc] initWithFrame:CGRectMake(120, 140, 120, 35)];
    _height.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(250/2, 190, 50, 50)];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:weight];
    [self addSubview:height];
    [self addSubview:_weight];
    [self addSubview:_height];
    [self addSubview:btn];
}

- (void)btnAction{
    if (_block) {
        if (_weight.text.length > 0 && _height.text.length > 0) {
            _block(_weight.text,_height.text);
        }
    }
    [self hide];
}

- (void)hide {
    
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
