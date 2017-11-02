//
//  SubUI_ActionSheet.m
//  装修项目管理
//
//  Created by mmxd on 17/1/17.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import "SubUI_UpLoadPhoto.h"
#import "CustomTool_Image.h"
#import "ZLPhotoActionSheet.h"

@interface SubUI_UpLoadPhoto()



@end
@implementation SubUI_UpLoadPhoto



-(id)initWithFrame:(CGRect)frame vc:(WebViewController *)vc
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.vc = vc;
       // number = 0;
    }
    return self;
}

-(void)startloadPhotoEvent:(NSString *)loadstr
{
    if ([loadstr isEqualToString:@"Startuploading"]) {
        
        //直接使用相机拍照上传
        if (self.iscameraonly) {
            
            [self initcamera];
        }
        else
        {
            //可以选择相册或者相机拍照上传
            UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:nil
                                                                   delegate:self
                                                          cancelButtonTitle:@"取消" destructiveButtonTitle:nil
                                                          otherButtonTitles:@"从相册选择",@"拍照上传",nil];
            [actionSheet showInView:self];
        }
        
    }
    else if ([loadstr isEqualToString:@"Uploadagain"])
    {

        
        __block NSString * token =[CustomTool_Cache appObjUserDefault:@"token"];
       __block CustomTool_Image * controlimage ;
        
        if ([NSString isBlankString:token]) {
            
         
                AFHTTPSessionManager * manger =[[AFHTTPSessionManager alloc]init];
                
                [manger GET:[NSString stringWithFormat:@"%@/QiNiu/GetToken",PrefixId] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    
                    token = [responseObject objectForKey:@"Body"];
                    NSDate * date =[NSDate date];
                    [CustomTool_Cache appSetUserDefaults:date andKey:@"tokenDate"];
                    QFLOG(@"申请七牛token ------%@",token);
                    
                    [CustomTool_Cache appSetUserDefaults:token andKey:@"token"];
                    
                    controlimage = [[AppDelegate appdelegate].SaveImageObj objectForKey:self.imagekey];
                    [controlimage uploadFile];
                    //上传成功的block
                    [self getSucessBlock:controlimage];
                    //上传失败的block
                    [self geterrorBlock:controlimage];
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                  
                    QFLOG(@"申请七牛token error ---------%@",error);
                    
                }];
            
        }
        else
        {
            controlimage = [[AppDelegate appdelegate].SaveImageObj objectForKey:self.imagekey];
            [controlimage uploadFile];
            //上传成功的block
            [self getSucessBlock:controlimage];
            //上传失败的block
            [self geterrorBlock:controlimage];
        }
    }
    else if([loadstr isEqualToString:@"DeleteImage"])
    {
        
        CustomTool_Image *  controlimage = [[AppDelegate appdelegate].SaveImageObj objectForKey:self.imagekey];
        
        controlimage.cancellBlock = YES;
        
        NSArray * savekeys = [self.vc.SaveLocalImageKey objectForKey:self.group];
        

        if (savekeys.count > 0) {
            
            for (int i = 0; i < savekeys.count; i ++) {
          
                //删除图片的时候 需要删除保存在本地保存的图片 防止浏览图片的时候出现错误
                if ([savekeys[i] isEqualToString:[NSString base64Decode:self.imagekey]]) {
                    
                    [[self.vc.SaveLocalImage objectForKey:self.group] removeObjectAtIndex:i];
                    [[self.vc.SaveLocalImageKey objectForKey:self.group] removeObjectAtIndex:i];
                    QFLOG(@"本地图片 删除成功 %@  %@  %@",[NSString base64Decode:self.imagekey],self.imagekey,savekeys);
                
                }
            }
        }
        
        //删除对应图片
        [self delegateImage:self.imagekey];
    }
    else
    {
        QFLOG(@"---------------上传图片协议路径不匹配%@",loadstr);
        
    }
}

