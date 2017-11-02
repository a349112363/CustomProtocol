//
//  UITabBarController+Badge.m
//  装修项目管理
//
//  Created by mmxd on 17/2/7.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import "UITabBarController+Badge.h"

@implementation UITabBarController (Badge)

- (void)showBadgeOnItemIndex:(int)index{
    
    [self removeBadgeOnItemIndex:index];
    
    UIView *badgeView = [[UIView alloc]init];
    
    badgeView.tag =888 + index;
    
    badgeView.layer.cornerRadius =5;
    
    badgeView.backgroundColor = [UIColor redColor];
    
    CGRect tabFrame = self.tabBar.frame;
    //显示在对应的item上小红点
    //UIViewController * vc = self.viewControllers[index];
    
    float percentX = (index +0.58) /[self.viewControllers count];
    
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    
    CGFloat y = ceilf(0.12 * tabFrame.size.height);
    
    badgeView.frame =CGRectMake(x, y, 10,10);

    
    [self.tabBar addSubview:badgeView];
    
}

- (void)showBadgeOnItemIndexNumber:(int)index andNumber:(NSString *)number{
    
    [self removeBadgeOnItemIndex:index];

    CGFloat numberSize = 16;
    
    UILabel *NumberLabel = [[UILabel alloc]init];
    
    NumberLabel.text = number;
    
    NumberLabel.textColor = [UIColor whiteColor];
    
    NumberLabel.font = [UIFont systemFontOfSize:10];
    
    NumberLabel.textAlignment = NSTextAlignmentCenter;

    NumberLabel.tag =888 + index;
    
    NumberLabel.backgroundColor = [UIColor redColor];
    
    CGRect tabFrame = self.tabBar.frame;
    
    float percentX = (index +0.58) /[self.viewControllers count];
    
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    
    NumberLabel.layer.cornerRadius = numberSize / 2;
    NumberLabel.clipsToBounds = YES;

    CGFloat Lablewidth = [NumberLabel.text boundingRectWithSize:CGSizeMake(self.tabBar.width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:NumberLabel.font} context:nil].size.width;
    
    numberSize = numberSize < Lablewidth ? Lablewidth + 5 : numberSize;
    
    NumberLabel.frame =CGRectMake(x, y, numberSize,16);
    
    [self.tabBar addSubview:NumberLabel];
}

- (void)hideBadgeOnItemIndex:(int)index{
    
    [self removeBadgeOnItemIndex:index];
    
}

- (void)removeBadgeOnItemIndex:(int)index{
    
    for (UIView *subView in self.tabBar.subviews) {
        
        if (subView.tag ==888+index) {
            
            [subView removeFromSuperview];
            
        }
    }
}
@end
