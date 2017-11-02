//
//  UIImage+UIImageExtension.h
//  装修项目管理
//
//  Created by mmxd on 17/1/17.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImageExtension)

+ (UIImage *)scaleFromImage:(UIImage *)image toSize:(CGSize)size;


+ (UIImage *)watermarkImage:(UIImage*)img whith:(NSString *)name;


@end
