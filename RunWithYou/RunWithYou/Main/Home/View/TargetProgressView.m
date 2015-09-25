//
//  TargetProgressView.m
//  RUNwithu
//
//  Created by 冲锋只需勇气 on 15/9/6.
//  Copyright (c) 2015年 mty. All rights reserved.
//

#import "TargetProgressView.h"

@implementation TargetProgressView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius = self.width/2;
        [self.layer masksToBounds];
        self.backgroundColor = [UIColor colorWithRed:0.3 green:0.9 blue:0.8 alpha:1];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super initWithCoder:aDecoder]) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius = self.width/2;
        [self.layer masksToBounds];
    }
    
    return self;
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
