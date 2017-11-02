//
//  SuperViewController.m
//  装修项目管理
//
//  Created by mmxd on 16/12/21.
//  Copyright © 2016年 mmxd. All rights reserved.
//

#import "SuperViewController.h"


#import "Reachability.h"

@interface SuperViewController ()

@end

@implementation SuperViewController
{
    Reachability *reachability; //监控网络状态对象

}

-(NSMutableArray *)ControlRightitems
{
    if (_ControlRightitems == nil) {
        
        _ControlRightitems =[[NSMutableArray alloc]init];
    }
    return _ControlRightitems;
}

-(NSMutableArray *)ControlLeftitems
{
    if (_ControlLeftitems == nil) {
        
        _ControlLeftitems =[[NSMutableArray alloc]init];
    }
    return _ControlLeftitems;
}

-(NSMutableDictionary *)SaveLocalImage
{
    if (_SaveLocalImage == nil) {
        
        _SaveLocalImage =[[NSMutableDictionary alloc]init];
        
    }
    return _SaveLocalImage;
}

-(NSMutableDictionary *)SaveLocalImageKey
{
    if (_SaveLocalImageKey == nil) {
        
        _SaveLocalImageKey =[NSMutableDictionary dictionary];
    }
    
    return _SaveLocalImageKey;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //清除sdimage  图片缓存
    //[[SDWebImageManager sharedManager].imageCache clearDisk];
    //[self setViewFrameAndNavgationBar];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     *  不自动计算导航条高度
     */
    
    self.view.backgroundColor =[UIColor whiteColor];

    //父类接收到eventstring参数并解密子类获取
    if (![NSString isBlankString:self.eventstring]) {
        
        self.eventstring =[NSString base64Decode:self.eventstring];
    }
    
    
    
    //[self startNotificationNetwork];

}


#pragma mark 网络监控
-(void)startNotificationNetwork{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:fReachabilityChangedNotification object:nil];
    reachability = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    [reachability startNotifier];
}

- (void) reachabilityChanged: (NSNotification* )note
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:fReachabilityChangedNotification object:nil];
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    [self updateInterfaceWithReachability: curReach];
}

- (void) updateInterfaceWithReachability: (Reachability*) curReach
{
    NetworkStatus status = [curReach currentReachabilityStatus];
    
    if (status == NotReachable) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无网络连接" message:@"无网络连接，请检查网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        
        [alert show];
        
    }
    
}













@end