/**
 *  actionSheet 代理方法
 */
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{    
    if (buttonIndex == 0)
    { // 从相册选择
        
        ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc] init];
        //相册升序排列
        actionSheet.sortAscending = YES;
        //是否可以选择图片
        actionSheet.allowSelectImage = YES;
        //不允许相册内部拍照
        actionSheet.allowTakePhotoInLibrary = NO;
    
        //设置照片最大选择数 单批次最多不能超过9张
       actionSheet.maxSelectCount = [self.maxcount integerValue] > 9 ? 9 : [self.maxcount integerValue];

  
        actionSheet.cellCornerRadio = 0;
        actionSheet.sender = self.vc;
        
        [actionSheet setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
            
        for (int i = 0; i < images.count; i++) {
            
             [self saveloadimgsort:i];
           // 图片KET 中带有其他符号 因为只作为一个标识  所以将它进行加密编码
            NSDictionary * dic =@{[NSString base64encode:[NSString stringWithFormat:@"%@",images[i]]]:[NSString stringWithFormat:@"%d", [AppDelegate appdelegate].uploadImagesort]};
            
             [self upFileImage:images[i] dic:dic imgtype:@".jpeg"];
            
            }
        }];
        
        //显示相册选择视图
        [actionSheet showPhotoLibrary];

    
    }
    else if(buttonIndex == 1)
    {
        [self initcamera];
    }
    
    [self removeFromSuperview];
}

/**
 *  直接调用相机上传
 */
-(void)initcamera
{
    //拍照上传图片
    if ([self validateCamera] && [self canUseCamera]) {
        
        //调用照相机
        ZZCameraController *cameraController = [[ZZCameraController alloc]init];
        //最大连拍三张
        cameraController.takePhotoOfMax = 3;
        //前端传来最大还可以传几张图片
        if ([self.maxcount integerValue] < cameraController.takePhotoOfMax) {
            
            cameraController.takePhotoOfMax = [self.maxcount integerValue];
        }
        
        //判断是否添加水印
        cameraController.iswatermark = self.iswatermark;
        //是否保存相册
        cameraController.isSaveLocal = YES;
        //回调参数
        [cameraController showIn:self.vc result:^(id responseObject){
            
            NSArray *array = (NSArray *)responseObject;
            
            for (int i = 0; i < array.count; i++) {
                
                ZZCamera *camera = [array objectAtIndex:i];
              
                [self saveloadimgsort:i];
                
                NSDictionary * dic =@{[NSString base64encode:[NSString stringWithFormat:@"%@",camera.image]]:[NSString stringWithFormat:@"%d", [AppDelegate appdelegate].uploadImagesort]};
                
                [self upFileImage:camera.image dic:dic imgtype:@".jpeg"];

            }
        
        }];
    }
    else
    {
        [self alerview:@"提示" andMessage:@"没有摄像头或摄像头不可用"];
    }
}

//通过线程上传,选择的顺序会被打乱 用来标上序号 显示出来顺序保持正确 保存排序序号
-(void)saveloadimgsort:(int)i
{
    [AppDelegate appdelegate].uploadImagesort += 1;
    
}


/**
 *  上传图片接口
 *
 *  @param image    需要上传的图片
 *  @param imagedic 每张图片对应一ID排序序号 在多线程中会图片会混乱
 */
