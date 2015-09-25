//
//  UserViewController.m
//  RunWithYou
//
//  Created by 卡神 on 15/8/27.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "UserViewController.h"
#import <AVOSCloud/AVOSCloud.h>
@interface UserViewController ()

@end

@implementation UserViewController

{
    UIImageView *_headerImageView;
    UIImageView *_iconImageView;
    UILabel *_userNameLabel;
    UILabel *_heightLabel;
    UILabel *_weightLabel;
    UILabel *_BMILabel;
    UILabel *_targetLabel;
    UILabel *_heightDataLabel;
    UILabel *_weightDataLabel;
    UILabel *_BMIDataLabel;
    UILabel *_targetDataLabel;
    UIButton *_setButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _createHeaderView];
    [self _createLabel];
    [self _createDataLabel];
    [self _createCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - CreateSubviews


- (void)_createHeaderView{
    _headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -320, kWidth, kHeight)];
    //自适应宽高比
    _headerImageView.contentMode = UIViewContentModeScaleAspectFit;
    [_headerImageView setImage:[UIImage imageNamed:@"headImage.jpg"]];
    [self.view addSubview:_headerImageView];
    
    _setButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 30, 30, 30)];
    [_setButton addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [_setButton setImage:[UIImage imageNamed:@"set.png"] forState:UIControlStateNormal];
    [self.view addSubview:_setButton];
    
    _iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kWidth/2-40, 70, 80, 80)];
    _iconImageView.image = [UIImage imageNamed:@"iconImage.jpg"];
    _iconImageView.layer.cornerRadius = 40;
    _iconImageView.layer.borderWidth = 1;
    _iconImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    _iconImageView.layer.masksToBounds = YES;
    
    //_headerImageView.bottom = _collectionView.top;
    [self.view addSubview:_iconImageView];
    
}

- (void)_createLabel{
    _heightLabel = [[UILabel alloc]initWithFrame:CGRectMake(15,160,80,20)];
    _heightLabel.text = @"身高";
    _heightLabel.textAlignment = NSTextAlignmentCenter;
    _heightLabel.font = [UIFont systemFontOfSize:15];
    _heightLabel.textColor = [UIColor blackColor];
    [self.view addSubview:_heightLabel];
    _heightLabel = [[UILabel alloc]initWithFrame:CGRectMake(110,160,80,20)];
    _heightLabel.text = @"体重";
    _heightLabel.textAlignment = NSTextAlignmentCenter;
    _heightLabel.font = [UIFont systemFontOfSize:15];
    _heightLabel.textColor = [UIColor blackColor];
    [self.view addSubview:_heightLabel];
    
    _heightLabel = [[UILabel alloc]initWithFrame:CGRectMake(200,160,80,20)];
    _heightLabel.text = @"BMI";
    _heightLabel.textAlignment = NSTextAlignmentCenter;
    _heightLabel.font = [UIFont systemFontOfSize:15];
    _heightLabel.textColor = [UIColor blackColor];
    [self.view addSubview:_heightLabel];
    
    _heightLabel = [[UILabel alloc]initWithFrame:CGRectMake(295,160,80,20)];
    _heightLabel.text = @"目标";
    _heightLabel.textAlignment = NSTextAlignmentCenter;
    _heightLabel.font = [UIFont systemFontOfSize:15];
    _heightLabel.textColor = [UIColor blackColor];
    [self.view addSubview:_heightLabel];
    
}
- (void)_createDataLabel{
    NSDictionary *myInfo = [[[NSUserDefaults standardUserDefaults] objectForKey:@"saveArray"] lastObject];
    AVUser *user = [AVUser currentUser];
    
    _userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWidth/2-30, 30, 60, 30)];
    _userNameLabel.text = user.username;
    _userNameLabel.highlighted = YES;
    _userNameLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:_userNameLabel];
    
    _heightDataLabel = [[UILabel alloc]initWithFrame:CGRectMake(15,175,80,20)];
    _heightDataLabel.text = [myInfo objectForKey:@"myHeight"];
    _heightDataLabel.textAlignment = NSTextAlignmentCenter;
    _heightDataLabel.font = [UIFont systemFontOfSize:15];
    _heightDataLabel.textColor = [UIColor blackColor];
    [self.view addSubview:_heightDataLabel];
    _heightDataLabel = [[UILabel alloc]initWithFrame:CGRectMake(110,175,80,20)];
    _heightDataLabel.text = [myInfo objectForKey:@"myWeight"];
    _heightDataLabel.textAlignment = NSTextAlignmentCenter;
    _heightDataLabel.font = [UIFont systemFontOfSize:15];
    _heightDataLabel.textColor = [UIColor blackColor];
    [self.view addSubview:_heightDataLabel];
    
    _heightDataLabel = [[UILabel alloc]initWithFrame:CGRectMake(200,175,80,20)];
    _heightDataLabel.text = @"19";
    _heightDataLabel.textAlignment = NSTextAlignmentCenter;
    _heightDataLabel.font = [UIFont systemFontOfSize:15];
    _heightDataLabel.textColor = [UIColor blackColor];
    [self.view addSubview:_heightDataLabel];
    
    _heightDataLabel = [[UILabel alloc]initWithFrame:CGRectMake(295,175,80,20)];
    _heightDataLabel.text = @"10000步";
    _heightDataLabel.textAlignment = NSTextAlignmentCenter;
    _heightDataLabel.font = [UIFont systemFontOfSize:15];
    _heightDataLabel.textColor = [UIColor blackColor];
    [self.view addSubview:_heightDataLabel];
}

- (void)btnAction{
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"设置" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"修改头像",@"修改目标", nil];
    [action showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        UIImagePickerController *vc = [[UIImagePickerController alloc] init];
        vc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        vc.delegate = self;
        [self presentViewController:vc animated:YES completion:nil];
    }
    if (buttonIndex == 1) {
        
    }
}

//选取完照片 显示
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    _iconImageView.image = img;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)_createCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(kWidth/2-10, kWidth/2-10);
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 200, kWidth, kHeight-200-49) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    
    //    [_collectionView registerClass:[UserCell class] forCellWithReuseIdentifier:@"cell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"UserCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:_collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    NSString *imageToLoad = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    [cell.viewImage setImage:[UIImage imageNamed:imageToLoad]];
    cell.target.text = [NSString stringWithFormat:@"kkkk"];
    return cell;
}


@end
