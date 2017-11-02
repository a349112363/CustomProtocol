//
//  Tool_TabBar.m
//  装修项目管理
//
//  Created by mmxd on 17/2/8.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import "Tool_TabBar.h"

@implementation Tool_TabBar


-(void)run
{
    
    [super run];
    /**
     * 设置小红点显示与否
     */
    if (self.status) {
        
        if (![NSString isBlankString:self.number]) {
            
            [self.protocolVC.tabBarController showBadgeOnItemIndexNumber:[self.itemindex intValue] andNumber:self.number];

        }
        else
        {
            [self.protocolVC.tabBarController showBadgeOnItemIndex:[self.itemindex intValue]];
        }
  
    }
    else
    {
        [self.protocolVC.tabBarController hideBadgeOnItemIndex:[self.itemindex intValue]];
    }
}


@end
