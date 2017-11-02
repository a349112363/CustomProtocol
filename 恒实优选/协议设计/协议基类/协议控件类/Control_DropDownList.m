//
//  Control_TableView.m
//  装修项目管理
//
//  Created by mmxd on 16/12/6.
//  Copyright © 2016年 mmxd. All rights reserved.
//

#import "Control_DropDownList.h"
#import "SubUI_DropdownList.h"
#import "NSString+NSStringExtension.h"

@interface Control_DropDownList ()

@end

@implementation Control_DropDownList


@synthesize jscallback;




//通过传过来的参数
//obj来找到或者创建对应的控件
-(void)run
{
    //找到 SubUI_DropdownList 对象
    for (UIView * view in [AppDelegate appdelegate].window.subviews) {
        
        if ([view isKindOfClass:[SubUI_DropdownList class]]) {
            
            self.subDropDownList = (SubUI_DropdownList *)view;
        }
    }
    //给SubUI_DropdownList 对象上 按钮重新找到对象
    self.subDropDownList.DropDownBtn =(DropDownBtn *)[self findControl];
    //循环遍历协议参数
    [super run];
    
    if (!self.isFindControl) {
        
        [self setButtonFrame];
        
        if (self.subDropDownList.menueJson)
        {
            [self.subDropDownList setMenueListValue];
        }
    }
    
    
}


/**
 *  设置按钮位置
 */
-(void)setButtonFrame
{
    CGFloat btnImageWidth  = 0;
    CGFloat btnImageHeight = 0;
    CGFloat titlewidth = 0;
    CGFloat titleHeight = 0;
    
    if (![NSString isBlankString:self.foreimage]) {
        
        btnImageWidth = self.subDropDownList.DropDownBtn.currentImage.size.width;
        btnImageHeight = self.subDropDownList.DropDownBtn.currentImage.size.height;
    }
    
    
    if (![NSString isBlankString:self.text]) {
        
        
        CGSize titlesize = [self.text boundingRectWithSize:CGSizeMake(IPHONE_WIDTH, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:self.fontsize weight:self.fontweight  ]} context:nil].size;
        
        //按钮上文字 如果宽度 < 14 则是按钮下标文字 否则就是按钮标题
        if (titlesize.width > 14) {
            
            titlewidth = titlesize.width;
            
        }
        else
        {
            titlewidth = 14;
        }
        
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
            
            self.subDropDownList.DropDownBtn.imageRect = CGRectMake(0, (44-btnImageHeight) / 2,btnImageWidth, btnImageHeight);
            
            self.subDropDownList.DropDownBtn.titleRect = CGRectMake(btnImageWidth, (44 - titleHeight) / 2, titlewidth + 5, titleHeight);
            
            self.subDropDownList.DropDownBtn.titleLabel.textAlignment = NSTextAlignmentRight;
            
            self.subDropDownList.DropDownBtn.frame = CGRectMake(0, 0, self.subDropDownList.DropDownBtn.titleRect.size.width + btnImageWidth, 44);
        }
        else if ([self.foreimagealignment isEqualToString:@"imageright"] && [self.textalignment isEqualToString:@"textleft"])
        {
            
            self.subDropDownList.DropDownBtn.titleRect = CGRectMake(0, (44 - titleHeight) / 2, titlewidth + 5, titleHeight);
            
            self.subDropDownList.DropDownBtn.imageRect = CGRectMake(self.subDropDownList.DropDownBtn.titleRect.size.width, (44-btnImageHeight) / 2,btnImageWidth, btnImageHeight);
            
            self.subDropDownList.DropDownBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
            
            self.subDropDownList.DropDownBtn.frame = CGRectMake(0, 0, self.subDropDownList.DropDownBtn.titleRect.size.width + btnImageWidth, 44);
            
        }
        else if ([self.foreimagealignment isEqualToString:@"imageup"] && [self.textalignment isEqualToString:@"textdown"])
        {
            
            self.subDropDownList.DropDownBtn.titleRect = CGRectMake(0, 44 - 22, titlewidth,titlewidth);
            
            self.subDropDownList.DropDownBtn.imageRect = CGRectMake(5, (44-btnImageHeight) / 2,btnImageWidth, btnImageHeight);
            
            self.subDropDownList.DropDownBtn.titleLabel.layer.cornerRadius = titlewidth / 2;
            
            self.subDropDownList.DropDownBtn.titleLabel.clipsToBounds = YES;
            
            self.subDropDownList.DropDownBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
            
            self.subDropDownList.DropDownBtn.frame = CGRectMake(0, 0, titlewidth + btnImageWidth, 44);
            
        }
        else
        {
            
        }
        
    }
    else if (![NSString isBlankString:self.foreimage] && [NSString isBlankString:self.text])
    {
        //+10 是为了给多个按钮之间留有间隙
        self.subDropDownList.DropDownBtn.frame = CGRectMake(0, 0,btnImageWidth + 10, 44);
        
        if ([self.foreimagealignment isEqualToString:@"imageleft"])
        {
            //上左下右
            self.subDropDownList.DropDownBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0,self.subDropDownList.DropDownBtn.width - btnImageWidth);
        }
        else if ([self.foreimagealignment isEqualToString:@"imageright"])
        {
            self.subDropDownList.DropDownBtn.imageEdgeInsets = UIEdgeInsetsMake(0, self.subDropDownList.DropDownBtn.width - btnImageWidth, 0,0);
            
        }
        else
        {
            QFLOG(@"---------------居中显示按钮");
        }
    }
    else
    {
        
        self.subDropDownList.DropDownBtn.frame = CGRectMake(0, 0, titlewidth * 4 / 3, 44);
        
        if ([self.textalignment isEqualToString:@"textleft"])
        {
            self.subDropDownList.DropDownBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        }
        else if ([self.textalignment isEqualToString:@"textright"])
        {
            self.subDropDownList.DropDownBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        }
        else
        {
            self.subDropDownList.DropDownBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        }
    }
    
}

