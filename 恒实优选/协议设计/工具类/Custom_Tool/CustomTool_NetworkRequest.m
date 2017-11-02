//
//  Tool_NetworkRequest.m
//  装修项目管理
//
//  Created by mmxd on 17/1/13.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import "CustomTool_NetworkRequest.h"
#import "QFalertView.h"


@implementation CustomTool_NetworkRequest

+(void)initIsNewApp
{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    [CustomTool_NetworkRequest AFNetworkHttpHrader:manager];
   
    [manager POST:[NSString stringWithFormat:@"%@%@",PrefixId,Version_Key] parameters:@{@"dictAppType":@"10",@"curVersion":[NSString getCurVersion],@"TelCode":UUID_Value}  progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        QFLOG(@"版本更新请求信息------------%@ %@",responseObject,UUID_Value);
        
        id dictionary=[responseObject objectForKey:@"Body"];
        
        if (dictionary!=[NSNull null] && [dictionary isKindOfClass:[NSDictionary class]])
        {
            
            //创建更新弹框
            QFalertView * alertview =[[QFalertView alloc]initWithFrame:[UIScreen mainScreen].bounds];

            [[AppDelegate appdelegate].window addSubview:alertview];
           
               
                alertview.messageStr = dictionary[@"Mark"];
                alertview.url = dictionary[@"UpdateUrl"];
                
                if (dictionary[@"IsForceUpdate"])
                {
                    //强制更新
                    alertview.isUpdate = YES;
                }
                else
                {
                    alertview.isUpdate = NO;
                }
                
                [alertview viewShow];
        

        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        QFLOG(@"Error:版本请求更新出错------- %@", error);
    }];
    
    
}

//统计页面加载时间
-(void)appViewRequestDate:(NSString *)DateStr url:(NSString *)weburl
{
    
    AFHTTPSessionManager * manger =[[AFHTTPSessionManager alloc]init];
    
    [manger POST:[NSString stringWithFormat:@"%@/ErrorLog/AddLog",PrefixId] parameters:@{@"DictSystemType":@"ios",@"Message":DateStr,@"APPVersion":[NSString getCurVersion],@"mTerminal":UUID_Value,@"Request":weburl} progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        QFLOG(@"统计页面加载时间 %@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        QFLOG(@"%@",error);
    }];
    
}


//请求页面是否登录
+(void)initrequestHttp:(NSString *)path andDicValue:(NSDictionary *)dic
{
    AFHTTPSessionManager * manger =[AFHTTPSessionManager manager];
    
    [manger GET:path parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        BOOL islogin = [responseObject[@"Body"] boolValue];
        
        QFLOG(@"是否登录----------》 %d",islogin);
        [CustomTool_Cache appSetUserDefaults:[NSNumber numberWithBool:islogin] andKey:BOOL_KEY];
        
        if (islogin == NO) {
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        QFLOG(@"判断是否登录出错------------------%@",error);
    }];
    
}
//退出登录页面请求
+(void)initSigeHttp:(NSString *)path andDicValue:(NSDictionary *)dic
{
    QFLOG(@"进入退出登录");
    AFHTTPSessionManager * manger =[AFHTTPSessionManager manager];
    
    [manger GET:path parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        BOOL islogin = [responseObject[@"Body"] boolValue];
        

        if (islogin) {
            
            [CustomTool_Cache appSetUserDefaults:[NSNumber numberWithBool:!islogin] andKey:BOOL_KEY];

            QFLOG(@"退出登录成功");
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        QFLOG(@"退出登录出错---------------%@",error);
    }];
    
}




/*
 *请求HTTP头信息 给后台传送类型 和版本号
 */
+(void)AFNetworkHttpHrader:(AFHTTPSessionManager *)manager
{
    [manager.requestSerializer setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"App-Type"];
    [manager.requestSerializer setValue:[NSString getCurVersion] forHTTPHeaderField:@"App-Version"];
}

@end
