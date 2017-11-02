//
//  NSString+NSStringExtension.m
//  注册协议跳转
//
//  Created by mmxd on 16/12/1.
//  Copyright © 2016年 mmxd. All rights reserved.
//

#import "NSString+NSStringExtension.h"
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCryptor.h>
#import <objc/runtime.h>
@implementation NSString (NSStringExtension)


+(NSString *)URLEncodedString:(NSString *)str
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)str,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}

+(NSString *)URLDecodedString:(NSString *)str
{
    NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)str, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return decodedString;
}


//DES加密
+(NSString *)encryptSting:(NSString *)sText key:(NSString *)key andDesiv:(NSString *)ivDes
{
    if ((sText == nil || sText.length == 0)
        || (sText == nil || sText.length == 0)
        || (ivDes == nil || ivDes.length == 0)) {
        return @"";
    }
    //gb2312 编码
    NSStringEncoding encoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* encryptData = [sText dataUsingEncoding:encoding];
    size_t  dataInLength = [encryptData length];
    const void *   dataIn = (const void *)[encryptData bytes];
    
    CCCryptorStatus ccStatus = nil;
    uint8_t *dataOut = NULL; //可以理解位type/typedef 的缩写（有效的维护了代码，比如：一个人用int，一个人用long。最好用typedef来定义）
    size_t dataOutMoved = 0;
    size_t    dataOutAvailable = (dataInLength + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);  dataOut = malloc( dataOutAvailable * sizeof(uint8_t));
    memset((void *)dataOut, 0x0, dataOutAvailable);//将已开辟内存空间buffer的首 1 个字节的值设为值 0
    const void *iv = (const void *) [ivDes cStringUsingEncoding:NSASCIIStringEncoding];
    //CCCrypt函数 加密/解密
    ccStatus = CCCrypt(kCCEncrypt,//  加密/解密
                       kCCAlgorithmDES,//  加密根据哪个标准（des，3des，aes。。。。）
                       kCCOptionPKCS7Padding,//  选项分组密码算法(des:对每块分组加一次密  3DES：对每块分组加三个不同的密)
                       [key UTF8String],  //密钥    加密和解密的密钥必须一致
                       kCCKeySizeDES,//   DES 密钥的大小（kCCKeySizeDES=8）
                       iv, //  可选的初始矢量
                       dataIn, // 数据的存储单元
                       dataInLength,// 数据的大小
                       (void *)dataOut,// 用于返回数据
                       dataOutAvailable,
                       &dataOutMoved);
    
    //编码 base64
    NSData *data = [NSData dataWithBytes:(const void *)dataOut length:(NSUInteger)dataOutMoved];
    Byte *bytes = (Byte *)[data bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[data length];i++){
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    free(dataOut);
    return hexStr;
}

//DES解密
+(NSString *)decryptWithDESString:(NSString *)sText key:(NSString *)key andiV:(NSString *)iv
{
    if ((sText == nil || sText.length == 0)
        || (sText == nil || sText.length == 0)
        || (iv == nil || iv.length == 0)) {
        return @"";
    }
    const void *dataIn;
    size_t dataInLength;
    char *myBuffer = (char *)malloc((int)[sText length] / 2 + 1);
    bzero(myBuffer, [sText length] / 2 + 1);
    for (int i = 0; i < [sText length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [sText substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    
    NSData *decryptData =[NSData dataWithBytes:myBuffer length:[sText length] / 2 ];//转成utf-8并decode
    dataInLength = [decryptData length];
    dataIn = [decryptData bytes];
    free(myBuffer);
    CCCryptorStatus ccStatus = nil;
    uint8_t *dataOut = NULL; //可以理解位type/typedef 的缩写（有效的维护了代码，比如：一个人用int，一个人用long。最好用typedef来定义）
    size_t dataOutAvailable = 0; //size_t  是操作符sizeof返回的结果类型
    size_t dataOutMoved = 0;
    
    dataOutAvailable = (dataInLength + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    dataOut = malloc( dataOutAvailable * sizeof(uint8_t));
    memset((void *)dataOut, 0x0, dataOutAvailable);//将已开辟内存空间buffer的首 1 个字节的值设为值 0
    
    const void *ivDes = (const void *) [iv cStringUsingEncoding:NSASCIIStringEncoding];
    //CCCrypt函数 加密/解密
    ccStatus = CCCrypt(kCCDecrypt,//  加密/解密
                       kCCAlgorithmDES,//  加密根据哪个标准（des，3des，aes。。。。）
                       kCCOptionPKCS7Padding,//  选项分组密码算法(des:对每块分组加一次密  3DES：对每块分组加三个不同的密)
                       [key UTF8String],  //密钥    加密和解密的密钥必须一致
                       kCCKeySizeDES,//   DES 密钥的大小（kCCKeySizeDES=8）
                       ivDes, //  可选的初始矢量
                       dataIn, // 数据的存储单元
                       dataInLength,// 数据的大小
                       (void *)dataOut,// 用于返回数据
                       dataOutAvailable,
                       &dataOutMoved);
    
    NSStringEncoding encoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    NSString *result  = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)dataOut length:(NSUInteger)dataOutMoved] encoding:encoding];
    free(dataOut);
    return result;
}



//解密
+ (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer);
    return nil;
}
//加密
+ (NSString *)encrypt:(NSString *)sText key:(NSString *)key
{
    NSData* encryptData = [sText dataUsingEncoding:NSUTF8StringEncoding];
    const void *dataIn = (const void *)[encryptData bytes];
    size_t dataInLength = [encryptData length];
    
    /*
     DES加密 ：用CCCrypt函数加密一下，然后用base64编码
     */
    size_t dataOutAvailable = (dataInLength + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    uint8_t *dataOut = malloc( dataOutAvailable * sizeof(uint8_t));
    size_t dataOutMoved = 0;
    
    memset((void *)dataOut, 0x0, dataOutAvailable);//将已开辟内存空间buffer的首 1 个字节的值设为值 0
    
    NSString *initIv = @"123456";
    const void *vkey = (const void *) [key UTF8String];
    const void *iv = (const void *) [initIv UTF8String];
    
    //CCCrypt函数 加密
    CCCrypt(kCCEncrypt,//  加密
            kCCAlgorithmDES,//  加密根据哪个标准（des，3des，aes。。。。）
            kCCOptionPKCS7Padding | kCCOptionECBMode,//  选项分组密码算法(des:对每块分组加一次密  3DES：对每块分组加三个不同的密)
            vkey,  //密钥
            kCCKeySizeDES,//   DES 密钥的大小（kCCKeySizeDES=8）
            iv, //  可选的初始矢量
            dataIn, // 数据的存储单元
            dataInLength,// 数据的大小
            (void *)dataOut,// 用于返回数据
            dataOutAvailable,
            &dataOutMoved);
    
    //编码 base64
    NSData *data = [NSData dataWithBytesNoCopy:dataOut length:dataOutMoved];
    NSString *result= [data base64Encoding];
    return result;
}
//MD5加密
+ (NSString *)md5HexDigest:(NSString*)input
{
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (unsigned)strlen(str), result);
    NSMutableString *ret=[[NSMutableString alloc]init];//
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}
//字符串排序
+(NSString *)strKey:(NSString *)key
{
    NSMutableString * keystr =[[NSMutableString alloc]init];
    NSMutableArray * arr=[[NSMutableArray alloc]init];
    NSSortDescriptor *sd1 = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];//yes升序排列，no,降序排列
    
    for (int i = 0; i<[key length]; i++) {
        //截取字符串中的每一个字符
        NSString *s = [key substringWithRange:NSMakeRange(i, 1)];
        [arr addObject:s];
    }
    NSArray *myary = [arr sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sd1, nil]];
    
    for (NSString * str in myary) {
        
        [keystr appendString:str];
    }
    //arr = [arr sortedArrayUsingSelector:@selector(compare:)];
    return keystr;
}

