//
//  DDQRCodeViewController.h
//  DDQRCode
//
//  Created by meitu on 16/6/10.
//  Copyright © 2016年 lcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperViewController.h"
#import "VCPermissionsEnum.h"

typedef void(^ScanCompleteBlock)(NSString *url);

@interface QRCodeViewController : SuperViewController

@property (nonatomic, copy, readonly) NSString *urlString;

@property (nonatomic,strong) NSString * eventstring;

@property (nonatomic,strong) NSString * jscallback;

@property (nonatomic ,readonly) VCPermissionsenum vcp ;// 当前VC需要的权限

- (void)stopRunning;

@end
