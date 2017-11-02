//
//  Control_TextButton.m
//  装修项目管理
//
//  Created by 邱凡Bookpro on 2017/7/8.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import "Control_TextButton.h"

@implementation Control_TextButton


-(void)setButtonFrame
{
    CGFloat titlewidth = 0;
    
    if (![NSString isBlankString:self.text]) {
        
        CGSize titlesize = [self.text boundingRectWithSize:CGSizeMake(IPHONE_WIDTH, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:self.fontsize weight:self.fontweight]} context:nil].size;
 
        titlewidth  = titlesize.width;
    }
    
    self.button.frame = CGRectMake(0, 0, titlewidth * 4 / 3, 44);
    
    if ([self.ProtocolPosition isEqualToString:@"headleft"])
    {
        self.button.titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    else if ([self.ProtocolPosition isEqualToString:@"headright"])
    {
        self.button.titleLabel.textAlignment = NSTextAlignmentRight;
    }
    else
    {
        self.button.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
}

@end
