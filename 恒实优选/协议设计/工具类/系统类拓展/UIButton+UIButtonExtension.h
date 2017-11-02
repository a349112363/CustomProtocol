//
//  UIButton+UIButtonExtension.h
//  装修项目管理
//
//  Created by mmxd on 17/1/13.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (UIButtonExtension)


+(UIButton *)setBtnTitle:(NSString *)title
                setImage:(NSString *)imagename
            setbackimage:(NSString *)backimage
                 setFont:(CGFloat)font
                setframe:(CGRect)frame
                  settag:(int)tag
             setposition:(ControlPositionEnum )position
               setweight:(CGFloat)weight
           settitlecolor:(NSString *)titlecolor;

@end
