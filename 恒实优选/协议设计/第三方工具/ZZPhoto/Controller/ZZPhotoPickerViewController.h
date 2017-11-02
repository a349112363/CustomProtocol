//
//  ZZPhotoPickerViewController.h
//  ZZFramework
//
//  Created by Yuan on 15/7/7.
//  Copyright (c) 2015年 zzl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZResourceConfig.h"


@interface ZZPhotoPickerViewController : UIViewController


@property(strong,nonatomic) void (^PhotoResult)(id responseObject);

@property (assign,nonatomic) NSInteger       selectNum;
@property (assign,nonatomic) BOOL            isAlubSeclect;
@property (strong,nonatomic) PHFetchResult   *fetch;
@property (strong,nonatomic) UIColor         *roundColor;

@property (nonatomic,assign)NSInteger  height;//图片裁剪高度

@property (nonatomic,assign)NSInteger  width;
@end
