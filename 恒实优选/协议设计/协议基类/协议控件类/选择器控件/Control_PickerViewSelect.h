//
//  Control_PickerViewOther.h
//  装修项目管理
//
//  Created by mmxd on 17/2/14.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import "Control_PickerView.h"
#import "Sub_PickerViewSelect.h"

@interface Control_PickerViewSelect : Control_PickerView
@property (nonatomic,strong) Sub_PickerViewSelect * pickerviewSelect;

//工具条上面的标题
@property (nonatomic,copy)NSString * text;
//标题文字颜色
@property (nonatomic,copy)NSString * textcolor;
//标题文字字体大小
@property (nonatomic,copy)NSString * fontsize;

//选择器列数
@property (nonatomic,copy)NSString * rownumber;
//选择器上面数据
@property (nonatomic,copy)NSString * datasource;

@property (nonatomic,copy)NSString * initialdata;

//工具条上面按钮参数设置
@property (nonatomic,copy)NSString * menus;

@end
