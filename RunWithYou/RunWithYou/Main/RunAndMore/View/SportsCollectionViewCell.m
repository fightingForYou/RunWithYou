//
//  SportsCollectionViewCell.m
//  RUNwithu
//
//  Created by mty on 15/9/7.
//  Copyright (c) 2015年 mty. All rights reserved.
//

#import "SportsCollectionViewCell.h"
//#import "UIImageView+WebCache.h"

@implementation SportsCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)setSportsModel:(SportsModel *)sportsModel {
    
    
    if (_sportsModel != sportsModel) {
        
        _sportsModel = sportsModel;
    }
    
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.nameLabel.text = self.sportsModel.name;
    
    self.iconImgView.image = [UIImage imageNamed:self.sportsModel.icon];
    
    NSLog(@"%@",self.iconImgView.image);
}







@end
