//
//  Open_Native.m
//  装修项目管理
//
//  Created by mmxd on 16/12/20.
//  Copyright © 2016年 mmxd. All rights reserved.
//

#import "Open_Native.h"
#import "SuperViewController.h"
#import "VCPermissionsEnum.h"
#import <AVFoundation/AVFoundation.h>
@implementation Open_Native

-(void)run
{
    //对self class  自己类属性赋值
    [super run];
    //取出原生类名
    NSString * classname = [self.path stringByReplacingOccurrencesOfString:@"/" withString:@""];
    //拼接出控制器名称
    NSString * vcname = [NSString stringWithFormat:@"%@ViewController",classname];
    //反射出控制器
    Class class = NSClassFromString(vcname);
    SuperViewController * vc =[[class alloc]init];
   
    //对当前控制器类属性查看赋值
    [self.parameter enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop) {
        
        //统一将属性名大写改小写
        NSString *tolowerKey = [NSString toLower:key];
        
        //判断类中是否存在该属性
        if ([NSString checkIsExistPropertyWithInstance:vc verifyPropertyName:tolowerKey])
        {
            //找到类属性 给属性赋值
            [vc setValue:value forKey:tolowerKey];
        }
        else
        {
            QFLOG(@"%@类----------------不存在该%@属性",vc,tolowerKey);
        }
        
    }];
   // vc.projectid = self.projectid;
    
    //判断当前控制器中是否存在权限判断枚举 如果有 进行判断 (先在对应控制器中设置好对应枚举默认值)
    if ([NSString checkIsExistPropertyWithInstance:vc verifyPropertyName:@"vcp"]) {
        
        if ((vc.vcp & CameraPermissions) == CameraPermissions)
        {
            //如果是需要摄像头权限
            if (!([self validateCamera] && [self canUseCamera]))
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有摄像头或摄像头不可用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
                return;//不能启动VC；
            }
        }
        if ((vc.vcp & LocationPermissions ) == LocationPermissions)
        {//如果是需要定位权限
            
        }
        if ((vc.vcp & NetPermissions ) == NetPermissions)
        {//如果是需要网络权限
            
        }
        if((vc.vcp & VoicePermissions ) == VoicePermissions)
        {//如果是需要语音权限
        
        }

    }
 
    //将上传图片类本地图片保存 传给浏览图片类
    if (self.protocolVC.SaveLocalImage.count > 0) {
        
        vc.SaveLocalImage = self.protocolVC.SaveLocalImage;

    }
    //当等于登录页面的时候 用模态 否则 push
    if ([classname isEqualToString:@"LogIn"]) {
        
        [self.protocolVC presentViewController:vc animated:YES completion:^{
            
        }];
    }
    else
    {
        //当前控制器是否可以侧滑,父类控制器设置
      
//        vc.isslide = self.isslide;
//        vc.headbackgroundcolor = self.headbackgroundcolor;
//        vc.istransparent = self.istransparent;
        [self.protocolVC.navigationController pushViewController:vc animated:YES];
    }
    
    QFLOG(@"打开原生页面控制器VC------------------%@",vc);

    //打开新页面初始化新页面控件
    if (![NSString isBlankString:self.initwebview]) {
        
        NSString * initwebview =[NSString base64Decode:self.initwebview];
        NSArray * Protocols =[Dataserialization JSONObjectWithData:initwebview];
        
        if (Protocols.count > 0) {
            
            for (int i = 0 ; i<Protocols.count; i++)
            {
                if (![NSString isBlankString:Protocols[i]] && [Protocols[i] hasPrefix:Protocol_Header])
                {
                    [ProtocolClass ProtocolFactroy:Protocols[i] vc:[self.protocolVC.navigationController.viewControllers lastObject]];
                }
            }
        }
    }
}

//判断是否开启相机权限
-(BOOL)canUseCamera {
    
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        
        QFLOG(@"相机权限受限");
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请在设备的设置-隐私-相机中允许访问相机。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alertView show];
        return NO;
    }
    
    return YES;
}
//判断是否有摄像头
-(BOOL)validateCamera {
    
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] &&
    [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}
@end
