//
//  SDBaseProgressView.m
//  SDProgressView
//
//  Created by aier on 15-2-19.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import "SDBaseProgressView.h"

@implementation SDBaseProgressView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = SDProgressViewBackgroundColor;
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    if (progress >= 1.0000001) {
        [self accomplishTarget];
    } else {
        [self setNeedsDisplay];
    }
    
}

- (void)accomplishTarget{
    
    NSLog(@"完成");
    self.progress = 1;
}

- (void)setCenterProgressText:(NSString *)text withAttributes:(NSDictionary *)attributes
{
    CGFloat xCenter = self.frame.size.width * 0.5;
    CGFloat yCenter = self.frame.size.height * 0.5;
    
    // 判断系统版本
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        CGSize strSize = [text sizeWithAttributes:attributes];
        CGFloat strX = xCenter - strSize.width * 0.5;
        CGFloat strY = yCenter - strSize.height * 0.5;
        [text drawAtPoint:CGPointMake(strX, strY) withAttributes:attributes];
    } else {
        CGSize strSize;
        NSAttributedString *attrStr = nil;
        if (attributes[NSFontAttributeName]) {
 
//            strSize = [text sizeWithFont:attributes[NSFontAttributeName]];
            NSLog(@"%@",attributes);
            attrStr = [[NSAttributedString alloc] initWithString:text attributes:attributes];
        } else {
            attrStr = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:[UIFont systemFontSize]]}];
        }
        
        CGFloat strX = xCenter - strSize.width * 0.5;
        CGFloat strY = yCenter - strSize.height * 0.5;
        
        [attrStr drawAtPoint:CGPointMake(strX, strY)];
    }
    
    
}

// 清除指示器
- (void)dismiss
{
    [self removeFromSuperview];
}

+ (id)progressView
{
    return [[self alloc] init];
}

@end
