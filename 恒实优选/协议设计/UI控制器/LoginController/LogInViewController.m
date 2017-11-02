//
//  LogInViewController.m
//  装修项目管理
//
//  Created by mmxd on 16/12/22.
//  Copyright © 2016年 mmxd. All rights reserved.
//

#import "LogInViewController.h"
#import "GJJTabBarViewController.h"
#import "ProtocolClass.h"
#import "SubUI_LoginView.h"
#import "QFNavigationController.h"
#import "WebViewController.h"
@interface LogInViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) SubUI_LoginView * loginview;
@property (nonatomic,strong) UIButton * loginBtn;
@property (nonatomic,copy) NSString *  Notificationstr;
@end

@implementation LogInViewController

{
    //登录错误提示信息
    UILabel * messagetitle;
    UIView  * messageview;
    UIView  * Headview;
    NSTimer * timer;
    MBProgressHUD * HUD;
}

@synthesize eventstring;

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

    if (![NSString isBlankString:self.eventstring]) {
        //通知后台已经退出登录
        [CustomTool_NetworkRequest initSigeHttp:[NSString stringWithFormat:@"%@%@",PrefixId,OUTSIGEN_KEY] andDicValue:@{@"TelCode":UUID_Value}];
    }
   
    //初始化控件
    [self initMessageView];
    
    
  
    
}


-(void)initMessageView
{
     self.loginview =[[SubUI_LoginView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT) vc:self];
    
    self.loginBtn = self.loginview.LoginBtn;
    
    [self.loginBtn addTarget:self action:@selector(LoginBtnclick) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.loginview];
    
    messageview =[[UIView alloc]initWithFrame:
                  CGRectMake(IPHONE_ZERO, IPHONE_ZERO, IPHONE_WIDTH, 64)];
    //隐藏状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:TRUE];
}


-(void)protocolCallback:(NSString *)DecodeString
{
    
    if (![NSString isBlankString:DecodeString])
    {
    
            
        [ProtocolClass ProtocolFactroy:DecodeString vc:self];
        
    }
    else
    {
        QFLOG(@"-------------------------DecodeString为空");
        
    }
}
//点击登录按钮 登录
- (void)LoginBtnclick {
    

    //控制提示信息view
    if (timer)
    {
        [timer invalidate];
        [messageview removeFromSuperview];
    }
    
    [self.loginview endEditing:YES];
    
    NSString * usertext = self.loginview.userTextField.text;
    NSString * passwordtext = self.loginview.passwordTextField.text;
    if (![NSString isBlankString:passwordtext] && ![NSString isBlankString:usertext])
    {
        //防止多次点击按钮
        self.loginBtn.enabled = NO;
        HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.labelText= @"正在登录...";
        [HUD show:YES];
        AFHTTPSessionManager * manger =[AFHTTPSessionManager manager];
     
       // [CustomTool_NetworkRequest AFNetworkHttpHrader:manger];
        
        NSString * DeviceToken = [CustomTool_Cache appObjUserDefault:@"DeviceToken"];
        
        if ([NSString isBlankString:DeviceToken]) {
            
            DeviceToken = @"";
        }
        
        
        NSDictionary * dic =@{@"AccountOrTel":usertext,@"Password":passwordtext,
                              @"AppType":@"ios",@"AppVersion":[NSString getCurVersion],
                              @"TelCode":UUID_Value,@"SendMessageCode":DeviceToken};
//
//        NSDictionary * dic =@{@"AccountOrTel":usertext,@"Password":passwordtext,
//                              @"TelCode":UUID_Value,@"SendMessageCode":DeviceToken};
        
        [manger GET:[NSString stringWithFormat:@"%@%@",PrefixId,Login_KEY] parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            QFLOG(@"%@",responseObject);
            //保存登录是否成功状态
            BOOL islogin = [responseObject[@"Body"] boolValue];
            [CustomTool_Cache appSetUserDefaults:[NSNumber numberWithBool:islogin] andKey:@"bool"];
            
            //登录成功 执行相应事件
            if ([responseObject[@"Body"] boolValue]) {
                //通过协议进行登录页面处理
                if (![NSString isBlankString:self.eventstring]) {
                    
                    NSString * Decode = [NSString base64Decode:self.eventstring];
                
                    //判断首页是GJJTabBarViewController
                    if ([[AppDelegate appdelegate].window.rootViewController isKindOfClass:[GJJTabBarViewController class]]) {
                        
                        GJJTabBarViewController * tab =(GJJTabBarViewController *)[AppDelegate appdelegate].window.rootViewController;
                        QFNavigationController * nav =(QFNavigationController *)tab.selectedViewController;
                       
                        //点击登录后 执行通知 让当前页面webview 执行eventstring事件
                        if (![NSString isBlankString:Decode]) {
                            //找到当前控制器 执行协议
                            WebViewController * currentVC =nav.viewControllers.lastObject;
                            [currentVC protocolCallback:Decode];
                        }
                    }
                    
                    [self dismissViewControllerAnimated:YES completion:^{
                        
                        

                    }];
                    
                    
                }
                else
                {
                    

                    //第一次进入app 登录页面处理
                    GJJTabBarViewController * vc =[[GJJTabBarViewController alloc]init];
                    [AppDelegate appdelegate].window.rootViewController = vc;
                }
            }
            else
            {
                [self notification:[NSString stringWithFormat:@"%@",responseObject[@"Msg"]]];
            }
            //恢复按钮点击
            self.loginBtn.enabled = YES;
            [HUD hide:YES];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            QFLOG(@"error============%@",error);
            [self notification:[NSString stringWithFormat:@"网络超时,请重新登录"]];
            [HUD hide:YES];
            self.loginBtn.enabled = YES;
            
        }];
    }
    else if([NSString isBlankString:usertext])
    {
        [self notification:[NSString stringWithFormat:@"请输入用户名"]];
    }
    else
    {
        [self notification:[NSString stringWithFormat:@"请输入密码"]];
    }
}

#pragma mark -错误提示
-(void)notification:(NSString *)message
{
    messagetitle.text = @"";
    
    [UIView animateWithDuration:0.5f animations:^{
        
        messageview.frame = CGRectMake(IPHONE_ZERO,64, self.view.frame.size.width, 64);
        messageview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.9];
        messagetitle = [[UILabel alloc]initWithFrame:CGRectMake(70, 25, 200, 20)];
        messagetitle.text = message;
        messagetitle.font =[UIFont systemFontOfSize:15.0f];
        messagetitle.textColor = [UIColor whiteColor];
        
        UIImageView * imageview =[[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 30, 30)];
        imageview.image =[UIImage imageNamed:@"warn"];
        [messageview addSubview:imageview];
        [messageview addSubview:messagetitle];
        
    }];
    messageview.frame = CGRectMake(IPHONE_ZERO, IPHONE_ZERO, IPHONE_WIDTH, 64);
    [self.view addSubview:messageview];
    timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(timer) userInfo:nil repeats:NO];
    
}
-(void)timer
{
    [timer invalidate];
    [messageview removeFromSuperview];
}
//状态栏控制
-(BOOL)prefersStatusBarHidden
{
    return YES; // 返回NO表示要显示，返回YES将hiden
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
