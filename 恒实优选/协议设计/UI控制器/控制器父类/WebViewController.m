//
//  WebViewController.m
//  恒实珠宝
//
//  Created by 邱凡Bookpro on 2017/8/31.
//  Copyright © 2017年 hszb. All rights reserved.
//

#import "WebViewController.h"
#import "ProtocolClass.h"

#import "QFNavigationController.h"
#import "NativeViewController.h"
#import "Control__Button.h"
#import "SubUI_DropdownList.h"
#import "SubUI_Searchbar.h"
@interface WebViewController ()<UIWebViewDelegate,UITabBarControllerDelegate>


@end

@implementation WebViewController
{
    MBProgressHUD * _HUD;//加载进度
    BOOL isfinish;//判断webview是否加载完毕
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    //手动控制view 高度 从0 0 开始 （导航条 和 tableBar 不透明）
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    //初始化创建webview
    if (self.navigationController.viewControllers.count == 1) {
        
        self.view.frame = CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT - 49);
    }
    else
    {
        self.view.frame = CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT);
    }
    
    [self setSupVCCreaterWebview];
    self.tabBarController.delegate   = self;

//    UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame =CGRectMake(100, 100, 100, 100);
//    btn.backgroundColor =[UIColor redColor];
//    [btn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];

}

//-(void)share
//{
//    [ProtocolClass ProtocolFactroy:@"gjj://Control.Share/Create/BodyBottom/430" vc:self];
//}

/**
 搜索框的setter方法

 当创建完成控件后，控件类会被销毁，找不到对应对象，也就执行不了相应的代理方法。
 在这将对象保存。
 @param sub_Control 用来保存控件对象
 */
-(void)setSub_Control:(UIView *)sub_Control
{
    _sub_Control = (SubUI_Searchbar *)sub_Control;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  点击pickview工具条上的按钮将内容替换
 *
 *  @param jscallback 回调js
 *  @param Replastr   替换JS特定参数
 */
-(void)setjscallback:(NSString *)jscallback Replacing:(NSString *)Replastr rangOfString:(NSString *)rangstr
{
    QFLOG(@"%@  %@",Replastr,jscallback);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if ([jscallback rangeOfString:rangstr].location != NSNotFound) {
            
            NSString * parame = [jscallback stringByReplacingOccurrencesOfString:rangstr withString:Replastr];
            
            QFLOG(@"回调的参数-----------%@",parame);
            
            [self protocolCallback:parame];
        }
    });
    
}

/**
 *  需要在webview上面执行的JS 事件 写在父类 子类需要可以直接调用该方法 无需重复写
 *
 *  @param DecodeString 需要执行事件的代码或者协议
 */
-(void)protocolCallback:(NSString *)DecodeString
{
    
    if (![NSString isBlankString:DecodeString])
    {
        if (![DecodeString hasPrefix:Protocol_Header])
        {
            
            if (self.webView)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.webView stringByEvaluatingJavaScriptFromString:DecodeString];
                    
                });
            }
            else
            {
                QFLOG(@"执行button事件调用JS出错 -------------------------%@",DecodeString);
            }
        }
        else
        {
            
            [ProtocolClass ProtocolFactroy:DecodeString vc:self];
        }
    }
    else
    {
        QFLOG(@"-------------------------DecodeString为空");
        
    }
}



-(void)setSupVCCreaterWebview
{
    self.webView = [[UIWebView alloc]init];
    self.webView.delegate = self;
    self.webView.scrollView.bounces = NO;
    //禁止自动识别邮箱电话。。。。
    self.webView.dataDetectorTypes = UIDataDetectorTypeNone;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    self.webView.scrollView.showsVerticalScrollIndicator   = NO;
    [self.view addSubview:self.webView];
    
    _HUD  = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    _webView.frame = self.view.frame;
    

    [self loadHtml];
    
}


/**
 webvUrl setter 方法

 @param webvUrl url地址
 */
-(void)setWebvUrl:(NSString *)webvUrl
{
    NSString * path;
    
    if (![NSString isBlankString:webvUrl]) {
        
        if ([webvUrl rangeOfString:@"?"].location == NSNotFound) {
            
            path = [NSString stringWithFormat:@"%@?telcode=%@",webvUrl,UUID_Value];
        }
        else
        {
            path = [NSString stringWithFormat:@"%@&telcode=%@",webvUrl,UUID_Value];
            
        }
        
        //判断url头
        if ([webvUrl hasPrefix:@"http://"] || [webvUrl hasPrefix:@"https://"])
        {
            _webvUrl = [NSString stringWithFormat:@"%@",webvUrl];
        }
        else
        {
            _webvUrl =[NSString stringWithFormat:@"%@%@",PrefixId,webvUrl];
        }
    }
}

/**
 *  通过Url加载web页面
 *
 */
- (void)loadHtml
{
    if (_webvUrl )
    {
        
        //加载html 忽略缓存 需要对中文转码
//        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[_webvUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:0.5]];
        
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_webvUrl]]];
        
    }
    else
    {
        
        QFLOG(@"-----------------webview 加载链接cutwebUrl为空");
    }
}


