//
//  Control_UpImageButton.m
//  装修项目管理
//
//  Created by 邱凡Bookpro on 2017/7/8.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import "Control_UpImageButton.h"

@implementation Control_UpImageButton

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
    
    titlewidth = 18;
    self.button.titleRect = CGRectMake(2, 44 / 2, titlewidth,titlewidth);
    self.button.titleLabel.layer.cornerRadius = titlewidth / 2;
    self.button.titleLabel.clipsToBounds = YES;
    self.button.titleLabel.font = [UIFont systemFontOfSize:8];
    self.button.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.button.imageRect = CGRectMake(btnImageWidth / 2, (44-btnImageHeight) / 2,btnImageWidth, btnImageHeight);
    self.button.frame = CGRectMake(0, 0, titlewidth + btnImageWidth, 44);
}

@end
