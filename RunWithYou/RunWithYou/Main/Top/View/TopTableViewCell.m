//
//  TopTableViewCell.m
//  RunWithYou
//
//  Created by 我真的不是傻逼 on 15/9/6.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "TopTableViewCell.h"
#import <UIImageView+WebCache.h>
@implementation TopTableViewCell

- (void)layoutSubviews{
    [super layoutSubviews];

    _userName.text = _user.name;
    _userNum.text = [NSString stringWithFormat:@"今日行走 %.0f步",_user.number];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
