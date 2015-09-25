//
//  TopTableViewCell.h
//  RunWithYou
//
//  Created by 我真的不是傻逼 on 15/9/6.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@interface TopTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userNum;
@property (weak, nonatomic) IBOutlet UILabel *num;

@property (nonatomic, retain)User *user;
@end
