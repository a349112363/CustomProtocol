//
//  Control_PickerView.h
//  装修项目管理
//
//  Created by mmxd on 17/1/17.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import "ProtocolClass.h"
#import "Sub_UIPickerView.h"
@interface Control_PickerView : ProtocolClass


//选择器view
@property (nonatomic,strong)Sub_UIPickerView * pickerview;
//选择器上工具条
@property (nonatomic,strong)Sub_PickerViewToolBar * toolbar;

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
