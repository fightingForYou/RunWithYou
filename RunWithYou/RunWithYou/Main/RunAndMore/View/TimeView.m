//
//  TimeView.m
//  RUNwithu
//
//  Created by mty on 15/9/8.
//  Copyright (c) 2015年 mty. All rights reserved.
//

#import "TimeView.h"

@implementation TimeView
//{
//    UIDatePicker *timePicker;
//}


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self _createTimePicker];
    }
    
    return self;
    
}


- (void)_createTimePicker {
    
    // UIDatePickerModeTime 显⽰示时间  UIDatePickerModeDate 显⽰示⽇日期
    
    // 添加button 点击button的时候 datePicker 消失
    UIButton *button = [[UIButton alloc] initWithFrame:self.bounds];
    
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:button];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _timePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 250, kWidth, 250)];

        _timePicker.datePickerMode = UIDatePickerModeTime;
        
        [button addSubview:_timePicker];
        
    }];
    

}

- (void)buttonAction:(UIButton *)button {
    
    _timePicker.hidden = YES;

    [_timePicker removeFromSuperview];
    
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