//设置字体颜色 &color= ffffff
-(void)settextcolor
{
    if (![NSString isBlankString:self.textcolor]) {
        
        [self.subDropDownList.DropDownBtn setTitleColor:[UIColor setColor:self.textcolor] forState:UIControlStateNormal];
    }
    else
    {
        QFLOG(@"%@按钮文字颜色设置为空-----------%@",self,self.textcolor);
    }
}
/**
 *  设置按钮图片
 */
-(void)setforeimage
{
    if (![NSString isBlankString:self.foreimage]) {
        
        [self.subDropDownList.DropDownBtn setImage:[UIImage imageNamed:self.foreimage] forState:UIControlStateNormal];
        
    }
    else
    {
        QFLOG(@"下拉菜单按钮图片设置为空--------%@",self.foreimage);
    }
}

/**
 *  设置文字字体
 */
-(void)setfontsize
{
    self.subDropDownList.DropDownBtn.titleLabel.font = [UIFont systemFontOfSize:self.fontsize];
}

/**
 *  设置按钮背景图片
 */
-(void)setbackgroundcolor
{
    self.subDropDownList.DropDownBtn.backgroundColor = [UIColor setColor:self.backgroundcolor];
}


/**
 *  隐藏按钮
 */
-(void)setishidden
{
    if (self.tag)
    {
        self.subDropDownList.DropDownBtn = [self.protocolVC.navigationController.navigationBar viewWithTag:self.tag];
        
        if (self.ishidden)
        {
            self.subDropDownList.DropDownBtn.hidden = YES;
        }
        else
        {
            self.subDropDownList.DropDownBtn.hidden = NO;
        }
    }
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
        self.subDropDownList.DropDownBtn.frame = CGRectMake([frames[0] floatValue], [frames[1] floatValue], [frames[2] floatValue], [frames[3] floatValue]);
    }
}


-(void)settext
{
    [self.subDropDownList.DropDownBtn setTitle:self.text forState:UIControlStateNormal];
}
-(void)setmenus
{
    NSString * DencodeStr =[NSString base64Decode:self.menus];
    
    self.subDropDownList.menueJson = DencodeStr;
}

-(UIView *)CreateControlView
{
    self.subDropDownList = [[SubUI_DropdownList alloc]initWithFrame:[AppDelegate appdelegate].window.bounds vc:self.protocolVC];
    
    [[AppDelegate appdelegate].window addSubview:self.subDropDownList];
    
    self.subDropDownList.hidden = YES;
    
    self.subDropDownList.DropDownBtn =[DropDownBtn buttonWithType:UIButtonTypeCustom];
    
    //将subDropDownList对象让DropDownBtn 指针属性接收
    self.subDropDownList.DropDownBtn.subuidropdownlistid = self.subDropDownList;
    
    return self.subDropDownList.DropDownBtn;
}





@end
