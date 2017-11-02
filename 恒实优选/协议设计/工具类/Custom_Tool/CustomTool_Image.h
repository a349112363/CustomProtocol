//
//  CustomTool_Image.h
//  原生图片上传
//
//  Created by mmxd on 16/12/13.
//  Copyright © 2016年 mmxd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"


/**
 *  成功回调的block
 *
 *  @param sucesspath 成功图片路径
 *  @param sucesskey   成功图片key
 */
typedef void(^sucessImage)(NSString * sucessimagekey,NSString * sucessimageurl);

/**
 *  失败回调block
 *
 *  @param errorpath 失败图片路径
 *  @param errorkey  失败图片key
 */
typedef void(^errorImage)(NSString * errorimagekey);


@interface CustomTool_Image : NSObject

//控制是否上传
@property (nonatomic,assign)BOOL cancellBlock;
//成功回调
@property (nonatomic,strong)sucessImage  sucessBlock;
//失败回调
@property (nonatomic,strong)errorImage  errorBlock;

//image 对象
@property (nonatomic,strong) UIImage *protocolimage;

//图片路径
@property (nonatomic,strong) NSString * imagePath;

//图片压缩后base64
@property (nonatomic,strong) NSString * Imagebase64;

//图片上传成功后返回的链接
@property (nonatomic,strong) NSString * ImageWebUrl;

//上传图片每张图片分别对应的key 保存 或者 取出数据时候标识(用每张图片对象的指针地址作为唯一标识)
@property (nonatomic,strong) NSString * keyId;

//保存上传失败图片路径
@property (nonatomic,strong) NSMutableDictionary * saveErrorImage;

//接收七牛token
@property (nonatomic,strong) NSString * token;

@property (nonatomic,strong) NSString * keyvalue;


@property (nonatomic,strong) NSData * compressionimageData;

//图片压缩尺寸
@property (nonatomic,assign) int  imgcompressionsize;
//base64压缩裁剪尺寸
@property (nonatomic,assign) int  imgbase64size;



//构造函数获取当前图片和七牛token值
-(id)initwith:(UIImage *)originImage imgcompressionsize:(int)imgcompressionsize imgbase64size:(int)imgbase64size;

-(void)uploadFile;
@end
