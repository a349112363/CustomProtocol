//
//  Tool_Other.m
//  装修项目管理
//
//  Created by mmxd on 17/1/13.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import "CustomTool_Other.h"
#import <Photos/Photos.h>
#import "ProtocolClass.h"

@implementation CustomTool_Other

/*
 *第一次进入应用保存机器码
 */
+(void)IsFirstGoInApp
{
    NSString * key =@"CFBundleShortVersionString";
    NSString * currentVersion =[NSBundle mainBundle].infoDictionary[key];
    NSString * sonBoxVersion  =[[NSUserDefaults standardUserDefaults]objectForKey:key];
    if (![currentVersion isEqualToString:sonBoxVersion])
    {
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSUserDefaults standardUserDefaults] setObject:[CustomTool_Other UUID] forKey:UUID_Key];
        [[NSUserDefaults standardUserDefaults] synchronize];
     
       
//        NSDictionary * data_dic =@{@"VC-item0":@[@"gjj://Control.SearchBar/Create/HeadCenter/201?placeholder=搜索",
//                                                 @"gjj://Control.Button/Create/headRight/300?foreimage=icondesign&foreimagealignment=imageright&eventString=Z2pqOi8vVG9vbC5UYWJCYXI/aXRlbWluZGV4PTImc2VsZWN0ZWQ9eWVz"],
//                                   @"VC-item1":@[@"gjj://Control.Label/Create/HeadCenter/201?text=标题&textColor=FFFFFF&textalignment=textcenter&fontsize=20",
//                                                 @"gjj://Control.Button/Create/headRight/300?foreimage=icondesign&foreimagealignment=imageright&eventString=Z2pqOi8vVG9vbC5UYWJCYXI/aXRlbWluZGV4PTImc2VsZWN0ZWQ9eWVz"],
//                                   @"VC-item2":@[@"gjj://Control.SearchBar/Create/HeadCenter/201?placeholder=搜索",
//                                                 @"gjj://Control.Button/Create/headRight/300?foreimage=icondesign&foreimagealignment=imageright&eventString=Z2pqOi8vVG9vbC5UYWJCYXI/aXRlbWluZGV4PTImc2VsZWN0ZWQ9eWVz"],
//                                   @"VC-item3":@[@"gjj://Control.SearchBar/Create/HeadCenter/201?placeholder=搜索",
//                                                 @"gjj://Control.Button/Create/headRight/300?foreimage=icondesign&foreimagealignment=imageright&eventString=Z2pqOi8vVG9vbC5UYWJCYXI/aXRlbWluZGV4PTImc2VsZWN0ZWQ9eWVz"],
//                                   @"VC-item4":@[@"gjj://Control.SearchBar/Create/HeadCenter/201?placeholder=搜索",
//                                                 @"gjj://Control.Button/Create/headRight/300?foreimage=icondesign&foreimagealignment=imageright&eventString=Z2pqOi8vVG9vbC5UYWJCYXI/aXRlbWluZGV4PTImc2VsZWN0ZWQ9eWVz"]};
//        
//        
//        NSString * str = [NSString stringWithFormat:@"gjj://Tool.DataOperation/creater?filename=rootplist.plist&data=%@",[NSString base64encode:[data_dic JSONString]]];
//        
//        
//        [ProtocolClass ProtocolFactroy:str vc:nil];
    }
    
}

/*
 *产生一个UUID 拼接8位随机字符串
 */
+(NSString *)UUID
{
    
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < 8; i++) {
        int number = arc4random() % 36;
        
        if (number < 20) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            string = [string stringByAppendingString:tempString];
        }else {
            int figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
        }
    }
    
    NSString *udid = [SecureUDID UDIDForDomain:@"comtop" usingKey:@"eMeeting"];
    
    udid = [NSString stringWithFormat:@"%@_%@",udid,string];
    
    return udid;
}



@end
