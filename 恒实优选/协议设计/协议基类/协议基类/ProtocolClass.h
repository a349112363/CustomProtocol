//
//  ProtocolClass.h
//  注册协议跳转
//
//  Created by mmxd on 16/12/1.
//  Copyright © 2016年 mmxd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SuperViewController.h"
#import "CheckDataTool.h"
#import "NSString+NSStringExtension.h"

@interface ProtocolClass : NSObject

//url 协议头
@property (nonatomic,copy)NSString * Protocol;

//协议正文
@property (nonatomic,copy)NSString * ProtocolContext;

//协议路径
@property (nonatomic,copy)NSString * path;

//保存协议未被处理参数
@property (nonatomic,copy)NSString * parameterStr;

//保存传过来的协议文本
@property (nonatomic,copy)NSString * protocolUtlStr;

//协议控件位置
@property (nonatomic,copy)NSString * ProtocolPosition;

//通过反射查找到类属性进行赋值 来进行js回调
@property (nonatomic,copy)NSString * jscallback;

//保存协议已被处理的参数
@property(nonatomic,strong) NSMutableDictionary * parameter;

//判断是否是查找控件
@property (nonatomic,assign) BOOL isFindControl;

//用来接收当前控制器
@property (nonatomic,strong) SuperViewController * protocolVC;

/******
 初始化数据 解析协议
 ********/
-(id)initWithStr:(NSString *)urlstr viewcontrol:(SuperViewController *)vc;

//基类创建方法 子类实现方法
-(void)run;

//协议基类 反射出子类
+(void)ProtocolFactroy:(NSString *) protocolStr vc:(SuperViewController *) vc;

//查找到对应控件 或者 创建控件
-(id)findControl;


//返回创建的控件
-(UIView *)CreateControlView;

//js回调函数
-(void)setjscallback;

-(void)paramrepalcebase64:(NSString *)param paramkey:(NSString *)paramkey paramvalue:(NSString *)paramvalue;


@end
