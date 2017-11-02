//
//  Control_PickerView.m
//  装修项目管理
//
//  Created by mmxd on 17/1/17.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import "Control_PickerView.h"

@implementation Control_PickerView

-(void)run
{
    self.pickerview =(Sub_UIPickerView *)[self findControl];
    
    [super run];
    QFLOG(@"%@",self.menus);
   //执行拾取器工具条上面数据设置
    [self.pickerview.toolbar setMenueListValue];
    //显示出pickview
    [self.pickerview showpickerview];
    
}

-(void)settext
{
    self.pickerview.toolbar.label.text = self.text;
}

-(void)settextcolor
{
    self.pickerview.toolbar.label.textColor = [UIColor setColor:self.textcolor];
}

-(void)setfontsize
{
    self.pickerview.toolbar.label.font = [UIFont systemFontOfSize:[self.fontsize floatValue]];
}

/**
 *  设置pickview数据源(不包括时间和省市区数据)
 */
-(void)setdatasource
{
    NSString * DecodeStr =[NSString base64Decode:self.datasource];
     self.pickerview.datasource = [Dataserialization JSONObjectWithData:DecodeStr];
    QFLOG(@"%@  %@  %@",self.datasource,DecodeStr,self.pickerview.datasource );

}

/**
  设置pickview 列数
 */
-(void)setrownumber
{
    self.pickerview.rownumber = [self.rownumber intValue];
}
/**
 *  设置序列化参数
 */
-(void)setmenus
{
    NSString * DencodeStr =[NSString base64Decode:self.menus];
    
    if (![NSString isBlankString:DencodeStr]) {
        
        self.pickerview.toolbar.menus = DencodeStr;
    }
}

-(void)setinitialdata
{
    self.pickerview.initialdata = self.initialdata;
}

-(UIView *)CreateControlView
{
    return nil;
}

@end
