//
//  AppDelegate.m
//  恒实优选
//
//  Created by 邱凡Bookpro on 2017/10/16.
//  Copyright © 2017年 shenzhenHengshi. All rights reserved.
//

#define WXApiAppID @"wx2e2c703fedf7f440"
#import "AppDelegate.h"
#import "AppDelegate+WXShare.h"
#import "AppDelegate+GTPush.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

-(NSMutableArray *)SaveImages
{
    if (_SaveImages == nil) {
        
        _SaveImages =[[NSMutableArray alloc]init];
    }
    return _SaveImages;
}



-(NSMutableDictionary *)SaveImageObj
{
    if (_SaveImageObj == nil) {
        
        _SaveImageObj =[NSMutableDictionary dictionary];
    }
    
    return _SaveImageObj;
}

+(AppDelegate *)appdelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window =[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor =[UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [WXApi registerApp:WXApiAppID];
    
    //第一次进入app 保存机器码
    [CustomTool_Other IsFirstGoInApp];
    GJJTabBarViewController * tabbarVC =[[GJJTabBarViewController alloc]init];
    tabbarVC.selectedIndex = 2;
    self.window.rootViewController = tabbarVC;
    //    [GeTuiSdk startSdkWithAppId:kGtAppId
    //                         appKey:kGtAppKey
    //                      appSecret:kGtAppSecret
    //                       delegate:self];
    
    // 注册APNS
   // [self registerRemoteNotification];
    
    return YES;
}


- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
