//
//  Control_InpuBox.m
//  装修项目管理
//
//  Created by mmxd on 17/2/18.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import "Control_InputBox.h"

@implementation Control_InputBox

@synthesize jscallback;

-(void)run
{
    self.inputBox = (Sub_InputBox *)[self findControl];
    
    [super run];
    
    [self.inputBox showInput];
}

-(void)setplaceholder
{
    self.inputBox.placeholder = self.placeholder;
}

-(void)setbuttonbackgroundcolor
{
    self.inputBox.buttonbackgroundcolor = self.buttonbackgroundcolor;
}

-(void)setbuttonfontsize
{
    self.inputBox.buttonfontsize = self.buttonfontsize;
}

-(void)setbuttontext
{
    self.inputBox.buttontext = self.buttontext;
}

-(void)setjscallback
{
    self.inputBox.jscallback = self.jscallback;
}

-(void)setkeyboardtype
{
    self.inputBox.keyboardType = self.keyboardtype;
}
-(void)settext
{
    //因为输入框内容中可能包含特殊字符 正则判断不全面 所以前端传过来会加密 进行解密后再赋值
    self.text = [NSString base64Decode:self.text];
    
    self.inputBox.text = self.text;
}

-(void)setregex
{
    self.inputBox.regex = self.regex;
}

-(void)seterrormessage
{
    self.inputBox.errormessage = self.errormessage;
}

-(UIView *)CreateControlView
{
    
    self.inputBox =[[Sub_InputBox alloc] initWithFrame:[AppDelegate appdelegate].window.bounds vc:self.protocolVC];
    
    return self.inputBox;
}

@end
