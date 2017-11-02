//
//  Tool_CallPhone.m
//  装修项目管理
//
//  Created by mmxd on 17/1/12.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import "Tool_CallPhone.h"

@implementation Tool_CallPhone

-(void)run
{
    
    NSString * phonenumber = [self.path stringByReplacingOccurrencesOfString:@"/" withString:@""];

    UIWebView * callwebview = [[UIWebView alloc]init];
    
    NSMutableString * numberStr =[[NSMutableString alloc]initWithFormat:@"tel:%@",phonenumber];
    
    NSURL * url =[NSURL URLWithString:numberStr];
    
    [callwebview loadRequest:[NSURLRequest requestWithURL:url]];
    
    [self.protocolVC.view addSubview:callwebview];
    
}

@end
