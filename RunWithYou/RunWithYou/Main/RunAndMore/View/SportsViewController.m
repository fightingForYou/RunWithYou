//
//  SportsViewController.m
//  RUNwithu
//
//  Created by mty on 15/9/7.
//  Copyright (c) 2015年 mty. All rights reserved.
//

#import "SportsViewController.h"
#import "SportsCollectionViewCell.h"
#import "DetailSportsViewController.h"


static NSString *cellId = @"cell";

@interface SportsViewController ()

@end

@implementation SportsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self _createSubviews];
    
    [self _loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        
    }
    
    return self;
}

// 返回按钮 响应方法
- (void)itemBtnAction:(UIButton *)button {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)_createSubviews {
    
    // 设置返回按钮
    UIButton *itemBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    
    [itemBtn setTitle:@"选择运动" forState:UIControlStateNormal];
    itemBtn.backgroundColor = [UIColor lightGrayColor];
    itemBtn.layer.cornerRadius = 10;
    
    [itemBtn addTarget:self action:@selector(itemBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:itemBtn];
    
    
    // 创建 CollectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight) collectionViewLayout:layout];
    layout.itemSize = CGSizeMake((kWidth-20)/5,(kWidth)/5);
    
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
//    layout.minimumInteritemSpacing = 10;
//    
//    layout.minimumLineSpacing = 10;
    
    _collectionView.backgroundColor = [UIColor clearColor];
    
    _collectionView.delegate = self;
    
    _collectionView.dataSource = self;
    
    // 注册
    UINib *nib = [UINib nibWithNibName:@"SportsCollectionViewCell" bundle:[NSBundle mainBundle]];
    
    [_collectionView registerNib:nib forCellWithReuseIdentifier:cellId];
    
    [self.view addSubview:_collectionView];
    
}


#pragma mark - LoadData  解析数据

- (void)_loadData {

    _sportsModelArray = [[NSMutableArray alloc] init];
    
    NSString *file = [[NSBundle mainBundle] pathForResource:@"ActivityTypeList" ofType:@"plist"];
    
    NSArray *array = [[NSArray alloc] initWithContentsOfFile:file];
    
    for (NSDictionary *dic in array) {
        
        SportsModel *model = [[SportsModel alloc] init];
        
        [model setValuesForKeysWithDictionary:dic];
        
        [_sportsModelArray addObject:model];
    }
    
    [_collectionView reloadData];

}


#pragma mark - UICollectionView delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _sportsModelArray.count;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SportsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    
    cell.sportsModel = _sportsModelArray[indexPath.row];
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    // 点击对应的cell push到 下一个页面
    DetailSportsViewController *vc = [[DetailSportsViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:NO];
    
    SportsModel *model = _sportsModelArray[indexPath.row];
    
    // 将数据传给 DetailSportsViewController
    vc.sportsModel = model;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 20, 5, 0); // top, left, bottom, right
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
