//
//  Control_PickerViewOther.m
//  装修项目管理
//
//  Created by mmxd on 17/2/14.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import "Control_PickerViewSelect.h"

@implementation Control_PickerViewSelect

@synthesize text;
@synthesize textcolor;
@synthesize fontsize;
@synthesize datasource;
@synthesize menus;
@synthesize rownumber;
@synthesize initialdata;

-(UIView *)CreateControlView
{
    self.pickerviewSelect =[[Sub_PickerViewSelect alloc]initWithFrame:self.protocolVC.view.bounds vc:(WebViewController *)self.protocolVC];
    
    return self.pickerviewSelect;
}

@end
