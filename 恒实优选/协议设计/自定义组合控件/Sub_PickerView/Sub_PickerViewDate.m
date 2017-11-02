//
//  Sub_PickerViewDate.m
//  装修项目管理
//
//  Created by mmxd on 17/2/14.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import "Sub_PickerViewDate.h"


@implementation Sub_PickerViewDate


-(id)initWithFrame:(CGRect)frame vc:(WebViewController *)vc
{
    self = [super initWithFrame:frame vc:vc];
    
    if (self) {
        
        UIDatePicker *picker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, PickerviewHeight)];
        picker.backgroundColor =[UIColor setColor:BackColorPickview];
        [picker addTarget:self action:@selector(datePickerDidSelected:) forControlEvents:UIControlEventValueChanged];
        picker.datePickerMode = UIDatePickerModeDate;
        picker.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
        self.pickerviewDate = picker;
    }
    return self;
}

/**
 *  显示时间选择器 重写父类方法
 */
-(void)showpickerview
{
    //pickerviewdata 显示动画
    self.pickerviewDate.frame = PickviewShowframe;
    self.toolbar.frame = CGRectMake(IPHONE_ZERO, self.pickerviewDate.y ,IPHONE_WIDTH, ToolBarHeight);
    [UIView animateWithDuration:Duration animations:^{
            
        self.pickerviewDate.frame =PickviewHiddenframe;
        self.toolbar.frame = CGRectMake(IPHONE_ZERO, self.pickerviewDate.y - ToolBarHeight, IPHONE_WIDTH, ToolBarHeight);
            
    }];
    
    //设置初始默认时间
    if (![NSString isBlankString:self.initialdata]) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];//设定时间格式,这里可以设置成自己需要的格式
        self.pickerviewDate.date =[formatter dateFromString:self.initialdata];
        self.selectedParameter = [self returnselectedDate:self.pickerviewDate.date];
    }
    else
    {
        self.selectedParameter = [self returnselectedDate:[NSDate date]];
    }
    
    [[AppDelegate appdelegate].window addSubview:self.pickerviewDate];
    [[AppDelegate appdelegate].window addSubview:self.toolbar];
}
/**
 *  隐藏时间选择器 重写父类方法
 */
-(void)hideenpickerview
{
    self.pickerviewDate.frame = PickviewHiddenframe;
    self.toolbar.frame = CGRectMake(IPHONE_ZERO, self.pickerviewDate.y - ToolBarHeight ,IPHONE_WIDTH, ToolBarHeight);
    [UIView animateWithDuration:Duration animations:^{

        self.pickerviewDate.frame =PickviewShowframe;
        self.toolbar.frame = CGRectMake(IPHONE_ZERO, self.pickerviewDate.y, IPHONE_WIDTH, ToolBarHeight);
        self.alpha = 0;
        
    }completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
}


/**
 *  时间选择器选择完成后回调事件
 *
 *  @param datepickview 当前的时间选择器
 */
-(void)datePickerDidSelected:(UIDatePicker *)datepickview
{
    self.selectedParameter = [self returnselectedDate:[[NSDate date] getNowDateFromatAnDate:datepickview.date]];
}

/**
 *  将选择的时间转换格式传给前端
 *
 *  @param currentdate 当前选择的时间
 *
 *  @return 返回转换后的数据
 */
-(NSString *)returnselectedDate:(NSDate *)currentdate
{
    
    NSDateComponents * comps =[[NSDate date] ComponentsdateFrom:currentdate];
    
    NSInteger weekday = [[NSDate date] getNowWeekday:currentdate];
    
    NSString * jsonstr = [@{@"year":[NSString stringWithFormat:@"%ld",comps.year],@"month":[NSString stringWithFormat:@"%ld",comps.month],@"day":[NSString stringWithFormat:@"%ld",comps.day],@"weekday":[NSString stringWithFormat:@"%ld",weekday]} JSONString];
    
    return jsonstr;
}
/**
 *  重写父类方法
 *
 *  @param jscallback js回调函数
 */
-(void)setselectedParameter:(NSString *)jscallback
{

    [self.vc setjscallback:jscallback Replacing:self.selectedParameter rangOfString:@"#pickview#"];

}
//关闭当前时间选择
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self hideenpickerview];
}

@end
