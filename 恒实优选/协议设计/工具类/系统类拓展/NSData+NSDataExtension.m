//
//  NSData+NSDataExtension.m
//  装修项目管理
//
//  Created by mmxd on 17/1/21.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import "NSData+NSDataExtension.h"

@implementation NSData (NSDataExtension)


//对图片进行压缩
+ (NSData *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize {
    
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    if (maxFileSize > 0) {
        while ([imageData length] > maxFileSize && compression > maxCompression) {
            compression-=0.1f;
            imageData = UIImageJPEGRepresentation(image, compression);
            
        }
    }
    return imageData;
}
@end
