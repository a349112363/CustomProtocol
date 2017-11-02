//
//  Control_PickerViewCity.m
//  装修项目管理
//
//  Created by mmxd on 17/2/14.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import "Control_PickerViewCity.h"

@implementation Control_PickerViewCity
@synthesize text;
@synthesize textcolor;
@synthesize fontsize;
@synthesize datasource;
@synthesize menus;
@synthesize rownumber;
@synthesize initialdata;


-(UIView *)CreateControlView
{
    self.pickerViewCity = [[Sub_PickerViewCity alloc]initWithFrame:self.protocolVC.view.bounds vc:self.protocolVC];
    
    return self.pickerViewCity;
}
@end
