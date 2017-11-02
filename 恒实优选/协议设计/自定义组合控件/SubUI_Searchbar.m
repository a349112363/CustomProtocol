//
//  SubUI_Searchbar.m
//  装修项目管理
//
//  Created by mmxd on 17/1/16.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import "SubUI_Searchbar.h"

@implementation SubUI_Searchbar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame vc:(WebViewController *)vc

{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.searchbar =[[UISearchBar alloc]init];
        self.vc = vc;

        
        //防止页面跳转的时候，出现searchbar 闪烁的情况
        float version = [[[UIDevice currentDevice] systemVersion] floatValue];
        if ([self.searchbar respondsToSelector : @selector (barTintColor)]) {
            float  iosversion7_1 = 7.1 ;
            if (version >= iosversion7_1)
            {
                //iOS7.1
                
                [[[[self.searchbar.subviews objectAtIndex:0] subviews] objectAtIndex:0] removeFromSuperview];
                [self.searchbar setBackgroundColor:[UIColor clearColor]];
            }
            else
            {
                //iOS7.0
                [self.searchbar setBarTintColor:[UIColor clearColor]];
                [self.searchbar setBackgroundColor:[UIColor clearColor]];
            }
        }
        else
        {
            //iOS7.0 以下
            
            [[self.searchbar.subviews objectAtIndex:0] removeFromSuperview ];
            [self.searchbar setBackgroundColor :[ UIColor clearColor]];
        }


    }
    
    self.searchbar.delegate = self;
    self.vc.sub_Control = self;
    return self;
}

/****自定义搜索框右侧取消按钮****/
-(void)searchCancelBtn
{
    UIButton * right = [UIButton buttonWithType:UIButtonTypeCustom];
    
    right.frame = CGRectMake(0, 0, 40, 44);
    
    if ([self.btntitlefontsize floatValue] > 0) {
        
        right.titleLabel.font = [UIFont systemFontOfSize:[self.btntitlefontsize floatValue]];
        
    }
    
    [right setTitle:self.btntitle forState:UIControlStateNormal];
    
    [right setTitleColor:[UIColor setColor:self.btntitlecolor] forState:UIControlStateNormal];
    
    [right addTarget:self action:@selector(rightclickSearch) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * cancel =[[UIBarButtonItem alloc]initWithCustomView:right];
    
    self.vc.navigationItem.rightBarButtonItem = cancel;
    
}
/****右侧取消按钮功能****/
-(void)rightclickSearch
{
    QFLOG(@"%@",self.searchbar.text);
    
    [self.vc setjscallback:[NSString base64Decode:self.jscallback] Replacing:self.searchbar.text rangOfString:@"#searchtext#"];

    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}


-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    QFLOG(@"开始输入");
    return YES;
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    QFLOG(@"结束编辑");
    return YES;
}

/**
 *  搜索框代理事件 每次输入或者删除都会触发该方法
 *
 */
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self.vc setjscallback:[NSString base64Decode:self.jscallback] Replacing:searchText rangOfString:@"#searchtext#"];
    QFLOG(@"%@  %@",[NSString base64Decode:self.jscallback],searchText);
    
}


/**
 *  点击键盘上搜索按钮代理事件
 *
 *  @param searchBar 当前搜索框
 */
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    QFLOG(@"%@",searchBar.text);
    
    [self.vc setjscallback:[NSString base64Decode:self.jscallback] Replacing:searchBar.text rangOfString:@"#searchtext#"];
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
  

}





@end
