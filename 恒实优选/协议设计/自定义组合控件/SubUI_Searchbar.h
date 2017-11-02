//
//  SubUI_Searchbar.h
//  装修项目管理
//
//  Created by mmxd on 17/1/16.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewController.h"
@interface SubUI_Searchbar : UIView<UISearchBarDelegate>
//设置搜索框
@property (nonatomic,strong) UISearchBar * searchbar;

@property (nonatomic,strong) NSString * jscallback;

//搜索框右侧按钮标题
@property (nonatomic,strong) NSString * btntitle;
//按钮文字颜色
@property (nonatomic,strong) NSString * btntitlecolor;
//按钮文字大小
@property (nonatomic,strong) NSString * btntitlefontsize;

@property (nonatomic,strong) WebViewController * vc;

-(id)initWithFrame:(CGRect)frame vc:(WebViewController *)vc;


-(void)searchCancelBtn;

@end