-(void)loadNativeHTML:(NSString *)nativeUrl
{
    //    if (![NSString isBlankString:nativeUrl]) {
    //
    //        NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    //
    //        NSString * str =[NSString stringWithContentsOfFile:nativeUrl encoding:NSUTF8StringEncoding error:nil];
    //        //    NSLog(@"%@",str);
    //        [self.webView loadHTMLString:str baseURL:baseURL];
    //    }
}

#pragma mark -WebViewDelegate
/**
 *  拦截webview请求
 *
 *  @param webView        当前webview
 *  @param request        webview请求链接
 *  @param navigationType navigationType description
 *
 *  @return 拦截后处理状态 yes 不处理直接加载页面 NO 处理拦截后的链接
 */
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString * requestUrlStr =[request.URL absoluteString];
    QFLOG(@"拦截到的链接-----------------------%@",requestUrlStr);
    if (![NSString isBlankString:requestUrlStr] && [requestUrlStr hasPrefix:Protocol_Header])
    {
        [ProtocolClass ProtocolFactroy:requestUrlStr vc:self];
        
        return NO;
    }
    
    //执行完所有控件协议后 清空数组 防止重复添加
    [self.ControlLeftitems removeAllObjects];
    [self.ControlRightitems removeAllObjects];
    
    return YES;
}
/**
 *  页面加载失败的时候点击重新加载
 */
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    if ([_HUD.labelText isEqualToString:@"网络超时,点击重新连接..."] && ![NSString isBlankString:_webvUrl]) {
        [self loadHtml];
    }
    else if ([_HUD.labelText isEqualToString:@"网络超时,点击重新连接..."] && ![NSString isBlankString:_locatinHtml]){
        
        [self loadNativeHTML:_locatinHtml];
    }
}
//开始加载
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    
    isfinish = NO;
    [_HUD show:YES];
    _HUD.labelText= @"正在加载...";
}
//加载完成
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    _HUD.labelText= @"加载完成...";
    isfinish = YES;
    [_HUD hide:YES];
    
    //禁止长按出现copy
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    // Disable callout
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    
    
    
}
//加载错误
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [_HUD show:YES];
    isfinish = NO;
    _HUD.labelText = @"网络超时,点击重新连接...";
}
/**
 *  协议创建控件时的事件
 *
 *  @param obj 执行事件对象 根据控件类名，反射对应委托方法
 */
-(void)SelectProtocolEvent:(UIView *)obj
{
    //反射出类名  event+classname(类名)+action 拼接出相应的事件方法
    NSString * vcmethod =[NSString stringWithFormat:@"event%@action:",NSStringFromClass([obj class])];
    //获取相应事件方法名
    SEL selector = NSSelectorFromString(vcmethod);
    
    QFLOG(@"控件在控制器中通过选择器反射------------%d %@ %@",[self respondsToSelector:selector],vcmethod,obj);
    
    if ([self respondsToSelector:selector]) {
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        //执行事件 并且传递实现事件控件对象
        [self performSelector:selector withObject:obj];
    }
    else{
        QFLOG(@"执行事件委托错误-------------------%@",vcmethod);
    }
}

/**
 *  点击下拉菜单DropDown按钮事件
 *
 *  @param obj DropDownBtn 按钮实例对象
 */
-(void)eventDropDownBtnaction:(DropDownBtn *)obj
{
    obj.isSelected =!obj.isSelected;
    if (obj.isSelected) {
        
        [(SubUI_DropdownList *)obj.subuidropdownlistid showSubDropDownList];
    }
    else
    {
        [(SubUI_DropdownList *)obj.subuidropdownlistid hiddenSubDropDownList];
    }
}

/**
 *  协议创建控件时的事件
 *
 *  @param obj ProtocolButton对象
 */
-(void)eventProtocolButtonaction:(ProtocolButton *)obj
{
    NSString * DecodeString = obj.eventstring;
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    QFLOG(@"%@---------",DecodeString);
    [self protocolCallback:DecodeString];
    
    if (isfinish == NO) {
        
        //判断当前返回按钮是带有事件的 closepage() 当页面没加载完成的时候 执行不了js 事件 所以做好判断 当页面没加载完 或出错的情况下 点击按钮直接返回 不执行js
        if ([DecodeString isEqualToString:@"closePage()"]) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }
    }
}

//tabbarController 点击item 通知前端 点击了第几个
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    
//    QFNavigationController * nav =(QFNavigationController *)self.tabBarController.selectedViewController;
//    //找到当前控制器 执行协议
//    WebViewController * currentVC = nav.viewControllers.lastObject;
//        [currentVC.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"clickBottomItem(%ld)",tabBarController.selectedIndex]];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    UIView * navgationView = [self getNavgationBackgroundView];
    
    if (scrollView.contentOffset.y < 200) {
        
        if (navgationView) {
            
            navgationView.alpha = scrollView.contentOffset.y / 200;
        }
    }
    else
    {
        if (navgationView) {
            
            navgationView.alpha =1;
        }
    }
}


#pragma mark - 返回当前导航控制器背景view
-(UIView *)getNavgationBackgroundView
{
    for (UIView *view in self.navigationController.navigationBar.subviews) {
        //_UINavigationBarBackground 模拟器存在真机不存在   _UIBarBackground 真机存在模拟器不存在  适应两者
        if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")] || [view isKindOfClass:NSClassFromString(@"_UIBarBackground")])
        {
            return view;
        }
    }
    return nil;
    
 
}







@end
