//
//  MyButton.m
//  RunWithYou
//
//  Created by 卡神 on 15/8/27.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "MyButton.h"

@implementation MyButton
- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake((kWidth/5-40)/2, 5, 40, 40);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
