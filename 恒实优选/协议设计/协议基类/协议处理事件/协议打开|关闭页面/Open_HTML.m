//
//  Open_HTML.m
//  装修项目管理
//
//  Created by mmxd on 16/12/7.
//  Copyright © 2016年 mmxd. All rights reserved.
//

#import "Open_HTML.h"
#import "CheckDataTool.h"
#import "WebViewController.h"
@implementation Open_HTML

- (void) run
{
    //对自己当前类进行属性赋值 和 方法的实现  initwebview 赋值 
    [super run];
    
    if (![NSString isBlankString:self.path]) {
        
        //取出路径后面被加密的参数 删除路劲前面的/
        NSString * decode =[NSString base64Decode:[self.path substringFromIndex:1]];
        Class class = [[self.protocolVC.navigationController.viewControllers lastObject] class];
        WebViewController * vc = [[class alloc] init];
        vc.webvUrl = decode;
//        //当前控制器是否可以侧滑,父类控制器设置
//        vc.isslide = self.isslide;
//        vc.headbackgroundcolor = self.headbackgroundcolor;
//        vc.istransparent = self.istransparent;
    
        [self.protocolVC.navigationController pushViewController:vc animated:YES];
//        [ProtocolClass ProtocolFactroy:@"gjj://Tool.SetNavgationBar?navgationBarColor=ffffff&isslide=true" vc:vc];
    }
    else
    {
        QFLOG(@"Open_HTML协议路径为空----------------%@",self.path);
    }
    //打开新页面初始化新页面控件
    if (![NSString isBlankString:self.initwebview]) {
        
        NSString * initwebview =[NSString base64Decode:self.initwebview];
        NSArray * Protocols =[Dataserialization JSONObjectWithData:initwebview];
        
        if (Protocols.count > 0) {
            
            for (int i = 0 ; i<Protocols.count; i++)
            {
                if (![NSString isBlankString:Protocols[i]] && [Protocols[i] hasPrefix:Protocol_Header])
                {
                    [ProtocolClass ProtocolFactroy:Protocols[i] vc:[self.protocolVC.navigationController.viewControllers lastObject]];
                }
            }
        }
    }
}



@end
