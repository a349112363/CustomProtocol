//
//  Control_Dialog.m
//  装修项目管理
//
//  Created by mmxd on 17/1/11.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import "Control_Dialog.h"

@implementation Control_Dialog

//通过传过来的参数
//obj来找到或者创建对应的控件
-(void)run
{

    self.subDialog =(SubUI_Dialogview *)[self findControl];
    //循环遍历协议参数
    [super run];
    
    if (self.subDialog.menueJson)
    {
        [self.subDialog setMenueListValue];
    }
}
/**
 *  提示框按钮参数设置
 */
-(void)setmenus
{
    //base64 解密
    NSString * DencodeStr =[NSString base64Decode:self.menus];

    self.subDialog.menueJson = DencodeStr;
}

/**
 *  提示框标题
 */
-(void)settitle
{
    self.subDialog.title = self.title;
}
/**
 *  提示框内容
 */
-(void)setcontent
{
    
    self.subDialog.content = [NSString base64Decode:self.content];
}

/**
 *  标题文字颜色
 */
-(void)settitlecolor
{
    self.subDialog.titlecolor = self.titlecolor;
}
/**
 *  内容文字颜色
 */
-(void)setcontentcolor
{
    self.subDialog.contentcolor = self.contentcolor;
}
/**
 *  标题文字大小
 */
-(void)settitlefontsize
{
    self.subDialog.titlefontsize = self.titlefontsize;
}
/**
 *  内容文字大小
 */
-(void)setcontentfontsize
{
    self.subDialog.contentfontsize = self.contentfontsize;
}

/**
 *  设置弹框背景颜色
 */
-(void)setdialogbackcolor
{
    self.subDialog.dialogbackcolor = self.dialogbackcolor;
}
/**
 *  设置是否显示关闭按钮
 */
-(void)setcloseable
{
    
    self.subDialog.closeable = self.closeable;
    
}
-(UIView *)CreateControlView
{
    self.subDialog =[[SubUI_Dialogview alloc]initWithFrame:self.protocolVC.view.bounds vc:self.protocolVC];

    return self.subDialog;
}
@end