//小写转大写
+(NSString *)toUpper:(NSString *)str
{
    for (NSInteger i=0; i<str.length; i++) {
        if ([str characterAtIndex:i]>='a'&[str characterAtIndex:i]<='z') {
            //A  65  a  97
            char  temp=[str characterAtIndex:i]-32;
            NSRange range=NSMakeRange(i, 1);
            str=[str stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"%c",temp]];
        }
    }
    return str;
}

//大写转小写
+(NSString *)toLower:(NSString *)str
{
    for (NSInteger i=0; i<str.length; i++)
    {
        if ([str characterAtIndex:i]>='A'&[str characterAtIndex:i]<='Z')
        {
            //A  65  a  97
            char  temp=[str characterAtIndex:i]+32;
            NSRange range=NSMakeRange(i, 1);
            str=[str stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"%c",temp]];
        }
    }
    return str;
}


+(NSString *)base64encode:(NSString *)encodeStr
{
    NSData *plainData = [encodeStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString * base64String = [plainData base64EncodedStringWithOptions:0];
    
    return base64String;
}

+(NSString *)base64Decode:(NSString *)decodeStr
{
    //判断参数是否加密过
    if (![self isBlankString:decodeStr]) {
        
        NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:decodeStr options:0];
        
        NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
        QFLOG(@"%@  %@  %@",decodeStr,decodedData,decodedString);

        if (![NSString isBlankString:decodedString]) {
            
            return decodedString;
            
        }
    }
   
    return decodeStr;
}

