//
//  VCPermissionsEnum.h
//  装修项目管理
//
//  Created by mmxd on 16/12/21.
//  Copyright © 2016年 mmxd. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 判断VC控制器是否需要权限
 */
typedef enum : int {
    CameraPermissions = 1 , //二进制  1  摄像头权限
    LocationPermissions = 2 , //二进制  10  定位权限
    NetPermissions = 4,   //二进制  100      网络流量权限
    VoicePermissions = 8 //二进制  1000      语音权限

} VCPermissionsenum;



/**
 *  控件内容居左 居右 居中枚举
 */

typedef enum {
    
    ControlPositionLeft ,
    ControlPositionRight,
    ControlPositionCenter

} ControlPositionEnum;




//点击登录按钮执行eventstring 事件,关闭登录页面后 刷新webview
#define LoginBtnClikcNotficationCenter @"LoginBtnClikcNotficationCenter"

//接收到个推推送消息,首页是登录页面,通过通知中心 让登录页面接收参数 点击登录后,再将参数传给下一个页面执行相应事件
#define LoginVCGetGTPushNotficationCenter @"LoginVCGetGTPushNotficationCenter"

//个推推送消息,跳转到指定页面 通过通知中心传递参数并执行
#define TabBarVCGetGTPushNotficationCenter @"TabBarVCGetGTPushNotficationCenter"