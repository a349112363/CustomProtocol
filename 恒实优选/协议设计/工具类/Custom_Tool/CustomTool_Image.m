//
//  Control_Image.m
//  原生图片上传
//
//  Created by mmxd on 16/12/13.
//  Copyright © 2016年 mmxd. All rights reserved.
//

#import "CustomTool_Image.h"
#import "AFNetworking.h"
#import "CustomTool_Cache.h"

@implementation CustomTool_Image
{
    NSDate * _tokenDate;
}



-(id)initwith:(UIImage *)originImage imgcompressionsize:(int)imgcompressionsize imgbase64size:(int)imgbase64size
{
    if (self) {
        
        QFLOG(@"originImage-------%@",originImage);
        
        self.protocolimage = originImage;
        
        self.imgbase64size = imgbase64size;
        
        self.imgcompressionsize = imgcompressionsize;
        
        [self getImagbase64];
        
        //生成上传七牛 所需要的key
        self.keyvalue = [NSString setUpPhotoTime];
        
        //压缩后的图片
        self.compressionimageData = [NSData compressImage:self.protocolimage toMaxFileSize:self.imgcompressionsize];
        
        //使用当前上传的图片地址做为唯一key
        
        self.keyId = [NSString base64encode:[NSString stringWithFormat:@"%@",originImage]];
        
        self.token =[CustomTool_Cache appObjUserDefault:@"token"];
        
        //判断token是否请求失败 重新请求
        if (![NSString isBlankString:self.token] && ![self tokenEffectiveTime]) {
            
            [self uploadFile];
        }
        else
        {
            QFLOG(@"token 为空------------%@",self.token);
            
            [self getToken];
        }
    }
    return self;
}
/**
 *  获取token
 */
-(void)getToken
{
    AFHTTPSessionManager * manger =[[AFHTTPSessionManager alloc]init];
    
    [manger GET:[NSString stringWithFormat:@"%@/QiNiu/GetToken",PrefixId] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString * token = [responseObject objectForKey:@"Body"];
      
        _tokenDate =[[NSDate date] getNowDateFromatAnDate:[NSDate date]];
        
         QFLOG(@"申请七牛token ------%@ %@",token,_tokenDate);
        [CustomTool_Cache appSetUserDefaults:_tokenDate andKey:@"tokenDate"];
    
        [CustomTool_Cache appSetUserDefaults:token andKey:@"token"];
        
        [self uploadFile];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
         [self uploadFile];
        
        QFLOG(@"申请七牛token error ---------%@",error);
        
    }];
    
}

//判断七牛token 有效时间
-(BOOL)tokenEffectiveTime
{
    //用当前时间跟获取token 时间进行比较 转换时区
    NSDate * date =[[NSDate date] getNowDateFromatAnDate:[NSDate date]];
    NSDateComponents * compes =[date dateFrom:[CustomTool_Cache appObjUserDefault:@"tokenDate"]];
    
    //超过有效时间就清零
    if (compes.minute >= 30) {
        
        self.token =@"";
        
        [CustomTool_Cache appSetUserDefaults:self.token andKey:@"token"];

        return YES;
    }
    
    QFLOG(@"token 没超时 %@",self.token);
    
    return NO;
    
}
/**
 *  图片转成base64小图
 */
-(void)getImagbase64
{
    if (self) {
        
        UIImage * scaleimage = [UIImage scaleFromImage:self.protocolimage toSize:CGSizeMake(self.imgbase64size, self.imgbase64size)];
        
        NSData * imageData = UIImageJPEGRepresentation(scaleimage, 1.0);
        //转成base64 传给前端显示小图
        NSString * encodedImageStr = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        
        self.Imagebase64 = [NSString base64:encodedImageStr];
    }
}

/**
 *  开启七牛上传图片
 */
-(void)uploadFile
{
    //判断token是否请求失败 重新请求
    if ([NSString isBlankString:self.token]) {
        
        self.token = [CustomTool_Cache appObjUserDefault:@"token"];
        
    }
  
    
    //七牛进度回调接口 里面包含进度条 上传key
    QNUploadOption *opt = [[QNUploadOption alloc] initWithMime:nil progressHandler:^(NSString *key, float percent)
                           {
                               
                               
                           } params:nil checkCrc:NO cancellationSignal:^ BOOL (){
                               //返回yes 停止上传
                               if (self.cancellBlock) {
                                   
                                   QFLOG(@"取消上传");
                                   
                               }
                               else
                               {
                                   // QFLOG(@"继续上传");
                                   
                               }
                               return self.cancellBlock;
                               
                           }];
    
    
    QNUploadManager *upManager=[[QNUploadManager alloc] init];
    

    [upManager putData:self.compressionimageData key:self.keyvalue token:self.token complete:^(QNResponseInfo *info, NSString *keys, NSDictionary *resp) {
        
        QFLOG(@"%d  %@ %@",info.statusCode,resp,self.token);
        if (info.statusCode == 200 && resp)
        {
            
            self.ImageWebUrl = [NSString stringWithFormat:@"%@",resp[@"Body"]];
            
            //成功的block
            if (self.sucessBlock) {
                
                self.sucessBlock(self.keyId,self.ImageWebUrl);
                
            }
            
            QFLOG(@"图片上传成功 sucess   %d  %@   %@",info.statusCode,self.keyId,self.ImageWebUrl);
            
        }
        else
        {
            
            //当取消上传不需要保存该图片
            if (info.statusCode == -999) {
                
                QFLOG(@"取消该图片%@上传",self.keyId);
            }
           
            else
            {
                //判断 没有token  的情况 和 后台设置token 有效时间失效
                if (info.statusCode == -3 || info.statusCode == 401)
                {
                    [CustomTool_Cache appSetUserDefaults:@" " andKey:@"token"];
                }
            
                if (![[AppDelegate appdelegate].SaveImageObj objectForKey:self.keyId]) {
                    
                    [[AppDelegate appdelegate].SaveImageObj setObject:self forKey:self.keyId];
                }
                
                //失败的block
                if (self.errorBlock) {
                    
                    self.errorBlock(self.keyId);
                }
            }
        }
    } option:opt];
}


-(void)dealloc
{
    QFLOG(@"已经销毁了-------------------%@",self);
    
 
}

@end
