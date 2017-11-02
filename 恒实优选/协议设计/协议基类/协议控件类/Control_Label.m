//
//  Contorl_Label.m
//  装修项目管理
//
//  Created by mmxd on 16/12/5.
//  Copyright © 2016年 mmxd. All rights reserved.
//

#import "Control_Label.h"

@implementation Control_Label


/**
 *  findControl 接收返回创建的控件
 *  run 通过父类fun 方法给控件设置相应属性参数
 */
-(void)run
{
    self.label =[self findControl];
    //第自己类属性赋值
    [super run];
    
    //包裹控件大小
    [self.label sizeToFit];
    //[self setLabelFrame];
}

/**
 *  属性设置完毕后,原生自己执行该方法,重新设置label宽度
 */
//-(void)setLabelFrame
//{
//    self.textalignment = @"textright";
//    
//    CGRect titlesize = [self.text boundingRectWithSize:CGSizeMake(0, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:self.fontsize weight:self.fontweight]} context:nil];
//    
//    self.label.frame = CGRectMake(0, 0, titlesize.size.width, 44);
//    
//    if ([self.textalignment isEqualToString:@"textleft"])
//    {
//        self.label.textAlignment = NSTextAlignmentLeft;
//    }
//    else if ([self.textalignment isEqualToString:@"textright"])
//    {
//        self.label.textAlignment = NSTextAlignmentRight;
//    }
//    else
//    {
//        self.label.textAlignment = NSTextAlignmentCenter;
//    }
//}
/**
 *  设置标题文字 通过文字字体内容 重新设置label宽度
 */
-(void)settext
{
    
    if (![NSString isBlankString:self.text])
    {
        self.label.text = self.text;

    }
    else
    {
        QFLOG(@"标签文字设置为空----------------%@",self.text);
    }
}

/**
 *  设置字体颜色 textcolor = ffffff
 */
-(void)settextcolor
{
    if (![NSString isBlankString:self.textcolor])
    {
        self.label.textColor =[UIColor setColor:self.textcolor];
    }
    else
    {
        QFLOG(@"标签文字颜色设置为空----------------%@",self.textcolor);
    }
}

/**
 *  设置字体大小
 */

-(void)setfontsize
{
    self.label.font =[UIFont systemFontOfSize:self.fontsize weight:self.fontweight];
    
}

/**
 *  设置文字位置 居中 | 居左 | 居右
 */
-(void)settextalignment
{
    
}

/**
 *  隐藏label 标签& hidden = yes / no
 */
-(void)setishidden
{
    if (self.ishidden)
    {
        self.label.hidden = YES;
    }
    else
    {
        self.label.hidden = NO;
    }
}

//设置label 坐标位置 & frame = 0(X轴),0(Y轴),44(宽度),44(高度)
-(void)setframe
{
    //通过逗号截取出对应的坐标设置
    NSArray * frames =[self.frame componentsSeparatedByString:@","];
    
    if (frames.count == 4)
    {
        self.label.frame = CGRectMake([frames[0] floatValue], [frames[1] floatValue], [frames[2] floatValue], [frames[3] floatValue]);
    }
}

-(void)setbackgroundcolor
{
    self.label.backgroundColor =[UIColor setColor:self.backgroundcolor];
}

//初始化创建lable
-(UIView *)CreateControlView
{
    self.label = [[UILabel alloc]init];
    
    self.fontsize = 16.0f;
    
    self.textcolor =@"ffffff";
    
    return self.label;
}


@end
