//
//  SetViewController.m
//  RunWithYou
//
//  Created by 卡神 on 15/8/27.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "SetViewController.h"
#import "MoreTableViewCell.h"
#import <AVOSCloud/AVOSCloud.h>

static NSString *moreCellId = @"moreCellId";

@interface SetViewController ()
{
    UITableView *_tableView;
}

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _createTableView];
}

- (void)_createTableView{
    _tableView = [[ UITableView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight-49) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.5];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview: _tableView];
    [_tableView registerClass:[MoreTableViewCell class] forCellReuseIdentifier:moreCellId];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MoreTableViewCell *cell = (MoreTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 7) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定退出" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [AVUser logOut];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 8;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 7) {
        return 1;
    }else if (section == 6){
        return 3;
    }
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:moreCellId forIndexPath:indexPath];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"乐动力ID:32573759";
    }
    
    if (indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.textLabel.text = @"修改资料";
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"修改目标";
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"立即备份";
        }else if(indexPath.row == 1){
            cell.textLabel.text = @"提交成绩";
        }
    }
    
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"打开乐动力";
            UISwitch *switch1 = [[UISwitch alloc]initWithFrame:CGRectZero];
            cell.accessoryView = switch1;
        }else if(indexPath.row == 1){
            cell.textLabel.text = @"省电模式";
            UISwitch *switch1 = [[UISwitch alloc]initWithFrame:CGRectZero];
            cell.accessoryView = switch1;
        }
    }
    
    if (indexPath.section == 4) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"锻炼成绩通知";
            UISwitch *switch1 = [[UISwitch alloc]initWithFrame:CGRectZero];
            cell.accessoryView = switch1;
        }else if(indexPath.row == 1){
            cell.textLabel.text = @"每日通知时间: 21:00";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    if (indexPath.section == 5) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"关联QQ健康";
            UISwitch *switch1 = [[UISwitch alloc]initWithFrame:CGRectZero];
            cell.accessoryView = switch1;
        }else if(indexPath.row == 1){
            cell.textLabel.text = @"微信排行榜";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    if (indexPath.section == 6) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"意见反馈";
        }else if(indexPath.row == 1){
            cell.textLabel.text = @"去评分";
        }else if(indexPath.row == 2){
            cell.textLabel.text = @"常见问题";
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (indexPath.section == 7) {
        cell.textLabel.text = @"退出登录";
        //        cell.backgroundColor = [UIColor orangeColor];
        //        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
    
}


@end