//处理base64字符串
+(NSString *)base64:(NSString *)str
{
    NSString * base64;
    base64 = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去除掉首尾的空白字符和换行字符
    base64 = [base64 stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    base64 = [base64 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return base64;
}
//字符串判断不为空
+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

/**
 *  检测对象是否存在该属性
 */
+ (BOOL)checkIsExistPropertyWithInstance:(id)instance verifyPropertyName:(NSString *)verifyPropertyName
{
    unsigned int outCount, i;
    
    // 获取对象里的属性列表
    objc_property_t * properties = class_copyPropertyList([instance
                                                           class], &outCount);

    for (i = 0; i < outCount; i++) {
        objc_property_t property =properties[i];
        //  属性名转成字符串
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        
        // 判断该属性是否存在
        if ([propertyName isEqualToString:verifyPropertyName]) {
            free(properties);
            return YES;
        }
    }
    free(properties);
    
    return NO;
}

/**
 *  获取版本号
 *
 *  @return 返回版本号
 */
+(NSString *)getCurVersion
{
    //获取版本号
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *nowVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
    
    return nowVersion;
}

/**
 *  对字符串进行替换操作
 *
 *  @param param  替换的原字符串
 *  @param param1 需要替换的字符串
 *  @param param2 替换成的字符串
 *
 *  @return 返回替换完成加密后的字符
 */
+(NSString *)replaceparam:(NSString *)param andparam1:(NSString *)param1 andparam2:(NSString *)param2
{
    NSString * encode =[NSString base64encode:[param stringByReplacingOccurrencesOfString:param1 withString:param2]];
    
    return encode;
}

/**
 *  七牛上传图片时对应的图片url
 *
 *  @return 返回拼接后的url
 */
+ (NSString *)setUpPhotoTime
{
    //获取当前时间
    NSDate *senddate=[NSDate date];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy/MM/dd"];
    NSString *locationString=[dateformatter stringFromDate:senddate];
    
    //获取时间戳 组成七牛上传需要的格式
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    
    NSInteger randomly=arc4random()%1000;
    NSString *key=[NSString stringWithFormat:@"files/%@/ios-V2-%@%ld.jpg",
                   locationString,timeString,(long)randomly];
    
    return key;
}
@end
