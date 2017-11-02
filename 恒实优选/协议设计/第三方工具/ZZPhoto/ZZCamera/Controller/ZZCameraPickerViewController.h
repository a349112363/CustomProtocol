//
//  ZZCameraPickerViewController.h
//  ZZFramework
//
//  Created by Yuan on 15/12/18.
//  Copyright © 2015年 zzl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZResourceConfig.h"

@interface ZZCameraPickerViewController : UIViewController

@property (assign, nonatomic) BOOL isSavelocal;

@property (assign, nonatomic) NSInteger takePhotoOfMax;

@property (strong, nonatomic) UIColor *themeColor;

@property (strong, nonatomic) void (^CameraResult)(id responseObject);

@property (nonatomic,assign)NSInteger  height;//图片裁剪高度

@property (nonatomic,assign)NSInteger  width;

@property (nonatomic,assign)BOOL  iswatermark;

@end
