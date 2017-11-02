//
//  Contorl_Button.h
//  装修项目管理
//
//  Created by mmxd on 16/12/5.
//  Copyright © 2016年 mmxd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProtocolClass.h"
#import "YLButton.h"
//ProtocolButton 继承系统button类
@interface ProtocolButton :YLButton

//通过反射属性得到js方法名
@property (nonatomic,strong) NSString * eventstring;

@end

//Control_Button 
@interface Control_Button : ProtocolClass

//用来接收反射返回按钮
@property (nonatomic,strong) ProtocolButton * button;

//通过反射获取属性值,包含了可能是一段协议 或者是一段js 代码
@property (nonatomic,strong) NSString * eventstring;

//按钮标题
@property (nonatomic,strong) NSString * text;

//按钮标题背景颜色
@property (nonatomic,strong) NSString * textbackgroundcolor;

//按钮标题文字颜色
@property (nonatomic,strong) NSString * textcolor;

//按钮frame
@property (nonatomic,strong) NSString * frame;

//按钮文字透明度
@property (nonatomic,strong) NSString * textalpha;

//前景图片
@property (nonatomic,strong) NSString * foreimage;

//设置图片位置
@property (nonatomic,strong) NSString * foreimagealignment;

//设置标题文字位置
@property (nonatomic,strong) NSString * textalignment;

//文字字体大小
@property (nonatomic,assign) CGFloat fontsize;

//设置文字加粗
@property (nonatomic,assign) CGFloat fontweight;
//设置按钮背景颜色
@property (nonatomic,strong) NSString * backgroundcolor;

//隐藏或者显示标签
@property (nonatomic,assign) bool ishidden;

//js回调参数
@property (nonatomic,strong) NSString * jscallback;



-(void)setButtonFrame;

@end
