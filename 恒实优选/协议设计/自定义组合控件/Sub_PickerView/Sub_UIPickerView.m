//
//  Sub_UIPickerView.m
//  PickerView
//
//  Created by mmxd on 17/1/18.
//  Copyright © 2017年 WTC. All rights reserved.
//


#import "Sub_UIPickerView.h"

@implementation Sub_PickerViewModel


-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

-(id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}

@end


@implementation Sub_UIPickerView

-(id)initWithFrame:(CGRect)frame vc:(WebViewController *)vc
{
    self =[super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.vc = vc;
        self.pickerview.delegate = self;

    }
    
    return self;
}

/**
 *  懒加载选择器上的工具条
 *
 *  @return 返回工具条
 */
-(Sub_PickerViewToolBar *)toolbar
{
    if (_toolbar == nil) {
        
        _toolbar = [[Sub_PickerViewToolBar alloc]initWithToolbarcancelAction:^{
            
            //点击工具条上取消按钮执行的block
            [self hideenpickerview];
            Sub_ToolBarBtnModel * btnmodel =_toolbar.datamenus[1];
            [self setselectedParameter:btnmodel.jsCallBack];
            
        } doneAction:^{
            
            //点击工具条上确定按钮执行的block
            [self hideenpickerview];
            
            Sub_ToolBarBtnModel * btnmodel =_toolbar.datamenus[0];
            [self setselectedParameter:btnmodel.jsCallBack];
            
        }];
        
    }
    return _toolbar;
}

/**
 *  选择完选择器以后点击工具条上按钮后执行jscallback参数事件
 *
 *  @param jscallback 需要执行的js 或者协议
 */
-(void)setselectedParameter:(NSString *)jscallback
{
    
}


/**
 *  显示选择器 子类重写该方法 设置初始数据
 */
-(void)showpickerview
{

}
/**
 *  隐藏当前选择器
 */
-(void)hideenpickerview
{
    self.pickerview.frame = PickviewHiddenframe;
    
    self.toolbar.frame = CGRectMake(IPHONE_ZERO, self.pickerview.y - ToolBarHeight ,IPHONE_WIDTH, ToolBarHeight);
    
    [UIView animateWithDuration:Duration animations:^{
        
        self.pickerview.frame =PickviewShowframe;
        
        self.toolbar.frame = CGRectMake(IPHONE_ZERO, self.pickerview.y, IPHONE_WIDTH, ToolBarHeight);
        
        self.alpha = 0;
        
    }completion:^(BOOL finished) {
        
        [self removeFromSuperview];

    }];
    
}

/**
 *  点击工具条上的按钮执行替换
 *
 *  @param jscallback 回调js
 *  @param Replastr   替换JS特定参数
 */
//-(void)setjscallback:(NSString *)jscallback Replacing:(NSString *)Replastr
//{
//    QFLOG(@"%@  %@",Replastr,jscallback);
//    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        
//        if ([jscallback rangeOfString:@"#pickview#"].location != NSNotFound) {
//            
//            NSString * parame = [jscallback stringByReplacingOccurrencesOfString:@"#pickview#" withString:Replastr];
//            
//            QFLOG(@"回调的参数-----------%@",parame);
//            
//            [self.vc protocolCallback:parame];
//        }
//
//        
//    });
//    
//}



//点击关闭页面
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self hideenpickerview];
}
@end
