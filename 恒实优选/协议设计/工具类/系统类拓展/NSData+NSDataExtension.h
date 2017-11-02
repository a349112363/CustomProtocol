//
//  NSData+NSDataExtension.h
//  装修项目管理
//
//  Created by mmxd on 17/1/21.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (NSDataExtension)

+ (NSData *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize ;


@end
