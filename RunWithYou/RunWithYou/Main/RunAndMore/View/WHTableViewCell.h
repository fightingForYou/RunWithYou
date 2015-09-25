//
//  WHTableViewCell.h
//  RunWithYou
//
//  Created by 我真的不是傻逼 on 15/9/5.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@interface WHTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *weight;
@property (weak, nonatomic) IBOutlet UILabel *height;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (nonatomic, retain) User *user;
@end
