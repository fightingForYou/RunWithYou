//
//  RunViewController.m
//  RunWithYou
//
//  Created by 卡神 on 15/8/27.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "RunViewController.h"
#import "WHTableViewCell.h"
#import "User.h"
@interface RunViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_userArray;
    NSMutableArray *_saveArray;
    InputView *view;
}
@end

@implementation RunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _userArray = [[NSMutableArray alloc] init];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"saveArray"]) {
        _saveArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"saveArray"];
        for (NSDictionary *dic in _saveArray) {
            User *user = [[User alloc] init];
            user.weight = [dic objectForKey:@"myWeight"];
            user.height = [dic objectForKey:@"myHeight"];
            user.currentTime = [dic objectForKey:@"time"];
            [_userArray addObject:user];
        }
    }
    else {
        _saveArray = [[NSMutableArray alloc] init];
    }
    
    [self createTable];
    // Do any additional setup after loading the view.
}

- (void)createTable{
    UIButton *add = [[UIButton alloc] initWithFrame:CGRectMake((kWidth - 80)/2, 25, 80, 30)];
    [add setTitle:@"记录体重" forState:UIControlStateNormal];
    add.backgroundColor = [UIColor grayColor];
    add.layer.cornerRadius = 10;
    [add addTarget:self action:@selector(addWH) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:add];
    
    UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(20, 25, 50, 30)];
    [back setTitle:@"返回" forState:UIControlStateNormal];
    back.backgroundColor = [UIColor lightGrayColor];
    back.layer.cornerRadius = 10;
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:back];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 80, kWidth, kHeight-80-49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UINib *nib = [UINib nibWithNibName:@"WHTableViewCell" bundle:[NSBundle mainBundle]];
    [_tableView registerNib:nib forCellReuseIdentifier:@"WHCell"];
    [self.view addSubview:_tableView];
}

- (void)back{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [view hide];
}

- (void)addWH{
    view = [[InputView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    [self getTime];
    __weak RunViewController *weakSelf = self;
    view.block = ^(NSString *weight,NSString *height){
        RunViewController *strongSelf = weakSelf;
        User *user = [[User alloc] init];
        user.weight = weight;
        user.height = height;
        user.currentTime = weakSelf.currentTime;
        [strongSelf -> _userArray insertObject:user atIndex:0];
        [strongSelf -> _tableView reloadData];
        
        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:weight,@"myWeight",height,@"myHeight",weakSelf.currentTime,@"time", nil];
        [strongSelf -> _saveArray addObject:dic];
        [[NSUserDefaults standardUserDefaults] setObject:strongSelf -> _saveArray forKey:@"saveArray"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    };
    [view show];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WHCell" forIndexPath:indexPath];
    cell.user = _userArray[indexPath.row];
    cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"weather.jpeg"]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_userArray count];
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
- (void)getTime{
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    _currentTime = [NSString stringWithFormat:@"%li年%li月%li日",[dateComponent year],[dateComponent month],[dateComponent day]];
}

@end
