//
//  Tool_ClearCache.m
//  装修项目管理
//
//  Created by mmxd on 17/1/18.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import "Tool_ClearCache.h"

@implementation Tool_ClearCache

-(void)run
{
    [super run];
}
//删除偏好设置中对应的缓存
-(void)setkeyidentification
{
    if ([[self.path stringByReplacingOccurrencesOfString:@"/" withString:@""] isEqualToString:@"SandBox"]) {
        
        [CustomTool_Cache removeObjectForKey:self.keyidentification];
    }
}

@end
