//
//  Sub_PickerViewCity.m
//  装修项目管理
//
//  Created by mmxd on 17/2/14.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import "Sub_PickerViewCity.h"

@implementation Sub_PickerViewCity
{
    NSInteger _provinceIndex;   // 省份选择 记录
    NSInteger _cityIndex;       // 市选择 记录
    NSInteger _districtIndex;   // 区选择 记录
    
}
-(id)initWithFrame:(CGRect)frame vc:(WebViewController *)vc
{
    self = [super initWithFrame:frame vc:vc];
    if (self) {
        _provinceIndex = _cityIndex = _districtIndex = 0;

        self.pickerview = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, PickerviewHeight)];
        self.pickerview.backgroundColor =[UIColor setColor:BackColorPickview];
        self.pickerview.dataSource = self;
        self.pickerview.delegate = self;

        //省市区数据
        NSString * path = [[NSBundle mainBundle] pathForResource:@"addressConfig" ofType:@".txt"];
        self.datasource = [Dataserialization JSONObjectWithData:[[NSString alloc ]initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil]];
        
     
    }
    return self;
}

#pragma mark - PickerView Delegate

// 选择器列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

// 每列有多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if(component == 0){
        
        return self.datasource.count;
    }
    else if (component == 1){
        
        return [self.datasource[_provinceIndex][@"children"] count];
    }
    else {
        
        return [self.datasource[_provinceIndex][@"children"][_cityIndex][@"children"] count];
    }
}

// 返回每一行的内容
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if(component == 0){
        
        return self.datasource[row][@"name"];
    }
    else if (component ==1)
    {
        return self.datasource[_provinceIndex][@"children"][row][@"name"];
    }
    else {
        
        return self.datasource[_provinceIndex][@"children"][_cityIndex][@"children"][row][@"name"];
    }
  
}

// 滑动或点击选择，确认pickerView选中结果
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(component == 0){
        _provinceIndex = row;
        _cityIndex = 0;
        _districtIndex = 0;
        
        [self.pickerview reloadComponent:1];
        [self.pickerview reloadComponent:2];
    }
    else if (component == 1){
        _cityIndex = row;
        _districtIndex = 0;
        
        [self.pickerview reloadComponent:2];
    }
    else
    {
        _districtIndex = row;
    }
    
    // 重置当前选中项
    [self resetPickerSelectRow];
    
}
//pickerview 滚动位置
-(void)resetPickerSelectRow
{
    [self.pickerview selectRow:_provinceIndex inComponent:0 animated:YES];
    [self.pickerview selectRow:_cityIndex inComponent:1 animated:YES];
    [self.pickerview selectRow:_districtIndex inComponent:2 animated:YES];
}


/**
 *  选择完选择器以后点击工具条上按钮后执行jscallback参数事件
 *
 *  @param eventstring 需要执行的js 或者协议
 */
-(void)setselectedParameter:(NSString *)jscallback
{
    NSString * province=@"";
    NSString * provinceCode=@"";
    NSString * city=@"";
    NSString * cityCode=@"";
    NSString * district=@"";
    NSString * districtCode=@"";
    if (self.datasource.count > 0) {
       
        province =self.datasource[_provinceIndex][@"name"];
        provinceCode = self.datasource[_provinceIndex][@"code"];
        
        if ([self.datasource[_provinceIndex][@"children"] count] > 0) {
            
            city = self.datasource[_provinceIndex][@"children"][_cityIndex][@"name"];
            cityCode = self.datasource[_provinceIndex][@"children"][_cityIndex][@"code"];
            
            if ([self.datasource[_provinceIndex][@"children"][_cityIndex][@"children"] count] > 0) {
                
                district = self.datasource[_provinceIndex][@"children"][_cityIndex][@"children"][_districtIndex][@"name"];
                districtCode = self.datasource[_provinceIndex][@"children"][_cityIndex][@"children"][_districtIndex][@"code"];
            }
        }
    }
   
    self.selectedParameter = [@{@"provinceName":province,@"provinceCode":provinceCode,@"cityName":city,@"cityCode":cityCode,@"districtName":district,@"districtCode":districtCode} JSONString];
    [self.vc setjscallback:jscallback Replacing:self.selectedParameter rangOfString:@"#pickview#"];
    
}

/**
 *  显示选择器 初始数据设置
 */
-(void)showpickerview
{
    //设置默认省市区为四川成都
    NSString * cityCode = @"51,5101,510104";
    
    //前端如果没传初始数据 则使用默认数据 否则使用前端传的数据
    if ([NSString isBlankString:self.initialdata]) {
        
        self.initialdata = cityCode;
    }

    [self setInitialData];
    
    self.pickerview.frame = PickviewShowframe;
    
    self.toolbar.frame = CGRectMake(IPHONE_ZERO, self.pickerview.y ,IPHONE_WIDTH, ToolBarHeight);
    [UIView animateWithDuration:Duration animations:^{
        
        self.pickerview.frame =PickviewHiddenframe;
        self.toolbar.frame = CGRectMake(IPHONE_ZERO, self.pickerview.y - ToolBarHeight, IPHONE_WIDTH, ToolBarHeight);
        
    }];
    
    [self resetPickerSelectRow];
    [[AppDelegate appdelegate].window addSubview:self.pickerview];
    [[AppDelegate appdelegate].window addSubview:self.toolbar];
}

-(void)setInitialData
{
    NSArray * datas =[self.initialdata componentsSeparatedByString:@","];
    //设置初始默认城市
    for (int i = 0; i< self.datasource.count; i++) {
        
        if ([self.datasource[i][@"code"] isEqualToString:datas[0]]) {
            
            for (int j = 0 ; j < [self.datasource[i][@"children"] count];j++) {
                
                if ([self.datasource[i][@"children"][j][@"code"] isEqualToString:datas[1]]) {
                    
                    for (int k = 0; k < [self.datasource[i][@"children"][j][@"children"] count];k++) {
                        
                        if ([self.datasource[i][@"children"][j][@"children"][k][@"code"] isEqualToString:datas[2]]) {
                            _provinceIndex = i;
                            _cityIndex =j;
                            _districtIndex = k;
                            
                        }
                    }
                }
            }
        }
    }
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel * Labeltext =[[UILabel alloc]init];
    Labeltext.textAlignment = NSTextAlignmentCenter;
    if(component==0){
        
        
        if(pickerView==self.pickerview){
            
            [Labeltext sizeToFit];
            Labeltext.font=[UIFont systemFontOfSize:18.0f];
            Labeltext.text=self.datasource[row][@"name"];
            
        }

    }
    if(component==1){
        
        
        if(pickerView==self.pickerview){
            
            [Labeltext sizeToFit];
            Labeltext.font=[UIFont systemFontOfSize:18.0f];
            Labeltext.text=self.datasource[_provinceIndex][@"children"][row][@"name"];
            
        }
        
    }
    if(component==2){
        
        
        if(pickerView==self.pickerview){
            
            [Labeltext sizeToFit];
            Labeltext.font=[UIFont systemFontOfSize:18.0f];
            Labeltext.text=self.datasource[_provinceIndex][@"children"][_cityIndex][@"children"][row][@"name"];
            
        }
    
    }
    
    return Labeltext;
    
}
@end
