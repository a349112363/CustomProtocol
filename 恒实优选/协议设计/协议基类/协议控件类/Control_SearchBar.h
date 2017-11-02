//
//  Control_SearchBar.h
//  装修项目管理
//
//  Created by mmxd on 17/1/16.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import "ProtocolClass.h"
#import "SubUI_Searchbar.h"
@interface Control_SearchBar : ProtocolClass

@property (nonatomic,strong) SubUI_Searchbar * subsearchbar;
//搜索框默认文字
@property (nonatomic,strong) NSString * placeholder;
//需要搜索的文字
@property (nonatomic,strong) NSString * searchtext;
//搜索内容文字颜色
@property (nonatomic,strong) NSString * searchtextcolor;
//搜索内容文字大小
@property (nonatomic,strong) NSString * searchtextfontsize;
//默认文字颜色
@property (nonatomic,strong) NSString * placeholdercolor;
//默认文字字体大小
@property (nonatomic,strong) NSString * placeholderfontsize;
//搜索框右侧按钮标题
@property (nonatomic,strong) NSString * btntitle;
//按钮文字颜色
@property (nonatomic,strong) NSString * btntitlecolor;
//按钮文字大小
@property (nonatomic,strong) NSString * btntitlefontsize;

@property (nonatomic,strong) NSString * jscallback;

@end
