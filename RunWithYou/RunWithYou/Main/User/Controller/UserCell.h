//
//  UserCell.h
//  RUNwithu
//
//  Created by 揽揽揽 on 15/9/8.
//  Copyright (c) 2015年 mty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *target;
@property (weak, nonatomic) IBOutlet UILabel *targetInform;
@property (weak, nonatomic) IBOutlet UIImageView *viewImage;
@property (weak, nonatomic) IBOutlet UILabel *nextTarget;

@end
