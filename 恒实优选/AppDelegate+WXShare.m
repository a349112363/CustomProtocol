//
//  AppDelegate+WXShare.m
//  恒实优选
//
//  Created by 邱凡Bookpro on 2017/10/16.
//  Copyright © 2017年 shenzhenHengshi. All rights reserved.
//

#import "AppDelegate+WXShare.h"

@implementation AppDelegate (WXShare)

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WXApi handleOpenURL:url delegate:self];
}

/**
 微信分享回调
 
 @param resp 回调信息内容
 */
- (void)onResp:(BaseResp *)resp {
    
    //把返回的类型转换成与发送时相对于的返回类型,这里为SendMessageToWXResp
    SendMessageToWXResp *sendResp = (SendMessageToWXResp *)resp;
    
    //使用UIAlertView 显示回调信息
    NSString *str = [NSString stringWithFormat:@"%d",sendResp.errCode];
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"回调信息" message:str delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    [alertview show];
}
@end