-(void)upFileImage:(UIImage *)image dic:(NSDictionary *)imagedic imgtype:(NSString *)imgtype
{
    
   NSMutableArray * saveimage =[NSMutableArray array];
    NSMutableArray * saveKey  =[NSMutableArray array];
    //压缩图片后 保存 用来本地浏览查看
   NSData * imagedata = [NSData compressImage:image toMaxFileSize:300];

    if (self.vc.SaveLocalImage.count > 0) {
        
        [saveimage addObjectsFromArray:[self.vc.SaveLocalImage objectForKey:self.group]];
    }
    
    [saveimage addObject:imagedata];
    
    //保存图片对应组的key 用来删除
    if (self.vc.SaveLocalImageKey.count > 0) {
        
        [saveKey addObjectsFromArray:[self.vc.SaveLocalImageKey objectForKey:self.group]];
    }
    
    [saveKey addObject:[NSString stringWithFormat:@"%@",image]];
    //删除的时候需要
    [self.vc.SaveLocalImageKey setObject:saveKey forKey:self.group];
    //保存图片 本地浏览图片时候需要用到
    [self.vc.SaveLocalImage setObject:saveimage forKey:self.group];

    dispatch_group_t group = dispatch_group_create();
    //2.创建队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_group_async(group, queue, ^{
        
        NSDictionary * dic;
        

        if (![NSString isBlankString:self.group]) {
            
            CustomTool_Image * controlimage =[[CustomTool_Image alloc]initwith:image imgcompressionsize:self.imgcompressionsize imgbase64size:self.imgbase64size];
            
            NSString * base64img =[NSString stringWithFormat:@"data:image/%@;base64,%@",imgtype,controlimage.Imagebase64];
            
            dic =@{@"imagekey":controlimage.keyId,@"status":@"",@"base64":base64img,@"group":self.group,@"sort":imagedic[controlimage.keyId]};
            
            QFLOG(@"[AppDelegate appdelegate].uploadImagesort------------%@  --- %@",imagedic[controlimage.keyId],imagedic);

            
            [self setjsnotificlecallback:self.jscallbackbase64 Replacing:[dic JSONString]];
            
            //上传成功的block
            [self getSucessBlock:controlimage];
            //上传失败的block
            [self geterrorBlock:controlimage];
            
        }
        else
        {
            QFLOG(@"------------group 为空%@",self.group);
            return ;
        }
        
    });
}

#pragma mark----获取沙盒路径
-(NSString *)filePath:(NSString *)fileName
{
    //获取沙盒目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //保存文件名称
    NSString *filePath=[paths[0] stringByAppendingPathComponent:fileName];
    
    return filePath;
}

//上传成功的block
-(void)getSucessBlock:(CustomTool_Image *)controlimage1
{
    __block CustomTool_Image * controlimage = controlimage1;
    
    controlimage.sucessBlock =^(NSString * sucessimageKey,NSString * sucessImageurl){
       
        //回调图片上传成功的block
        NSDictionary * dic =@{@"imagekey":sucessimageKey,@"status":@"success",@"successurl":sucessImageurl,@"group":self.group};
        //将参数json转换 回调传给前端
        [self setjsnotificlecallback:self.jscallbackimagenotify Replacing:[dic JSONString]];
        
        [self delegateImage:sucessimageKey];
        
        controlimage = nil;
    };
}
/**
 *  删除对应图片
 *
 *  @param imageKey 图片的key
 */
-(void)delegateImage:(NSString *)imageKey
{
    if ([[AppDelegate appdelegate].SaveImageObj count] > 0) {
        
        [[AppDelegate appdelegate].SaveImageObj removeObjectForKey:imageKey];

    }
    

}

//上传失败的block
-(void)geterrorBlock:(CustomTool_Image *)controlimage
{
    controlimage.errorBlock =^(NSString * errorimageKey){
 
        NSDictionary * dic =@{@"imagekey":errorimageKey,@"status":@"error",@"successurl":@"",@"group":self.group};
        
        [self setjsnotificlecallback:self.jscallbackimagenotify Replacing:[dic JSONString]];
        
        QFLOG(@"errorKey---------------%@",errorimageKey);
    };
}

/**
 *  回调给前端的参数
 *
 *  @param jscallback 前端传过来的参数
 *  @param jsparame   替换的参数
 */
-(void)setjsnotificlecallback:(NSString *)jscallback Replacing:(NSString *)Replastr
{
    QFLOG(@"图片上传的回调--------------------------%@",jscallback);

    dispatch_async(dispatch_get_main_queue(), ^{
        
      NSString * parame = [jscallback stringByReplacingOccurrencesOfString:@"#imgobj#" withString:Replastr];
        
        QFLOG(@"图片上传回调的参数-----------%@",parame);
        
        [self.vc protocolCallback:parame];

    });
 
}

-(void)alerview:(NSString *)title andMessage:(NSString *)message
{
    
    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:title
                                                       message:message
                                                      delegate:self
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil];
    
    [alerView show];
}

-(BOOL)validateCamera
{
    
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] &&
    [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}
-(BOOL)canUseCamera
{
    
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"请在设备的设置-隐私-相机中允许访问相机。"
                                                           delegate:self cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        return NO;
    }
    return YES;
}
@end
