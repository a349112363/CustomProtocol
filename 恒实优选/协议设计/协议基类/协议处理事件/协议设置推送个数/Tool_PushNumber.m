//
//  Tool_PushNumber.m
//  装修项目管理
//
//  Created by mmxd on 17/3/17.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import "Tool_PushNumber.h"

@implementation Tool_PushNumber

-(void)run
{
    [super run];
    
    //设置推送小红点个数 并且保存在偏好设置中
    [UIApplication sharedApplication].applicationIconBadgeNumber = self.pushnumber;
    
    [CustomTool_Cache appSetUserDefaults:[NSNumber numberWithInteger:self.pushnumber] andKey:@"applicationIconBadgeNumber"];
}


@end
