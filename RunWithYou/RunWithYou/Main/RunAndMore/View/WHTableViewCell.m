//
//  WHTableViewCell.m
//  RunWithYou
//
//  Created by 我真的不是傻逼 on 15/9/5.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "WHTableViewCell.h"

@implementation WHTableViewCell

- (void)layoutSubviews{
    [super layoutSubviews];
    _weight.text = _user.weight;
    _height.text = _user.height;
    _date.text = _user.currentTime;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
