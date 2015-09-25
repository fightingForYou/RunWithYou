//
//  InputView.h
//  RunWithYou
//
//  Created by 我真的不是傻逼 on 15/9/5.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^type) (NSString *,NSString *);
@interface InputView : UIView
{
    UITextField *_weight;
    UITextField *_height;
}
@property (nonatomic, copy) type block;

- (void)show;
- (void)hide;
@end
