//
//  Sub_InputBox.h
//  装修项目管理
//
//  Created by mmxd on 17/2/18.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewController.h"

@interface QFTextView : UITextView

//默认文字
@property (nonatomic,strong) NSString * placeholder;
//默认文字标签
@property (nonatomic,strong) UILabel * textLable;

@end



@interface Sub_InputBox : UIView

@property (nonatomic,strong) WebViewController * vc;
//默认提示文字
@property (nonatomic,copy) NSString * placeholder;
//按钮文字
@property (nonatomic,copy) NSString * buttontext;
//按钮背景颜色
@property (nonatomic,copy) NSString * buttonbackgroundcolor;
//按钮文字大小
@property (nonatomic,copy) NSString * buttonfontsize;

//回调js 函数
@property (nonatomic,copy) NSString * jscallback;
//键盘类型
@property (nonatomic,copy) NSString * keyboardType;
//输入文字
@property (nonatomic,copy) NSString * text;
//正则表达式
@property (nonatomic,copy) NSString * regex;
//提示错误消息
@property (nonatomic,copy) NSString * errormessage;

-(id)initWithFrame:(CGRect)frame vc:(WebViewController *)vc;

//显示提示框
-(void)showInput;

@end
