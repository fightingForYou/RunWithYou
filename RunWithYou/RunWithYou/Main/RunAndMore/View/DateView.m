//
//  DateView.m
//  RUNwithu
//
//  Created by mty on 15/9/8.
//  Copyright (c) 2015年 mty. All rights reserved.
//

#import "DateView.h"

@implementation DateView



- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self _createDatePicker];
    }
    
    return self;
    
}


- (void)_createDatePicker {
    
    // UIDatePickerModeTime 显⽰示时间  UIDatePickerModeDate 显⽰示⽇日期
    
    
    // 添加button 点击button的时候 datePicker 消失
    UIButton *button = [[UIButton alloc] initWithFrame:self.bounds];
    
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:button];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 250, kWidth, 250)];
        
        _datePicker.datePickerMode = UIDatePickerModeDate;
        
        [button addSubview:_datePicker];

    }];
    
}

- (void)buttonAction:(UIButton *)button {
    
    _datePicker.hidden = YES;
    
    [_datePicker removeFromSuperview];
    
    [self removeFromSuperview];
    
}







/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
