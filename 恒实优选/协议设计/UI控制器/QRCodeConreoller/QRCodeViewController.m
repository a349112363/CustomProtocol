//
//  DDQRCodeViewController.m
//  DDQRCode
//
//  Created by meitu on 16/6/10.
//  Copyright © 2016年 lcd. All rights reserved.
//

#import "QRCodeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "QRView.h"
#import "QRUtil.h"
#import "ProtocolClass.h"

@interface QRCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate>


@property (strong, nonatomic) AVCaptureDevice * device;
@property (strong, nonatomic) AVCaptureDeviceInput * input;
@property (strong, nonatomic) AVCaptureMetadataOutput * output;
@property (strong, nonatomic) AVCaptureSession * session;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer * preview;

@property (nonatomic, strong) UIButton *backBtn;

@property (nonatomic, strong) UILabel * label;

@property (nonatomic, strong) QRView *qrView;

@property (nonatomic, copy) ScanCompleteBlock scanCompleteBlock;

@property (nonatomic, copy, readwrite) NSString *urlString;

@property (nonatomic,assign) BOOL isStart; //判断是否扫描完成


@end



@implementation QRCodeViewController
{
    UIAlertView * sucessalert;
    MBProgressHUD * _HUD;
    
}

@synthesize eventstring;

//vcp 权限初始值设置
-(void)setVcp:(VCPermissionsenum)vcp
{
    _vcp = vcp;
}

-(VCPermissionsenum)vcp
{
    _vcp = CameraPermissions ;
    
    return _vcp;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor blackColor];
    //self.isStart = NO;
    //self.navigationController.navigationBarHidden = YES;
    
    _HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    _HUD.labelText = @"正在处理...";
    
    _HUD.color = [UIColor clearColor];
    
    [self performSelector:@selector(defaultConfig) withObject:nil afterDelay:0.02];
    
   [self configUI];
  
}

- (void)defaultConfig
{
    //初始化配置,主要是二维码的配置
    [self startRunning];
   
    [self updateLayout];
    
    [_HUD hide:YES];
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
//    if (![_session isRunning]) {
//        
//        [self startRunning];
//    }
    
}
- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self stopRunning];
}

- (void)configUI {
    
    [self.view addSubview:self.qrView];
    [self.view addSubview:self.backBtn];
    [self.view addSubview:self.label];
    
}

- (void)updateLayout {
    
    
    
    _qrView.center = CGPointMake([QRUtil screenBounds].size.width / 2, [QRUtil screenBounds].size.height / 2);
    
    //修正扫描区域
    CGFloat screenHeight = self.view.frame.size.height;
    CGFloat screenWidth = self.view.frame.size.width;
    CGRect cropRect = CGRectMake((screenWidth - self.qrView.transparentArea.width) / 2,
                                 (screenHeight - self.qrView.transparentArea.height) / 2,
                                 self.qrView.transparentArea.width,
                                 self.qrView.transparentArea.height);
    
    [_output setRectOfInterest:CGRectMake(cropRect.origin.y / screenHeight,
                                          cropRect.origin.x / screenWidth,
                                          cropRect.size.height / screenHeight,
                                          cropRect.size.width / screenWidth)];
}

