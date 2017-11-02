//
//  Tool_SetNavgationBar.m
//  恒实珠宝
//
//  Created by 邱凡Bookpro on 2017/9/4.
//  Copyright © 2017年 hszb. All rights reserved.
//

#import "Tool_SetNavgationBar.h"
@implementation Tool_SetNavgationBar

-(void)run
{
    [super run];
    
    [self setViewFrameAndNavgationBar];
    
    
    if (![NSString isBlankString:self.navgationbarcolor]) {
        
        [self.protocolVC.navigationController.navigationBar setBarTintColor:[UIColor setColor:self.navgationbarcolor]];
    }
    
    
    if (self.isslide) {
        
        [self createrPanGesture];
        
    }
}


/**
 *  设置当前view的坐标 因为头部会隐藏 高度不确定
 设置导航条头部透明度 和 背景颜色
 */
-(void)setViewFrameAndNavgationBar
{
    
    UIView * navgationBackview = [self getNavgationBackgroundView];
    
    if (self.istransparent) {
        
        if (navgationBackview) {
            
            
            for (id view in self.protocolVC.view.subviews) {
                
                if ([view isKindOfClass:[UIWebView class]]) {
                    
                    UIWebView * webview =(UIWebView *)view;
                    
                    //导航条透明的情况，页面需要上移64
                    if (self.protocolVC.navigationController.viewControllers.count == 1) {
                        
                        webview.frame = CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT-49);
                        
                    }
                    else
                    {
                        webview.frame = CGRectMake(0, -64, IPHONE_WIDTH, IPHONE_HEIGHT);
                        
                    }
                    
                    webview.scrollView.delegate = self.protocolVC.navigationController.viewControllers.lastObject;
                    
                }
            }
        }
        
        navgationBackview.alpha = 0;
        
    }
    else
    {
        navgationBackview.alpha = 1;
        
    }
    
}



#pragma mark - 返回当前导航控制器背景view
-(UIView *)getNavgationBackgroundView
{
    
    for (UIView *view in self.protocolVC.navigationController.navigationBar.subviews) {
        //_UINavigationBarBackground 模拟器存在真机不存在   _UIBarBackground 真机存在模拟器不存在  适应两者
        if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")] || [view isKindOfClass:NSClassFromString(@"_UIBarBackground")])
        {
            return view;
        }
    }
    
    
    return nil;
}


#pragma -mark 创建滑动返回
-(void)createrPanGesture
{
    self.protocolVC.navigationController.interactivePopGestureRecognizer.enabled = NO;
    id target = self.protocolVC.navigationController.interactivePopGestureRecognizer.delegate;
    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    // 设置手势代理，拦截手势触发
    pan.delegate = self.protocolVC;
    // 给导航控制器的view添加全屏滑动手势
    [self.protocolVC.view addGestureRecognizer:pan];
}
-(void)handleNavigationTransition:(UIPanGestureRecognizer *)pan
{
    
}

// 什么时候调用：每次触发手势之前都会询问下代理，是否触发。
// 作用：拦截手势触发
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 注意：只有非根控制器才有滑动返回功能，根控制器没有。
    // 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
    if (self.protocolVC.navigationController.viewControllers.count == 1) {
        // 表示用户在根控制器界面，就不需要触发滑动手势，
        return NO;
    }
    return self.isslide;
}





@end
