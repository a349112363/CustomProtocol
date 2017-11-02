//
//  Tool_UpLoadPhoto.m
//  装修项目管理
//
//  Created by mmxd on 17/1/17.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import "Tool_UpLoadPhoto.h"
#import "SubUI_UpLoadPhoto.h"
@implementation Tool_UpLoadPhoto
{
    SubUI_UpLoadPhoto * sheet;
}
-(void)run
{
    
    NSString * loadstr =[self.path stringByReplacingOccurrencesOfString:@"/" withString:@""];
    
    //初始化上传页面
    sheet =[[SubUI_UpLoadPhoto alloc]initWithFrame:self.protocolVC.view.bounds vc:self.protocolVC];
    
    //只有需要选择图片或者拍照的时候 才添加
    if ([loadstr isEqualToString:@"Startuploading"])
    {
        [self.protocolVC.view addSubview:sheet];
        
    }
    //对数据赋值
    [super run];
    
    if ([NSString isBlankString:self.imgcompressionsize]) {
        
        self.imgcompressionsize = @"300";
    }
    //执行该对象上传事件
    [sheet startloadPhotoEvent:loadstr];
    
}
//设置上传图片最大张数
-(void)setmaxcount
{
    sheet.maxcount = self.maxcount;
}
//设置是否添加水印
-(void)setiswatermark
{
    sheet.iswatermark = self.iswatermark;
    
}
//得到重新上传图片对应的key
-(void)setimagekey
{
    //上传图片的时候 给前端标识的key 是加密的  重新得到key 解密  后面用起来方便
    //sheet.imagekey = [NSString base64Decode:self.imagekey];
    sheet.imagekey = self.imagekey;

}
//设置是否直接选择相机上传
-(void)setiscameraonly
{
    sheet.iscameraonly = self.iscameraonly;
    
}
//开始上传图片后成功或失败的回调
-(void)setjscallbackimagenotify
{
    sheet.jscallbackimagenotify = [NSString base64Decode:self.jscallbackimagenotify];
    
    QFLOG(@"%@  %@",self.jscallbackimagenotify,sheet.jscallbackimagenotify);

}

//上传图片生成base64图片
-(void)setjscallbackbase64
{
    sheet.jscallbackbase64 = [NSString  base64Decode:self.jscallbackbase64];
    
}
//当前页面上图片对应第几组
-(void)setgroup
{
    
    sheet.group = self.group;
}
//前端显示小图尺寸
-(void)setimgbase64size
{
    sheet.imgbase64size = [self.imgbase64size intValue];
}
//压缩后的大小
-(void)setimgcompressionsize
{
    sheet.imgcompressionsize = [self.imgcompressionsize intValue];
    
}

@end
