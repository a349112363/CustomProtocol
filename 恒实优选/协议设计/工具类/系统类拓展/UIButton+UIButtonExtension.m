//
//  UIButton+UIButtonExtension.m
//  装修项目管理
//
//  Created by mmxd on 17/1/13.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import "UIButton+UIButtonExtension.h"

@implementation UIButton (UIButtonExtension)

+(UIButton *)setBtnTitle:(NSString *)title
                setImage:(NSString *)imagename
            setbackimage:(NSString *)backimage
                 setFont:(CGFloat)font
                setframe:(CGRect)frame
                  settag:(int)tag
             setposition:(ControlPositionEnum)position
               setweight:(CGFloat)weight
           settitlecolor:(NSString *)titlecolor
{
    UIButton * custom = [UIButton buttonWithType:UIButtonTypeCustom];
    custom.titleLabel.font =[UIFont systemFontOfSize:font weight:weight];
    [custom setTitle:title forState:UIControlStateNormal];
    [custom setTitleColor:[UIColor setColor:titlecolor] forState:UIControlStateNormal];
    custom.frame = frame;
    custom.tag = tag;
    if (position == ControlPositionLeft) {
        
        custom.imageView.contentMode = UIViewContentModeLeft;
        custom.titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    else if (position == ControlPositionRight)
    {
        custom.imageView.contentMode = UIViewContentModeRight;
        custom.titleLabel.textAlignment = NSTextAlignmentRight;
    }
    else
    {
        custom.imageView.contentMode = UIViewContentModeCenter;
        custom.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return custom;
}

@end
