//
//  UILabel+UILabelExtension.h
//  装修项目管理
//
//  Created by mmxd on 17/1/13.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCPermissionsEnum.h"

@interface UILabel (UILabelExtension)

+(UILabel *)setLabelTitle:(NSString *)title
                  setFont:(CGFloat)font
                 setframe:(CGRect)frame
              setposition:(ControlPositionEnum)position
                setweight:(CGFloat)weight
         setnumberOfLines:(int)numberOfLines
            settitlecolor:(NSString *)titlecolor;

@end
