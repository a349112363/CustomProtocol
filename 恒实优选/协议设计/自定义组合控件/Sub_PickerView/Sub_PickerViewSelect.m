//
//  Sub_PickerViewSelect.m
//  装修项目管理
//
//  Created by mmxd on 17/2/14.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import "Sub_PickerViewSelect.h"

@implementation Sub_PickerViewSelect

-(id)initWithFrame:(CGRect)frame vc:(WebViewController *)vc
{
    self = [super initWithFrame:frame vc:vc];
    
    if (self) {
        
        self.pickerview = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, PickerviewHeight)];
        self.pickerview.backgroundColor =[UIColor setColor:BackColorPickview];
        self.pickerview.dataSource = self;
        self.pickerview.delegate = self;
     
    }
    return self;
}

#pragma mark - PickerView Delegate

// 选择器列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// 每列有多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{

    return self.datasource.count;
}
// 返回每一行的内容
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (![NSString isBlankString:self.datasource[row][@"text"]] ) {
        
        QFLOG(@"%@",self.datasource[row][@"text"]);
        return self.datasource[row][@"text"];

    }
    return nil;

}

// 滑动或点击选择，确认pickerView选中结果
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
   self.selectedParameter = [self.datasource[row] JSONString];
    
}


/**
 *  选择完选择器以后点击工具条上按钮后执行jscallback参数事件
 *
 *  @param jscallback 需要执行的js 或者协议
 */
-(void)setselectedParameter:(NSString *)jscallback
{
    [self.vc setjscallback:jscallback Replacing:self.selectedParameter rangOfString:@"#pickview#"];
}

/**
 *  显示选择器 初始数据设置
 */
-(void)showpickerview
{
    
    if (![NSString isBlankString:self.initialdata]) {
    
        int index = [self.initialdata intValue];
        
        QFLOG(@"%@  %d ",self.datasource[index],index);
        
        if (index <= self.datasource.count) {
            
            if (![NSString isBlankString:self.datasource[index][@"text"]])
            {
                self.selectedParameter = [self.datasource[index] JSONString];
                
                QFLOG(@"%@",self.selectedParameter);
                [self.pickerview selectRow:index inComponent:0 animated:YES];
            }
           
        }
    }
    else
    {
        [self.pickerview selectRow:0 inComponent:0 animated:YES];
        self.selectedParameter =[self.datasource[0] JSONString];

    }

    self.pickerview.frame = PickviewShowframe;
    self.toolbar.frame = CGRectMake(IPHONE_ZERO, self.pickerview.y ,IPHONE_WIDTH, ToolBarHeight);
    
    [UIView animateWithDuration:Duration animations:^{
        
        self.pickerview.frame =PickviewHiddenframe;
        self.toolbar.frame = CGRectMake(IPHONE_ZERO, self.pickerview.y - ToolBarHeight, IPHONE_WIDTH, ToolBarHeight);
        
    }];
        
    [[AppDelegate appdelegate].window addSubview:self.pickerview];
    [[AppDelegate appdelegate].window addSubview:self.toolbar];
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel * Labeltext =[[UILabel alloc]init];
    Labeltext.textAlignment = NSTextAlignmentCenter;
    if(component==0){
        
        if(pickerView==self.pickerview){
            
            [Labeltext sizeToFit];
            Labeltext.font=[UIFont systemFontOfSize:20.0f];
            
            if (self.datasource.count > 0 && ![NSString isBlankString:self.datasource[row][@"text"]]) {
                
                Labeltext.text=self.datasource[row][@"text"];
                QFLOG(@"%@",Labeltext.text);
            }
            
        }
        
    }

    return Labeltext;
    
}

@end
