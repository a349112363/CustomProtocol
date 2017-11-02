//
//  AppDelegate+GTPush.m
//  恒实优选
//
//  Created by 邱凡Bookpro on 2017/10/16.
//  Copyright © 2017年 shenzhenHengshi. All rights reserved.
//

#import "AppDelegate+GTPush.h"

@implementation AppDelegate (GTPush)
#pragma mark - 用户通知(推送)回调 _IOS 8.0以上使用

/** 已登记用户通知 */
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    
    [application registerForRemoteNotifications];
}

#pragma mark - 远程通知(推送)回调

/** SDK启动成功返回cid */
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId {
    //个推SDK已注册，返回clientId
    QFLOG(@"\n>>>[GeTuiSdk RegisterClient]:%@\n\n", clientId);
}

/** SDK遇到错误回调 */
- (void)GeTuiSdkDidOccurError:(NSError *)error {
    //个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
    QFLOG(@"\n>>>[GexinSdk error]:%@\n\n", [error localizedDescription]);
}

/** 注册 APNs */
- (void)registerRemoteNotification {
    /*
     警告：Xcode8 需要手动开启"TARGETS -> Capabilities -> Push Notifications"
     */
    
    /*
     警告：该方法需要开发者自定义，以下代码根据 APP 支持的 iOS 系统不同，代码可以对应修改。
     以下为演示代码，注意根据实际需要修改，注意测试支持的 iOS 系统都能获取到 DeviceToken
     */
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0 // Xcode 8编译会调用
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay) completionHandler:^(BOOL granted, NSError *_Nullable error) {
            if (!error) {
                QFLOG(@"request authorization succeeded!");
            }
        }];
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
#else // Xcode 7编译会调用
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
#endif
    } else if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    } else {
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert |
                                                                       UIRemoteNotificationTypeSound |
                                                                       UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }
}


/** 远程通知注册成功委托 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *myToken = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    myToken = [myToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [GeTuiSdk registerDeviceToken:myToken];
    
    [CustomTool_Cache appSetUserDefaults:myToken andKey:@"DeviceToken"];
    
    QFLOG(@"\n>>>[DeviceToken Success]:%@\n\n",myToken);
}
//
/** 远程通知注册失败委托 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
    [GeTuiSdk registerDeviceToken:@""];
    
}

#pragma mark - APP运行中接收到通知(推送)处理
/** APP已经接收到“远程”通知(推送) - (App运行在后台/App运行在前台) */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    QFLOG(@"%@",userInfo);
    
    if (userInfo[@"protocalStr"]) {
        
        //判断当前显示的控制器是GJJTabBarViewController
        if ([self.window.rootViewController isKindOfClass:[GJJTabBarViewController class]]) {
            
            // GJJTabBarViewController * tab =(GJJTabBarViewController *)self.window.rootViewController;
            
            //判断推送过来的字符串不为空 并且不是登录页面
            if (![NSString isBlankString:userInfo[@"protocalStr"]]) {
                
                //APP 并未关闭,从后台运行到前台的时候
                [self performSelector:@selector(setProtocol:) withObject:userInfo[@"protocalStr"] afterDelay:1];
                
            }
            
        }
    }
    
}

//执行协议
-(void)setProtocol:(id)obj
{
    //判断首页是GJJTabBarViewController
    if ([self.window.rootViewController isKindOfClass:[GJJTabBarViewController class]]) {
        
        //GJJTabBarViewController * tab =(GJJTabBarViewController *)self.window.rootViewController;
        // QFNavigationController * nav =(QFNavigationController *)tab.selectedViewController;
        //判断登录页面不存在 参数也不为空
        if (![NSString isBlankString:obj]) {
            //找到当前控制器 执行协议
            //            SuperViewController * currentVC =nav.viewControllers.lastObject;
            //            [currentVC protocolCallback:obj];
        }
    }
}



#pragma mark - GeTuiSdkDelegate
//** SDK收到透传消息回调 */
- (void)GeTuiSdkDidReceivePayloadData:(NSData *)payloadData andTaskId:(NSString *)taskId andMsgId:(NSString *)msgId andOffLine:(BOOL)offLine fromGtAppId:(NSString *)appId;
{
    
    NSString *payloadMsg = nil;
    if (payloadData) {
        payloadMsg = [[NSString alloc] initWithBytes:payloadData.bytes length:payloadData.length encoding:NSUTF8StringEncoding];
    }
    
    //    NSString *msg = [NSString stringWithFormat:@"taskId=%@,messageId:%@,payloadMsg:%@%@",taskId,msgId,payloadMsg,offLine ? @"<离线消息>" : @""];
    
    [GeTuiSdk sendFeedbackMessage:90001 andTaskId:taskId andMsgId:msgId];
    
}

/** APP已经接收到“远程”通知(推送) - APNs静默推送 预留在app 运行中接收到推送 执行相应事情  */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    //接收到推送后 先取偏好设置中的推送个数
    NSString * pushstr = [CustomTool_Cache appObjUserDefault:@"applicationIconBadgeNumber"];
    NSInteger pushnumber = [pushstr integerValue];
    if (pushnumber >= 0) {
        //每次进行加1
        pushnumber ++;
    }
    else
    {
        pushnumber = 0;
        pushnumber ++;
    }
    application.applicationIconBadgeNumber = pushnumber;
    //保存小红点个数
    [CustomTool_Cache appSetUserDefaults:@(pushnumber) andKey:@"applicationIconBadgeNumber"];
    completionHandler(UIBackgroundFetchResultNewData);
}

/** SDK收到sendMessage消息回调 */
- (void)GeTuiSdkDidSendMessage:(NSString *)messageId result:(int)result {
    
    NSString *msg = [NSString stringWithFormat:@"sendmessage=%@,result=%d", messageId, result];
    QFLOG(@"%s---------%@",__FUNCTION__,msg);
}
/** SDK运行状态通知 */
- (void)GeTuiSDkDidNotifySdkState:(SdkStatus)aStatus {
    
}
/** SDK设置推送模式回调 */
- (void)GeTuiSdkDidSetPushMode:(BOOL)isModeOff error:(NSError *)error {
    if (error) {
        return;
    }
    
}
- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    /// Background Fetch 恢复SDK 运行
    [GeTuiSdk resume];
    completionHandler(UIBackgroundFetchResultNewData);
}

@end
