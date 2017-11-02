//
//  Close_Page.m
//  装修项目管理
//
//  Created by mmxd on 16/12/6.
//  Copyright © 2016年 mmxd. All rights reserved.
//

#import "Close_Page.h"
#import "SuperViewController.h"

@implementation Close_Page

@synthesize jscallback;

//通过传过来的参数
-(void)run
{
    NSMutableArray * viewcontrols =[[NSMutableArray alloc]initWithArray:self.protocolVC.navigationController.viewControllers];
    NSInteger PopvcNum = [[self.path stringByReplacingOccurrencesOfString:@"/" withString:@""] integerValue];
    
    //得到删除后的控制器
    if ( PopvcNum < viewcontrols.count && PopvcNum > 0)
    {
        SuperViewController * popvc = [self.protocolVC.navigationController.viewControllers objectAtIndex:(viewcontrols.count - 1) - PopvcNum];
        
        [self.protocolVC.navigationController popToViewController:popvc animated:YES];
        
        self.protocolVC = popvc;
    }
    else
    {
        if (viewcontrols.count > 1) {
            
            SuperViewController * popvc = [self.protocolVC.navigationController.viewControllers objectAtIndex:1];
            [self.protocolVC.navigationController popToRootViewControllerAnimated:YES];
            self.protocolVC = popvc;
        }
       
    }
    
    //对最后得到的控制器进行run,对自己当前类进行属性赋值 和 方法的实现  jscallback 赋值 实现setjscallback 方法
    [super run];
}



@end
