//
//  AppDelegate.h
//  恒实优选
//
//  Created by 邱凡Bookpro on 2017/10/16.
//  Copyright © 2017年 shenzhenHengshi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <WXApi.h>
#import <GeTuiSdk.h>
// iOS10 及以上需导入 UserNotifications.framework
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif

#import "GJJTabBarViewController.h"




@interface AppDelegate :UIResponder<UIApplicationDelegate, WXApiDelegate,GeTuiSdkDelegate, UNUserNotificationCenterDelegate>


@property (strong, nonatomic) UIWindow *window;
//保存上传失败的图片对象
@property (nonatomic,strong) NSMutableDictionary * SaveImageObj;
@property (nonatomic,strong) NSMutableArray * SaveImages;

//上传图片 图片对应的序号给前端 将base64 图片排序
@property (nonatomic,assign) int uploadImagesort;

+(AppDelegate *)appdelegate;


@end

