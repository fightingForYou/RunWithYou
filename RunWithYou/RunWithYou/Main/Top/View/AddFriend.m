//
//  AddFriend.m
//  RunWithYou
//
//  Created by 我真的不是傻逼 on 15/9/11.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "AddFriend.h"
#import "RegexKitLite.h"
#import <AVOSCloud/AVOSCloud.h>
@implementation AddFriend

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return  self;
}

- (void)createView{
    self.backgroundColor = [UIColor orangeColor];
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(50, 70, 100, 50)];
    name.text = @"输入昵称:";
    
    friendName = [[UITextField alloc] initWithFrame:CGRectMake(120, 80, 120, 35)];
    friendName.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(250/2, 235, 50, 50)];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:name];
    [self addSubview:friendName];

    [self addSubview:btn];
}

- (void)btnAction{
    AVQuery *query = [AVQuery queryWithClassName:@"_User"];
    [query whereKey:@"username" equalTo:friendName.text];
    AVUser *user = [AVUser currentUser];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            if (objects.count > 0) {
                AVUser *u = objects[0];
                 AVObject *userFriend = [query getObjectWithId:u.objectId];
                NSNumber *n = [userFriend objectForKey:@"number"];
                AVObject *me = [AVObject objectWithClassName:user.username];
                [me setObject:friendName.text forKey:@"name"];
                [me setObject:n forKey:@"number"];
                [me save];
                [[NSNotificationCenter defaultCenter] postNotificationName:viewRemove object:nil];
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"没有此用户" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
    }];
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
