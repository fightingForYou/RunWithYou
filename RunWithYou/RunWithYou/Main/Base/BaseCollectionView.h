//
//  BaseCollectionView.h
//  RunWithYou
//
//  Created by 我真的不是傻逼 on 15/9/1.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCollectionView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic,assign) CGFloat itemWidth;
@end
