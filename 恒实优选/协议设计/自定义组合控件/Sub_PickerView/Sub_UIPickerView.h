//
//  Sub_UIPickerView.h
//  PickerView
//
//  Created by mmxd on 17/1/18.
//  Copyright © 2017年 WTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewController.h"
#import "Sub_PickerViewToolBar.h"

#define PickerviewHeight 220
#define ToolBarHeight 35
#define Duration 0.3
#define BackColorPickview @"ececec" //设置pickview 背景颜色
#define PickviewShowframe CGRectMake(IPHONE_ZERO, IPHONE_HEIGHT, IPHONE_WIDTH, PickerviewHeight)
#define PickviewHiddenframe CGRectMake(IPHONE_ZERO, IPHONE_HEIGHT - PickerviewHeight,IPHONE_WIDTH, PickerviewHeight)


@interface Sub_PickerViewModel : NSObject

@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * code;
@property (nonatomic,copy) NSString * level;
@property (nonatomic,strong) NSArray  * children;

@end

@interface Sub_UIPickerView : UIView<UIPickerViewDelegate>

@property (nonatomic,strong) WebViewController *vc;

//自定义选择器
@property (nonatomic,strong) UIPickerView *pickerview;
//时间选择器
@property (nonatomic,strong) UIDatePicker * pickerviewDate;
//选择器工具条
@property (nonatomic,strong) Sub_PickerViewToolBar * toolbar;
//pickview 数据源
@property (nonatomic,strong)NSArray * datasource;
//选择器多少列
@property (nonatomic,assign) int rownumber;
//选择器初始数据
@property (nonatomic,copy) NSString * initialdata;
//选择器选中的后拼接参数
@property (nonatomic,copy)NSString * selectedParameter;

-(id)initWithFrame:(CGRect)frame vc:(WebViewController *)vc;

//显示选择器
-(void)showpickerview;
//隐藏选择器
-(void)hideenpickerview;

-(void)setselectedParameter:(NSString *)jscallback;

@end
