//
//  Tool_UpLoadPhoto.h
//  装修项目管理
//
//  Created by mmxd on 17/1/17.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import "ProtocolClass.h"

@interface Tool_UpLoadPhoto : ProtocolClass<UIActionSheetDelegate>
//最大上传图片张数
@property (nonatomic,strong) NSString * maxcount;
//是否添加水印
@property (nonatomic,assign) bool  iswatermark;

@property (nonatomic,assign) bool iscameraonly;

@property (nonatomic,strong) NSString * jscallbackimagenotify;//

@property (nonatomic,strong) NSString * jscallbackbase64;
//点击重新上传的时候,传过来的对应图片key
@property (nonatomic,strong) NSString * imagekey;

//前端页面对应的第几组图片
@property (nonatomic,strong) NSString * group;


//图片压缩尺寸
@property (nonatomic,strong) NSString *  imgcompressionsize;
//base64压缩裁剪尺寸
@property (nonatomic,strong) NSString *  imgbase64size;

@end
