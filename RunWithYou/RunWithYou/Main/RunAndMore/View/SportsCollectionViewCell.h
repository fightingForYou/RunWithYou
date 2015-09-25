//
//  SportsCollectionViewCell.h
//  RUNwithu
//
//  Created by mty on 15/9/7.
//  Copyright (c) 2015年 mty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SportsModel.h"

@interface SportsCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) SportsModel *sportsModel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;



@end
