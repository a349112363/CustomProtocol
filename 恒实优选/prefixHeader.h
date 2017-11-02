//
//  prefixHeader.h
//  装修项目管理
//
//  Created by mmxd on 16/9/28.
//  Copyright © 2016年 mmxd. All rights reserved.
//

#ifndef prefixHeader_h
#define prefixHeader_h


#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "QiniuSDK.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "Masonry.h"
#import "JSONKit.h"
#import "UIColor+UIColorExtension.h"
#import "UIView+LQXkeyboard.h"
#import "NSDictionary+NSDictionaryExtension.h"
#import "UITabBarController+Badge.h"
#import "UILabel+UILabelExtension.h"
#import "UIButton+UIButtonExtension.h"
#import "NSString+NSStringExtension.h"
#import "NSDate+NSDateExtension.h"
#import "NSData+NSDataExtension.h"
#import "UIImage+UIImageExtension.h"
#import "Dataserialization.h"
#import "CustomTool_Cache.h"
#import "CustomTool_Other.h"
#import "CustomTool_NetworkRequest.h"
#import "VCPermissionsEnum.h"


//判断系统版本
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
// 判断版本是否大于目前版本
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
// 判断版本是否大于等于目前版本
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define IS_OS_5_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
#define IS_OS_6_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define IS_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
//判断是否大于 IOS7
#define IS_IOS7 SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")

//判断是否是iphone5
#define IS_WIDESCREEN                              ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - (double)568 ) < __DBL_EPSILON__ )
#define IS_IPHONE                                  ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPhone" ] || [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPhone Simulator" ])
#define IS_IPOD                                    ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPod touch" ] )
#define IS_IPHONE_5                                ( IS_IPHONE && IS_WIDESCREEN )


//全局唯一的window
#define KEY_WINDOW  [[UIApplication sharedApplication] keyWindow]
//动态获取设备高度
#define IPHONE_HEIGHT [UIScreen mainScreen].bounds.size.height
//动态获取设备宽度
#define IPHONE_WIDTH [UIScreen mainScreen].bounds.size.width
#define IPHONE_ZERO 0
#define _IPHONE80_ 80000


#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define NavgationBarTintColor  @"b43124"

//机器码沙盒KEY 值
#define UUID_Key        @"TelCode"
//协议头
#define Protocol_Header @"gjj://"
//沙盒取出登录状态的key
#define BOOL_KEY @"bool"

//取出沙盒中保存的机器码
#define UUID_Value   [[NSUserDefaults standardUserDefaults] objectForKey:UUID_Key]


#ifndef __OPTIMIZE__
#define QFLOG(...) NSLog(__VA_ARGS__)
#else
#define QFLOG(...){}
#endif




#define PrefixId  @"http://www.hupo3.com"//测试服

//#define PrefixId  @"http://192.168.1.104:9090/app.html"//测试服


//#define PrefixId  [[NSUserDefaults standardUserDefaults] stringForKey:@"name_preference"]

#define MyINDEX_KEY       @"/Home/Index?telcode="//更新后首页加载页面
#define Project_KEY       @"/OAProject/MyJoinProjectView?telcode="//项目加载页面
#define Construction_KEY  @"/OAProject/MyJoinConstructionProjectView?telcode="//施工页面

#define Login_KEY    @"/Account/SubmitLogin"//登录接口
#define OUTSIGEN_KEY @"/Account/SubmitLogout"//退出登录接口
#define ISLogin_KEY  @"/Account/IsLogin"//判断是否登录
#define Version_Key  @"/Home/GetAppLastestVersion"//版本更新



#endif /* prefixHeader_h */

