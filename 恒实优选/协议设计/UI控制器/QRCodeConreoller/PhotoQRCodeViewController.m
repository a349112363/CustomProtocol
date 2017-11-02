//
//  DDPhotoQRCodeViewController.m
//  DDQRCode
//
//  Created by meitu on 16/6/10.
//  Copyright © 2016年 lcd. All rights reserved.
//

#import "PhotoQRCodeViewController.h"


@interface PhotoQRCodeViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation PhotoQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    [self defaultQRImageView];
}

- (void)defaultQRImageView {
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"QRCode.jpg"]];
    self.imageView.frame = CGRectMake(0, 0, 250, 250);
    self.imageView.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
    self.imageView.userInteractionEnabled = YES;
    [self.view addSubview:self.imageView];
    
    
    UILongPressGestureRecognizer *longPressGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewDidLongPressed:)];
    longPressGes.minimumPressDuration = 1.5;
    [self.imageView addGestureRecognizer:longPressGes];
}

- (void)imageViewDidLongPressed:(UILongPressGestureRecognizer *)ges {
    
    //因为长按手势开始和结束会调用两次这个方法，所以按自己的逻辑处理
    if(ges.state == UIGestureRecognizerStateBegan) {
        
        [self readPhotoQR];
        
    } else if(ges.state == UIGestureRecognizerStateEnded) {
        
    }else if(ges.state == UIGestureRecognizerStateChanged) {
        
        
    }
    
    
}

- (void)readPhotoQR {
    
    UIImage *srcImage = self.imageView.image;
    CIContext *context = [CIContext contextWithOptions:nil];
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:context options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
    CIImage *image = [CIImage imageWithCGImage:srcImage.CGImage];
    NSArray *features = [detector featuresInImage:image];
    CIQRCodeFeature *feature = [features firstObject];
    
    NSString *result = feature.messageString;
    
    if ([result isEqualToString:@""] || result.length == 0) {
        
        QFLOG(@"没有扫描到");
    } else {
        
        QFLOG(@"QRCode is %@",result);
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:result delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
}




@end
