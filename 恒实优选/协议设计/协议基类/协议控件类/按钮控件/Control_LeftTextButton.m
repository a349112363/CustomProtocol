//
//  Control_LeftTextButton.m
//  装修项目管理
//
//  Created by 邱凡Bookpro on 2017/7/8.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import "Control_LeftTextButton.h"

@implementation Control_LeftTextButton

-(void)setButtonFrame
{
    CGFloat btnImageWidth  = 0;
    CGFloat btnImageHeight = 0;
    CGFloat titlewidth = 0;
    CGFloat titleHeight = 0;
    
    if (![NSString isBlankString:self.foreimage]) {
        
        btnImageWidth = self.button.currentImage.size.width;
        btnImageHeight = self.button.currentImage.size.height;
    }
    
    
    if (![NSString isBlankString:self.text]) {
        
        CGSize titlesize = [self.text boundingRectWithSize:CGSizeMake(IPHONE_WIDTH, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:self.fontsize weight:self.fontweight]} context:nil].size;

        titlewidth = titlesize.width;
        
        titleHeight = titlesize.height;
    }
    
    self.button.titleRect = CGRectMake(0, (44 - titleHeight) / 2, titlewidth + 5, titleHeight);
    
    self.button.imageRect = CGRectMake(self.button.titleRect.size.width, (44-btnImageHeight) / 2,btnImageWidth, btnImageHeight);
    
    self.button.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    self.button.frame = CGRectMake(0, 0, self.button.titleRect.size.width + btnImageWidth, 44);
}

@end
