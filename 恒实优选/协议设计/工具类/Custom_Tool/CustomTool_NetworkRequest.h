//
//  Tool_NetworkRequest.h
//  装修项目管理
//
//  Created by mmxd on 17/1/13.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomTool_NetworkRequest : NSObject

//app是否更新
+(void)initIsNewApp;

//统计页面加载时间
-(void)appViewRequestDate:(NSString *)DateStr url:(NSString *)weburl;

//http头数据
+(void)AFNetworkHttpHrader:(AFHTTPSessionManager *)manager;

//判断是否登录
+(void)initrequestHttp:(NSString *)path andDicValue:(NSDictionary *)dic;

//退出登录页面请求
+(void)initSigeHttp:(NSString *)path andDicValue:(NSDictionary *)dic;


@end
