//
//  Contorl_Button.m
//  装修项目管理
//
//  Created by mmxd on 16/12/5.
//  Copyright © 2016年 mmxd. All rights reserved.
//

#import "Control__Button.h"
#import "NSString+NSStringExtension.h"

@implementation ProtocolButton


@end

@implementation Control_Button

@synthesize jscallback;

-(void)run
{
    self.button =(ProtocolButton *)[self findControl];
    
    [super run];
    

    //判断是否是查找出来的控件 是的 就不用再次设置位置
    if (!self.isFindControl) {
        
        [self setButtonFrame];

        //执行通过协议创建事件的方法
        [self.button addTarget:self.protocolVC action:@selector(SelectProtocolEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        
    }
}





/**
 *  设置按钮内部布局
 */
-(void)setButtonFrame
{
    CGFloat btnImageWidth  = 0;
    CGFloat btnImageHeight = 0;
    CGFloat titlewidth = 0;
    CGFloat titleHeight = 0;

    if (![NSString isBlankString:self.foreimage]) {
        
        btnImageWidth = self.button.currentImage.size.width;
        btnImageHeight = self.button.currentImage.size.height;
    }
    

    if (![NSString isBlankString:self.text]) {
     
       CGSize titlesize = [self.text boundingRectWithSize:CGSizeMake(IPHONE_WIDTH, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:self.fontsize weight:self.fontweight]} context:nil].size;
        
        //按钮上文字 如果宽度 < 14 则是按钮下标文字 否则就是按钮标题
//        if (titlesize.width > 14) {
//            
            titlewidth = titlesize.width;
//
//        }
//        else
//        {
//            titlewidth = 14;
//        }

        titleHeight = titlesize.height;
    }
    
    /**
     *  1.按钮图片文字同时存在 2. 按钮只有图片 3. 按钮只有文字
     */
    if (![NSString isBlankString:self.foreimage] && ![NSString isBlankString:self.text])
    {
        //图片文字按钮 1.文字左 图片右 ,文字对齐方式左对齐 2.文字右 图片左 ,文字对齐方式右对齐 3.文字下 图片上 文字居中对齐
        if ([self.foreimagealignment isEqualToString:@"imageleft"] && [self.textalignment isEqualToString:@"textright"])
        {
            
            self.button.imageRect = CGRectMake(0, (44-btnImageHeight) / 2,btnImageWidth, btnImageHeight);

            self.button.titleRect = CGRectMake(btnImageWidth, (44 - titleHeight) / 2, titlewidth + 5, titleHeight);
        
            self.button.titleLabel.textAlignment = NSTextAlignmentRight;
            
            self.button.frame = CGRectMake(0, 0, self.button.titleRect.size.width + btnImageWidth, 44);
        }
        else if ([self.foreimagealignment isEqualToString:@"imageright"] && [self.textalignment isEqualToString:@"textleft"])
        {
          
            self.button.titleRect = CGRectMake(0, (44 - titleHeight) / 2, titlewidth + 5, titleHeight);
            
            self.button.imageRect = CGRectMake(self.button.titleRect.size.width, (44-btnImageHeight) / 2,btnImageWidth, btnImageHeight);
            
            self.button.titleLabel.textAlignment = NSTextAlignmentLeft;
            
            self.button.frame = CGRectMake(0, 0, self.button.titleRect.size.width + btnImageWidth, 44);
            
        }
        else if ([self.foreimagealignment isEqualToString:@"imageup"] && [self.textalignment isEqualToString:@"textdown"])
        {
            
            
            titlewidth = 18;
            self.button.titleRect = CGRectMake(2, 44 / 2, titlewidth,titlewidth);
            self.button.titleLabel.layer.cornerRadius = titlewidth / 2;
            self.button.titleLabel.clipsToBounds = YES;
            self.button.titleLabel.font = [UIFont systemFontOfSize:8];
            self.button.titleLabel.textAlignment = NSTextAlignmentCenter;
          
            self.button.imageRect = CGRectMake(btnImageWidth / 2, (44-btnImageHeight) / 2,btnImageWidth, btnImageHeight);
            self.button.frame = CGRectMake(0, 0, titlewidth + btnImageWidth, 44);
            
        }
        else
        {
            
        }
    
    }
    else if (![NSString isBlankString:self.foreimage] && [NSString isBlankString:self.text])
    {
        //+10 是为了给多个按钮之间留有间隙
        self.button.frame = CGRectMake(0, 0,btnImageWidth + 10, 44);
        
        if ([self.foreimagealignment isEqualToString:@"imageleft"])
        {
            //上左下右
            self.button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0,self.button.width - btnImageWidth);
        }
        else if ([self.foreimagealignment isEqualToString:@"imageright"])
        {
            self.button.imageEdgeInsets = UIEdgeInsetsMake(0, self.button.width - btnImageWidth, 0,0);
            
        }
        else
        {
            QFLOG(@"---------------居中显示按钮");
        }
    }
    else
    {
    
        self.button.frame = CGRectMake(0, 0, titlewidth * 4 / 3, 44);
        
        if ([self.textalignment isEqualToString:@"textleft"])
        {
            self.button.titleLabel.textAlignment = NSTextAlignmentLeft;
        }
        else if ([self.textalignment isEqualToString:@"textright"])
        {
            self.button.titleLabel.textAlignment = NSTextAlignmentRight;
        }
        else
        {
            self.button.titleLabel.textAlignment = NSTextAlignmentCenter;
        }
    }
    
    
}