//- (void)pop:(UIButton *)button {
//    
//    [self.navigationController popViewControllerAnimated:YES];
//
//    
////    sucessalert =[[UIAlertView alloc]initWithTitle:@"友情提示" message:@"是否取消二维码扫描" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
////        
////    [sucessalert show];
//   
//}
//点击完成按钮,将二维码集合通过协议传给前端
-(void)sucesspop:(UIButton *)button
{
//    if (![NSString isBlankString:self.jscallback]) {
//        
//        NSString * Decode = [NSString base64Decode:self.jscallback];
//        
//        NSArray * arrs =[Decode componentsSeparatedByString:@"#"];
//        
//        if (arrs.count > 2)
//        {
//            NSString * str =[arrs[1] stringByReplacingOccurrencesOfString:arrs[1] withString:self.urlString];
//            
//            NSString * encode =[NSString base64encode:[NSString stringWithFormat:@"%@%@%@",arrs[0],str,arrs[2]]];
//            
//            NSString * protocol = [NSString stringWithFormat:@"gjj://Close.Page/1?jscallback=%@",encode];
//            
//            [ProtocolClass ProtocolFactroy:protocol vc:self];
//        }
//        
//    }
  
}
#pragma mark - Public Method
//-(instancetype)initWithScanCompleteHandler:(ScanCompleteBlock)scanCompleteBlock {
//    
//    self = [super init];
//    if (self) {
//        _scanCompleteBlock = scanCompleteBlock;
//    }
//    return self;
//}

- (void)startRunning {
    
    
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    AVCaptureConnection *outputConnection = [_output connectionWithMediaType:AVMediaTypeVideo];
    outputConnection.videoOrientation = [QRUtil videoOrientationFromCurrentDeviceOrientation];
    
    //支持条码 二维码
    _output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode
                                    ,AVMetadataObjectTypeEAN13Code,
                                    AVMetadataObjectTypeEAN8Code,
                                    AVMetadataObjectTypeCode128Code];
    // 条码类型 AVMetadataObjectTypeQRCode
   // _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity =AVLayerVideoGravityResize;
    _preview.frame =[QRUtil screenBounds];
    [self.view.layer insertSublayer:_preview atIndex:0];
    
    _preview.connection.videoOrientation = [QRUtil videoOrientationFromCurrentDeviceOrientation];
    
    [_session startRunning];
}

- (void)stopRunning {
    
    [_preview removeFromSuperlayer];
    [_session stopRunning];
    
}

#pragma mark QRViewDelegate
//-(void)scanTypeConfig:(QRItem *)item {
//    
//    if (item.type == QRItemTypeQRCode) {
//        _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
//        
//    } else if (item.type == QRItemTypeOther) {
//        
//        _output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode
//                                         ,AVMetadataObjectTypeEAN13Code,
//                                        AVMetadataObjectTypeEAN8Code,
//                                        AVMetadataObjectTypeCode128Code];
//    }
//}
#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue = @"";
    
