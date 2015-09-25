//
//  EditViewController.h
//  RUNwithu
//
//  Created by mty on 15/9/8.
//  Copyright (c) 2015年 mty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditBtnViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
{
//    UIPickerView *_pickerView; //
    
    UIView *_deletionOrcompletionView; // 创建取消视图以及确定视图
    
    UIButton *_deletionBtn; // 取消按钮
    
    UIButton *_completionBtn; // 确定按钮
}

@property (nonatomic,strong) UIPickerView *pickerView;

@end
