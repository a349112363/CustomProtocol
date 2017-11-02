//
//  Control_PickerViewDate.m
//  装修项目管理
//
//  Created by mmxd on 17/2/14.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import "Control_PickerViewDate.h"

@implementation Control_PickerViewDate
@synthesize text;
@synthesize textcolor;
@synthesize fontsize;
@synthesize datasource;
@synthesize menus;
@synthesize rownumber;
@synthesize initialdata;


-(UIView *)CreateControlView
{
    self.PickerDate = [[Sub_PickerViewDate alloc]initWithFrame:self.protocolVC.view.bounds vc:self.protocolVC];
    
    return self.PickerDate;
}
@end
