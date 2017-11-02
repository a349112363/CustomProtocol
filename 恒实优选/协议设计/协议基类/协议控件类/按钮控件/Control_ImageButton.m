//
//  Control_ImageButton.m
//  装修项目管理
//
//  Created by 邱凡Bookpro on 2017/7/8.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import "Control_ImageButton.h"

@implementation Control_ImageButton


-(void)setButtonFrame
{
    
    CGFloat btnImageWidth  = 0;
    CGFloat btnImageHeight = 0;
    
    if (![NSString isBlankString:self.foreimage]) {
        
        btnImageWidth  = self.button.currentImage.size.width;
        btnImageHeight = self.button.currentImage.size.height;
    }
    //+10 是为了给多个按钮之间留有间隙
    self.button.frame = CGRectMake(0, 0,btnImageWidth + 10, 44);
    
    if ([self.ProtocolPosition isEqualToString:@"headleft"])
    {
        //上左下右
        self.button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0,self.button.width - btnImageWidth);
    }
    if ([self.ProtocolPosition isEqualToString:@"headright"])
    {
        self.button.imageEdgeInsets = UIEdgeInsetsMake(0,self.button.width - btnImageWidth, 0,0);
        
    }
    else
    {
        self.button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0,0);
    }
}

@end