//    BOOL isexist;
    
    if ([metadataObjects count] >0)
    {
        //停止扫描
        [_session stopRunning];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        
        //self.isStart = YES;
    }
    //获取到扫描字符串
    if (![NSString isBlankString:stringValue]) {
        
       // self.urlString = stringValue;
        
        
        //循环遍历扫描到的字符串是否存在
//        for (int i = 0; i<self.scanSucessUrls.count; i++) {
//            
//            if ([stringValue isEqualToString:self.scanSucessUrls[i]]) {
//                
//                isexist = YES;
//                return;
//            }
//        }
//        
//        if (!isexist) {
//            
//            [self.scanSucessUrls addObject:stringValue];
//
//        }
        QFLOG(@" 扫描后的url是:%@",stringValue);
        
        UIAlertView * alertview1 =[[UIAlertView alloc] initWithTitle:@"扫描内容" message:stringValue delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        
        [alertview1 show];
        /**
         *  判断出二维码扫描是一个url链接,就直接执行页面跳转的 如果是一个gjj协议 直接执行协议工厂方法
         */
        if ([stringValue hasPrefix:@"http://"] || [stringValue hasPrefix:@"https://"]) {
            
            NSString * protocol =[NSString stringWithFormat:@"gjj://Open.HTML/%@",[NSString base64encode:stringValue]];
            
            [ProtocolClass ProtocolFactroy:protocol vc:self];
        }
        else if ([stringValue hasPrefix:Protocol_Header])
        {
            [ProtocolClass ProtocolFactroy:stringValue vc:self];
        }
        else
        {
            //如果是一个eventstring,解密处理处理协议，替换回调参数里面的值
            if (![NSString isBlankString:self.eventstring]) {
                
//                NSString * Decode = [NSString base64Decode:self.eventstring];
                QFLOG(@"%@",self.eventstring);
                
                if ([self.eventstring hasPrefix:Protocol_Header]) {
                    
                    ProtocolClass * prtocolclass = [[ProtocolClass alloc] initWithStr:self.eventstring viewcontrol:self];
                    
                    [prtocolclass paramrepalcebase64:@"jscallback" paramkey:@"#QR#" paramvalue:stringValue];
                    
                    Class class = NSClassFromString([prtocolclass.ProtocolContext stringByReplacingOccurrencesOfString:@"." withString:@"_"]);
                    
                    QFLOG(@"%@",prtocolclass.protocolUtlStr);
                    
                    ProtocolClass * prot =[[class alloc]initWithStr:prtocolclass.protocolUtlStr viewcontrol:self];
                    
                    [prot run];
                }
            }
            else
            {
                //如果是jscallback 就执行close协议 并替换里面的值
                if (![NSString isBlankString:self.jscallback]) {
                    
                    NSString * Decode =[[NSString base64Decode:self.jscallback] stringByReplacingOccurrencesOfString:@"#QR#" withString:stringValue];
                
                    [ProtocolClass ProtocolFactroy:[NSString stringWithFormat:@"gjj://Close.Page/1?jscallback=%@",[NSString base64encode:Decode]] vc:self];
                    
                }

            }
        }
        
        //扫描完成后 删除当前控制器
//            NSArray* tempVCA = [self.navigationController viewControllers];
//            
//            for(UIViewController *tempVC in tempVCA)
//            {
//                if([tempVC isKindOfClass:[self class]])
//                    
//                {
//                    [tempVC removeFromParentViewController];
//                }
//            }
//   
        
//        if (self.scanCompleteBlock)
//        {
//            self.scanCompleteBlock(stringValue);
//        }
    }
    else
    {
        UIAlertView * alertview =[[UIAlertView alloc]initWithTitle:@"友情提示" message:@"无法识别该条码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"重试", nil];
        
        [alertview show];
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    if (alertView == sucessalert) {
//        
//        if (buttonIndex == 1) {
//            
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//    }
//    else
//    {
        if (buttonIndex == 1) {
        
            [_session startRunning];
        }
  //  }
}

//如果扫描成功 点击屏幕可以重新扫描新的
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    if (self.isStart) {
//        
//        [_session startRunning];
//    }
//}
#pragma mark - Getter and Setter
//-(UIButton *)backBtn {
//    
//    if (!_backBtn) {
//        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _backBtn.frame = CGRectMake(20, 20, 50, 50);
//        [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
//        [_backBtn addTarget:self action:@selector(pop:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _backBtn;
//}

-(UILabel *)label {
    
    if (!_label) {
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, IPHONE_HEIGHT / 2 + _qrView.transparentArea.height / 2 + 5, IPHONE_WIDTH, 40)];
        _label.text =@"将二维码/条形码放入框内,即可自动扫描";
        _label.textColor = [UIColor whiteColor];
        _label.font = [UIFont systemFontOfSize:14.0f];
        _label.textAlignment = NSTextAlignmentCenter;

    }
    return _label;
}


-(QRView *)qrView {
    
    if (!_qrView) {
        
        CGSize size ;
        
        if (IPHONE_WIDTH > 320) {
            
            size = CGSizeMake(260,260);
        }
        else
        {
            size = CGSizeMake(200,200);

        }
        
        CGRect screenRect = [QRUtil screenBounds];
        
        _qrView = [[QRView alloc] initWithFrame:screenRect];
        
        _qrView.transparentArea = size;
        
        _qrView.backgroundColor = [UIColor clearColor];
      //  _qrView.delegate = self;
    }
    return _qrView;
}

@end