/**
 设置按钮点击事件
 */
-(void)seteventstring
{
    self.button.eventstring  = [NSString base64Decode:self.eventstring];
    
}


/**
 *  设置按钮背景颜色
 */
-(void)setbackgroundcolor
{
    
    self.button.backgroundColor = [UIColor setColor:self.backgroundcolor];
}

//设置标题 &title=xxxx
-(void)settext
{
    QFLOG(@"---------------%@",self.text);
    
    if ([self.text integerValue] >= 100) {
            
            self.text = @"99+";
    }
        
        [self.button setTitle:self.text forState:UIControlStateNormal];
    
}


/**
 *  设置文字颜色
 */
-(void)settextcolor
{
    
    [self.button setTitleColor:[UIColor setColor:self.textcolor] forState:UIControlStateNormal];
    
}


/**
 *  设置按钮文字背景颜色
 */

-(void)settextbackgroundcolor
{
   
    self.button.titleLabel.backgroundColor =[UIColor setColor:self.textbackgroundcolor];
}

/**
 *  设置文字字体
 */
-(void)setfontsize
{

    self.button.titleLabel.font = [UIFont systemFontOfSize:self.fontsize];
}

/**
 *  设置按钮图片
 */
-(void)setforeimage
{
    
    [self.button setImage:[UIImage imageNamed:self.foreimage] forState:UIControlStateNormal];
        
    
}
/**
 *  隐藏按钮
 */
-(void)setishidden
{
    if (self.ishidden)
    {
        self.button.hidden = YES;
    }
    else
    {
        self.button.hidden = NO;
    
    }
}

//设置文字背景颜色透明度
-(void)settextalpha
{
    self.button.titleLabel.alpha = [self.textalpha floatValue];
}
/**
 *  设置高度宽度 &frame=0（X轴）,0（Y轴）,44（宽度）,44（高度）
 */
-(void)setframe
{

    //通过 逗号截取出对应的坐标 位置
    NSArray * frames =[self.frame componentsSeparatedByString:@","];
    
    if (frames.count == 4)
    {
        self.button.frame = CGRectMake([frames[0] floatValue], [frames[1] floatValue], [frames[2] floatValue], [frames[3] floatValue]);
    }
    

}


/**
 *  创建对应控件
 *
 *  @return 返回创建的控件
 */
-(UIView *)CreateControlView
{
    self.button = [ProtocolButton buttonWithType:UIButtonTypeCustom];
  
    self.fontsize = 14.0f;
    
    return self.button;
}


@end
