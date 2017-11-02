//
//  Contorl_Label.h
//  装修项目管理
//
//  Created by mmxd on 16/12/5.
//  Copyright © 2016年 mmxd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProtocolClass.h"




@interface Control_Label : ProtocolClass

//标签label 内容
@property (nonatomic,strong) NSString * text;

//标签label 字体颜色
@property (nonatomic,strong) NSString * textcolor;

//标签label 坐标位置
@property (nonatomic,strong) NSString * frame;


//隐藏或者显示标签 注意 更确切地说对于32位系统BOOL是一个signed char，而在64位这是一个bool,通过类赋值,在5上面就会出现错误 所以不用BOOL 用bool
@property (nonatomic,assign) bool ishidden;

//用来接收反射出来控件
@property (nonatomic,strong) UILabel * label;

//设置文字大小
@property (nonatomic,assign) CGFloat fontsize;

//设置文字加粗
@property (nonatomic,assign) CGFloat fontweight;

//设置背景颜色
@property (nonatomic,strong)NSString * backgroundcolor;

//得到标题文字位置
@property (nonatomic,strong) NSString * textalignment;


@end
