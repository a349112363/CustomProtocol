//
//  Open_Resourcrs_HTML.m
//  装修项目管理
//
//  Created by mmxd on 16/12/9.
//  Copyright © 2016年 mmxd. All rights reserved.
//

#import "Open_Resourcrs_HTML.h"
#import "WebViewController.h"
@implementation Open_Resourcrs_HTML

//打开本地HTML 
- (void) run
{
    
    NSString * resoucersPath = [self.path stringByReplacingOccurrencesOfString:@"/" withString:@""];
    
    
//    sup * vc = [[WebViewController alloc] init];
//
//    vc.locatinHtml = resoucersPath;
//   
//    [self.protocolVC.navigationController pushViewController:vc animated:YES ];
    
    
    //打开新页面初始化新页面控件
    if (![NSString isBlankString:self.initwebview]) {
        
        NSString * initwebview =[NSString base64Decode:self.initwebview];
        NSArray * Protocols =[Dataserialization JSONObjectWithData:initwebview];
        
        if (Protocols.count > 0) {
            
            for (int i = 0 ; i<Protocols.count; i++)
            {
                if (![NSString isBlankString:Protocols[i]] && [Protocols[i] hasPrefix:Protocol_Header])
                {
                    QFLOG(@"对应设置的单个协议---------------------%@",Protocols[i]);
                    [ProtocolClass ProtocolFactroy:Protocols[i] vc:[self.protocolVC.navigationController.viewControllers lastObject]];
                }
            }
        }
    }
}



@end
