//
//  UserViewController.h
//  RunWithYou
//
//  Created by 卡神 on 15/8/27.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "BaseViewController.h"
#import "UserCell.h"
#import "UIViewExt.h"
@interface UserViewController : BaseViewController
<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UICollectionView *_collectionView;
}
@end
