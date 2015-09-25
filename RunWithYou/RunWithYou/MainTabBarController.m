//
//  MainTabBarController.m
//  RunWithYou
//
//  Created by 卡神 on 15/8/27.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "MainTabBarController.h"
#import "MyButton.h"
#import "FuncView.h"
#import "BaseViewController.h"

@interface MainTabBarController ()
{
    UIImageView *_tabBar;
    UIImageView *_selectedImage;
    FuncView *_funcView; // 添加在window上的半透明视图
}
@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createViewController];
    [self createTabBar];
    // Do any additional setup after loading the view.
}

- (void)createViewController{
    NSArray *vcName = @[@"Home",@"Top",@"Run",@"User",@"Set"];
    NSMutableArray *storyBoard = [[NSMutableArray alloc] init];
    for (NSString *name in vcName) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:name bundle:nil];
        BaseViewController *vc = [story instantiateInitialViewController];
        [storyBoard addObject:vc];
    }
    self.selectIndex = 0;
    self.viewControllers = storyBoard;
}

- (void)createTabBar{
    
    for (UIView *view in self.tabBar.subviews) {
        Class clc = NSClassFromString(@"UIBarButton");
        if ([view isKindOfClass:clc]) {
            [view removeFromSuperview];
        }
    }
    _tabBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 49)];
    _tabBar.contentMode = UIViewContentModeScaleAspectFill;
    //imageview的交互要打开
    _tabBar.userInteractionEnabled = YES;
    [self.tabBar addSubview:_tabBar];
    
    NSArray *imgNames = @[ @"tabbar_home_highlighted@2x",
                             @"tabbar_discover_highlighted@2x",
                             @"tabbar_compose_background_icon_add@2x",
                             @"tabbar_profile_highlighted@2x",
                             @"tabbar_more_highlighted@2x"
                             ];
    
    _selectedImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth/5, 49)];
    _selectedImage.image = [UIImage imageNamed:@"background1.png"];
    [self.tabBar addSubview:_selectedImage];
    
    for (int i = 0; i < 5; i++) {
        MyButton *btn = [[MyButton alloc] initWithFrame:CGRectMake(i*kWidth/5, 0, kWidth/5, 49)];
        [btn setImage:[UIImage imageNamed:imgNames[i]] forState:UIControlStateNormal];
        btn.tag = i;
        [btn addTarget:self action:@selector(selectTab:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBar addSubview:btn];
    }
}

- (void)setSelectIndex:(NSInteger)selectIndex{
    if (_selectIndex != selectIndex) {
        _selectIndex = selectIndex;
    }
    if (selectIndex == 2) {
        
        // 在window上添加的半透明view
        _funcView = [[FuncView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,kScreenHeight)];
        
        _funcView.hidden = NO;
        
        _funcView.backgroundColor = [UIColor colorWithRed:34/255.0 green:49/255.0 blue:46/255.0 alpha:.8];
        //_funcView.alpha = .6;
        
        UIWindow *window =  [UIApplication sharedApplication].keyWindow;
        
        [window addSubview:_funcView];
        
        return;
    }
    
    else {
        
        _funcView.hidden = YES;
        
        [_funcView removeFromSuperview];
        
        _funcView = nil;
    }
    self.selectedIndex = _selectIndex;
}

- (void)selectTab:(UIButton *)btn{
    [UIView animateWithDuration:.2 animations:^{
        _selectedImage.center = btn.center;
    }];
    self.selectIndex = btn.tag;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
