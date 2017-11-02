//
//  UIImage+UIImageExtension.m
//  装修项目管理
//
//  Created by mmxd on 17/1/17.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import "UIImage+UIImageExtension.h"

@implementation UIImage (UIImageExtension)


/**
 图片的压缩其实是俩概念，
 1、是 “压” 文件体积变小，但是像素数不变，长宽尺寸不变，那么质量可能下降，
 2、是 “缩” 文件的尺寸变小，也就是像素数减少。长宽尺寸变小，文件体积同样会减小。
 
 这个 UIImageJPEGRepresentation(image, 0.0)，是1的功能。
 这个 [sourceImage drawInRect:CGRectMake(0,0,targetWidth, targetHeight)] 是2的功能。
 */
+ (UIImage *)scaleFromImage:(UIImage *)image toSize:(CGSize)size
{
    // UIImageJPEGRepresentation(image,0.5);//
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


#pragma mark - 添加水印
+ (UIImage *)watermarkImage:(UIImage*)img whith:(NSString *)name
{
    NSString * mark = name;
    
    int w = img.size.width;
    int h = img.size.height;
    UIGraphicsBeginImageContext(img.size);
    [img drawInRect:CGRectMake(0, 0, w, h)];
    NSDictionary * attr =@{NSFontAttributeName:[UIFont boldSystemFontOfSize:80.0f],
                           NSForegroundColorAttributeName:[UIColor redColor],
                           };
    [mark drawInRect:CGRectMake(w-1000, h-200, w, 500) withAttributes:attr];
    UIImage * aimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return aimg;
}

@end
