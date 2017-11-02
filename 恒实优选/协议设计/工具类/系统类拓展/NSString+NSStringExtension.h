//
//  NSString+NSStringExtension.h
//  注册协议跳转
//
//  Created by mmxd on 16/12/1.
//  Copyright © 2016年 mmxd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSStringExtension)

//url编码
+(NSString *)URLEncodedString:(NSString *)str;

//url解码
+(NSString *)URLDecodedString:(NSString *)str;


//DES 加密
+(NSString *)encryptSting:(NSString *)sText key:(NSString *)key andDesiv:(NSString *)ivDes;

//DES 解密
+(NSString *)decryptWithDESString:(NSString *)sText key:(NSString *)key andiV:(NSString *)iv;

//小写转大写
+(NSString *)toUpper:(NSString *)str;

//大写转小写
+(NSString *)toLower:(NSString *)str;

//判断字符串不为空
+ (BOOL) isBlankString:(NSString *)string ;

//字符串排序
+(NSString *)strKey:(NSString *)key;

//MD5加密
+ (NSString *)md5HexDigest:(NSString*)input;

//DES加密
+ (NSString *)encrypt:(NSString *)sText key:(NSString *)key;

//DES解密
+ (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key;

//base64编码
+(NSString *)base64encode:(NSString *)encodeStr;

//base64解码
+(NSString *)base64Decode:(NSString *)decodeStr;

+(NSString *)base64:(NSString *)str;

+ (BOOL)checkIsExistPropertyWithInstance:(id)instance verifyPropertyName:(NSString *)verifyPropertyName;

+(NSString *)getCurVersion;

/**
 *  对字符串进行替换操作
 *
 *  @param param  替换的原字符串
 *  @param param1 需要替换的字符串
 *  @param param2 替换成的字符串
 *
 *  @return 返回替换完成加密后的字符
 */
+(NSString *)replaceparam:(NSString *)param andparam1:(NSString *)param1 andparam2:(NSString *)param2;


+ (NSString *)setUpPhotoTime;
@end
