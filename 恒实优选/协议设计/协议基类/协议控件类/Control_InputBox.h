//
//  Control_InpuBox.h
//  装修项目管理
//
//  Created by mmxd on 17/2/18.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import "ProtocolClass.h"
#import "Sub_InputBox.h"
@interface Control_InputBox : ProtocolClass
//输入框界面
@property (nonatomic,strong) Sub_InputBox * inputBox;
//输入框默认文字
@property (nonatomic,copy) NSString * placeholder;
//按钮标题
@property (nonatomic,copy) NSString * buttontext;
//按钮背景颜色
@property (nonatomic,copy) NSString * buttonbackgroundcolor;
//按钮字体大小
@property (nonatomic,copy) NSString * buttonfontsize;
//js回调函数
@property (nonatomic,copy) NSString * jscallback;
//键盘类型
@property (nonatomic,copy) NSString * keyboardtype;
//textview 输入内容
@property (nonatomic,copy) NSString * text;
//正则表达式
@property (nonatomic,copy) NSString * regex;
//提示错误消息
@property (nonatomic,copy) NSString * errormessage;
@end
