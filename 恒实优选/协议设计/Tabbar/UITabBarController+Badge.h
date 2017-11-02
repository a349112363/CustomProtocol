//
//  UITabBarController+Badge.h
//  装修项目管理
//
//  Created by mmxd on 17/2/7.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarController (Badge)

- (void)showBadgeOnItemIndex:(int)index;

- (void)hideBadgeOnItemIndex:(int)index;

- (void)showBadgeOnItemIndexNumber:(int)index andNumber:(NSString *)number;
@end
