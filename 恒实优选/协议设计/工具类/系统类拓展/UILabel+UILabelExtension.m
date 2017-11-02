//
//  UILabel+UILabelExtension.m
//  装修项目管理
//
//  Created by mmxd on 17/1/13.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import "UILabel+UILabelExtension.h"

@implementation UILabel (UILabelExtension)

+(UILabel *)setLabelTitle:(NSString *)title
                  setFont:(CGFloat)font
                 setframe:(CGRect)frame
              setposition:(ControlPositionEnum)position
                setweight:(CGFloat)weight
         setnumberOfLines:(int)numberOfLines
            settitlecolor:(NSString *)titlecolor
{
    UILabel * customLabel =[[UILabel alloc]initWithFrame:frame];
    customLabel.text = title;
    customLabel.textColor =[UIColor setColor:titlecolor];
    customLabel.font =[UIFont systemFontOfSize:font weight:weight];
    customLabel.numberOfLines = numberOfLines;
    
    if (position == ControlPositionLeft) {
        
        customLabel.textAlignment = NSTextAlignmentLeft;
    }
    else if (position == ControlPositionRight)
    {
        customLabel.textAlignment = NSTextAlignmentRight;
    }
    else
    {
        customLabel.textAlignment = NSTextAlignmentCenter;
    }
    return customLabel;
}

@end
