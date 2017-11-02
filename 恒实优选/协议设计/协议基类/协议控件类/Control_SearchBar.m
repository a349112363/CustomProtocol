//
//  Control_SearchBar.m
//  装修项目管理
//
//  Created by mmxd on 17/1/16.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import "Control_SearchBar.h"

@implementation Control_SearchBar
{
    UITextField *searchField;
}

@synthesize jscallback;
-(void)run
{
    self.subsearchbar.searchbar=(UISearchBar *)[super findControl];
    
    searchField = [self.subsearchbar.searchbar valueForKey:@"_searchField"];

    [super run];
    
    [self.subsearchbar searchCancelBtn];
}
//设置默认文字
-(void)setplaceholder
{
    self.subsearchbar.searchbar.placeholder = self.placeholder;
}
//设置输入文字
-(void)setsearchtext
{
    self.subsearchbar.searchbar.text = self.searchtext;
}
// 输入文本颜色
-(void)setsearchtextcolor
{
    searchField.textColor = [UIColor setColor:self.searchtextcolor];
}
//设置输入文字字体大小
-(void)setsearchtextfontsize
{
    searchField.font = [UIFont systemFontOfSize:[self.searchtextfontsize floatValue]];
}

// 默认文本颜色
-(void)setplaceholdercolor
{
    [searchField setValue:[UIColor setColor:self.placeholdercolor] forKeyPath:@"_placeholderLabel.textColor"];
}
// 默认文本字体大小
-(void)setpplaceholderfontsize
{
    [searchField setValue:[UIFont systemFontOfSize:[self.placeholderfontsize floatValue]] forKeyPath:@"_placeholderLabel.font"];
}
//给前端传递的参数
-(void)setjscallback
{
    self.subsearchbar.jscallback = self.jscallback;
}

-(void)setbtntitle
{
    
    self.subsearchbar.btntitle = self.btntitle;
}

-(void)setbtntitlecolor
{
    self.subsearchbar.btntitlecolor = self.btntitlecolor;

}

-(void)setbtntitlefontsize
{
    self.subsearchbar.btntitlefontsize = self.btntitlefontsize;

}

-(UIView *)CreateControlView
{
    
    self.subsearchbar =[[SubUI_Searchbar alloc]initWithFrame:CGRectZero vc:self.protocolVC];
//    self.subsearchbar =[[SubUI_Searchbar alloc]initWithFrame:CGRectZero];
//    self.subsearchbar.searchbar.delegate = self.protocolVC;
//    ((WebViewController *)self.protocolVC).sub_Control = self.subsearchbar;
    
   // QFLOG(@"%@",self.subsearchbar);

    return self.subsearchbar.searchbar;
}



@end
