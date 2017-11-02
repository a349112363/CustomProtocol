//
//  WebViewController.h
//  恒实珠宝
//
//  Created by 邱凡Bookpro on 2017/8/31.
//  Copyright © 2017年 hszb. All rights reserved.
//

#import "SuperViewController.h"


@interface WebViewController : SuperViewController<UIScrollViewDelegate,UISearchBarDelegate>

//父类属性 子类调用父类属性
@property (nonatomic,strong) UIWebView * webView;//webview
//webvie url 链接
@property (nonatomic,copy) NSString  * webvUrl;

@property (nonatomic,copy) NSString * locatinHtml;

@property (nonatomic,strong) UIView *  sub_Control;



/**
 *  从父类抽出的方法 用来替换jscallback 中需要替换的参数
 *
 *  @param jscallback js回调函数代码
 *  @param Replastr   输入后的参数
 *  @param rangstr    替换参数
 */
- (void)setjscallback:(NSString *)jscallback Replacing:(NSString *)Replastr rangOfString:(NSString *)rangstr;

/**
 *  webview 执行js函数
 *
 *  @param DecodeString js函数
 */
- (void)protocolCallback:(NSString *)DecodeString;
- (void)loadHtml;
- (void)setSupVCCreaterWebview;

@end
