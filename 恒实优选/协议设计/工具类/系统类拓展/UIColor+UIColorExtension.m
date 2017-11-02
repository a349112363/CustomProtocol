//
//  UIColor+UIColorExtension.m
//  注册协议跳转
//
//  Created by mmxd on 16/12/2.
//  Copyright © 2016年 mmxd. All rights reserved.
//

#import "UIColor+UIColorExtension.h"

@implementation UIColor (UIColorExtension)

+(instancetype)setColor:(NSString *)Color
{
    if (Color) {
        
        long colorLong = strtoul([Color cStringUsingEncoding:NSUTF8StringEncoding], 0, 16);
        
        return [UIColor colorWithRed:((float)((colorLong & 0xFF0000) >> 16))/255.0 \
                               green:((float)((colorLong & 0xFF00) >> 8))/255.0 \
                                blue:((float)(colorLong & 0xFF))/255.0 alpha:1.0];
    }
    return nil;
    
}

@end
