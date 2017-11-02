//
//  SubUI_ActionSheet.h
//  装修项目管理
//
//  Created by mmxd on 17/1/17.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZPhotoKit.h"
#import "WebViewController.h"
@interface SubUI_UpLoadPhoto : UIView<UIActionSheetDelegate>

//最大上传图片张数
@property (nonatomic,strong) NSString * maxcount;
//是否添加水印
@property (nonatomic,assign) BOOL  iswatermark;
//yes 直接使用相机拍照上传 NO 可以相机 可以相册
@property (nonatomic,assign) BOOL iscameraonly;

//点击重新上传的时候,传过来的对应图片key
@property (nonatomic,strong) NSString * imagekey;

//通知给前端的图片上传后状态回调
@property (nonatomic,strong) NSString * jscallbackimagenotify;
//生成base64传给前端
@property (nonatomic,strong) NSString * jscallbackbase64;
//前端页面上第几组图片上传
@property (nonatomic,strong) NSString * group;

//图片压缩尺寸
@property (nonatomic,assign) int  imgcompressionsize;
//base64压缩裁剪尺寸
@property (nonatomic,assign) int  imgbase64size;

@property (nonatomic,strong) WebViewController * vc;


/**
 *  初始化图片上传选择
 *
 *  @param frame   frame
 *  @param vc      当前控制器 
 *  @return 返回自己
 */
-(id)initWithFrame:(CGRect)frame vc:(WebViewController *)vc;

-(void)startloadPhotoEvent:(NSString *)loadstr;

@end
