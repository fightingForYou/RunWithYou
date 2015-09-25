//
//  EditViewController.m
//  RUNwithu
//
//  Created by mty on 15/9/8.
//  Copyright (c) 2015年 mty. All rights reserved.
//

#import "EditBtnViewController.h"

@interface EditBtnViewController ()

@end

@implementation EditBtnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self _createSubviews];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 创建视图
- (void)_createSubviews {
    
    // 创建pickerView
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 200, kWidth, 100)];
    
    _pickerView.backgroundColor = [UIColor clearColor];
    
    _pickerView.delegate = self;
    
    _pickerView.dataSource = self;
    
    [self.view addSubview:_pickerView];
    
    
    // 创建取消视图以及确定视图
    _deletionOrcompletionView = [[UIView alloc] initWithFrame:CGRectMake(0, 450, kWidth, 100)];
    
    [self.view addSubview:_deletionOrcompletionView];
    
    // 取消按钮
    _deletionBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, kWidth/2-20, 100)];
    
    [_deletionBtn setTitle:@"取消" forState:UIControlStateNormal];
    
    _deletionBtn.backgroundColor = [UIColor orangeColor];
    
    [_deletionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [_deletionBtn addTarget:self action:@selector(deletionBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_deletionOrcompletionView addSubview:_deletionBtn];
   
    // 确定按钮
    _completionBtn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth/2, 0, kWidth/2-10, 100)];
    
    [_completionBtn setTitle:@"完成" forState:UIControlStateNormal];
    
    _completionBtn.backgroundColor = [UIColor orangeColor];
    
    [_completionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [_completionBtn addTarget:self action:@selector(completionBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_deletionOrcompletionView addSubview:_completionBtn];
    
}

#pragma mark - button 响应方法

// 取消按钮
- (void)deletionBtnAction:(UIButton *)button {
    
    [self.navigationController popViewControllerAnimated:YES];
}

// 确定按钮 (可以用HUD试一下)
- (void)completionBtnAction:(UIButton *)button {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"体重添加成功" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    
    [alertView show];
}


#pragma mark - UIPickerView Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component == 0) {
        
        return 181;
    }
    else {
        
        return 10;
    }
}

//返回显⽰的文本
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSMutableArray *strArray1 = [[NSMutableArray alloc] init];
    
    NSMutableArray *strArray2 = [[NSMutableArray alloc] init];
    
    if (component == 0) {
        
        for (int i = 25; i<206; i++) {
            
            NSString *str = [NSString stringWithFormat:@"%i",i];
            
            [strArray1 addObject:str];
        }
        
        return [strArray1 objectAtIndex:row];
    }
    else {
        
        for (int i = 0; i<10; i++) {
            
            NSString *str = [NSString stringWithFormat:@".%i  Kg",i];
            
            [strArray2 addObject:str];
        }
        
        return [strArray2 objectAtIndex:row];
        
    }
    
}


- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return 50;
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
