//
//  Control_TableView.h
//  装修项目管理
//
//  Created by mmxd on 16/12/6.
//  Copyright © 2016年 mmxd. All rights reserved.
//

#import "ProtocolClass.h"
#import "SubUI_DropdownList.h"

@interface Control_DropDownList : ProtocolClass

//接收设置下拉菜单参数
@property (nonatomic,strong)NSString * menus;

//声明下拉菜单对象
@property (nonatomic,strong) SubUI_DropdownList * subDropDownList;


//按钮标题
@property (nonatomic,strong) NSString * text;

//按钮标题文字颜色
@property (nonatomic,strong) NSString * textcolor;

//按钮frame
@property (nonatomic,strong) NSString * frame;

//前景图片
@property (nonatomic,strong) NSString * foreimage;

//设置图片位置
@property (nonatomic,strong) NSString * foreimagealignment;

//设置标题文字位置
@property (nonatomic,strong) NSString * textalignment;

//背景颜色
@property (nonatomic,strong)NSString * backgroundcolor;


//文字字体大小
@property (nonatomic,assign) CGFloat fontsize;

//设置文字加粗
@property (nonatomic,assign) CGFloat fontweight;


//控件tag值
@property (nonatomic,assign) int  tag;

//隐藏或者显示标签
@property (nonatomic,assign) bool ishidden;

//通过反射获取属性值,包含了可能是一段协议 或者是一段js 代码
@property (nonatomic,strong) NSString * eventstring;

@property (nonatomic,strong) NSString * jscallback;



@end
