//
//  TopViewController.m
//  RunWithYou
//
//  Created by 卡神 on 15/8/27.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "TopViewController.h"
#import "TopTableViewCell.h"
#import "AddFriend.h"
#import <AVOSCloud/AVOSCloud.h>

@interface TopViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *_userArray;
}
@end

@implementation TopViewController

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:viewRemove object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewWillRemove:) name:viewRemove object:nil];
    [self createTable];
    [self loadData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receaveNotification:) name:@"nowStepChanged" object:nil];

    // Do any additional setup after loading the view.
}

- (void)receaveNotification:(NSNotification *)notification{
    [self loadData];
}

- (void)viewWillRemove:(NSNotification *)notification{
    [self loadData];
}

- (void)loadData{
    AVUser *user = [AVUser currentUser];
    
    AVQuery *query = [AVQuery queryWithClassName:user.username];
    query.limit = 10;
    [query orderByDescending:@"number"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        _userArray = objects;
        [_tableView reloadData];
    }];

}

- (void)createTable{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight-64-49) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UINib *nib = [UINib nibWithNibName:@"TopTableViewCell" bundle:[NSBundle mainBundle]];
    [_tableView registerNib:nib forCellReuseIdentifier:@"TopCell"];
    [self.view addSubview:_tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TopCell" forIndexPath:indexPath];
    AVObject *obj = _userArray[indexPath.row];
    User *user = [[User alloc] init];
    user.number = [[obj objectForKey:@"number"] floatValue];
    user.name = [obj objectForKey:@"name"];
    cell.user = user;
    cell.num.text = [NSString stringWithFormat:@"%li",indexPath.row+1];
    if (indexPath.row == 0) {
        cell.num.textColor = [UIColor orangeColor];
    }
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
- (IBAction)addFriend:(id)sender {
    AddFriend *friend = [[AddFriend alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    [friend show];
    
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
