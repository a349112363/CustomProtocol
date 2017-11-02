//
//  SubUI_LoginView.m
//  LoginViewcontroller
//
//  Created by mmxd on 17/1/24.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import "SubUI_LoginView.h"
#import "ZYKeyboardUtil.h"

@interface SubUI_LoginView()<UITextFieldDelegate>

@property (nonatomic,strong)UIImageView * headerImage; //logo图片

@property (nonatomic,strong) UIView * userLine;//用户名输入框下面的线

@property (nonatomic,strong) UIView * passwordLine;//密码输入框下面的线

@property (nonatomic,strong) UIImageView * userImage;//用户名输入框前图标

@property (nonatomic,strong) UIImageView * passwordImage;//密码输入框前图标

@property (nonatomic,strong) UIView * centerView;//包含输入框的整个view

@property (nonatomic,strong) UILabel * label;//底部温馨提示

@property (strong, nonatomic) ZYKeyboardUtil *keyboardUtil;


@end

@implementation SubUI_LoginView


-(id)initWithFrame:(CGRect)frame  vc:(UIViewController *)vc
{
   self = [super initWithFrame:frame];
    
    if (self) {
        self.vc = vc;
        self.backgroundColor =UIColorFromRGB(0x2b2f3f);
        [self setCenterViewframe];
        [self setheaderImageframe];
        [self setLoginBtnAndLaeblframe];
        
        //键盘控制
        //[self configKeyBoardRespond];
        
        //键盘弹起
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHide:) name:UIKeyboardWillHideNotification object:nil];

    }
    
    return self;
    
}

-(UIImageView *)headerImage
{
    if (_headerImage == nil) {
        
        _headerImage =[[UIImageView alloc]init];
        _headerImage.image = [UIImage imageNamed:@"logoicon"];
        
    }
    return  _headerImage;
}

-(UIButton *)LoginBtn
{
    if (_LoginBtn == nil) {
        
        _LoginBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_LoginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_LoginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _LoginBtn.backgroundColor =[UIColor whiteColor];
        _LoginBtn.layer.cornerRadius = 5;
        _LoginBtn.clipsToBounds = YES;
    }
    return _LoginBtn;
}


-(UILabel *)label
{
    if (_label == nil) {
        
        _label =[[UILabel alloc]init];
        _label.text= @"温馨提示:过家家装修项目应用不对外开放注册,如果您还没有账号,请联系过家家工作人员获取账号和密码。";
        _label.font = [UIFont systemFontOfSize:12.0f];
        _label.textColor =UIColorFromRGB(0x8288a1);
        _label.numberOfLines = 0;
      
    }
    return _label;
}

-(UITextField *)userTextField
{
    if (_userTextField == nil) {
        
        _userTextField =[[UITextField alloc]init];
        _userTextField.delegate = self;
        _userTextField.placeholder = @"请输入用户名";
        _userTextField.textColor =[UIColor whiteColor];
        _userTextField.borderStyle = UITextBorderStyleNone;
        _userTextField.clearButtonMode = UITextFieldViewModeAlways;
        _userTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [_userTextField setValue:UIColorFromRGB(0xe6ebfb) forKeyPath:@"_placeholderLabel.textColor"];
        [_userTextField setValue:[UIFont systemFontOfSize:12.0f] forKeyPath:@"_placeholderLabel.font"];
        _userTextField.font = [UIFont systemFontOfSize:12.0f];
    }
    return _userTextField;
}

-(UITextField *)passwordTextField
{
    if (_passwordTextField == nil) {
        
        _passwordTextField =[[UITextField alloc]init];
        _passwordTextField.placeholder =@"请输入密码";
        _passwordTextField.textColor =[UIColor whiteColor];
        _passwordTextField.delegate = self;
        _passwordTextField.borderStyle = UITextBorderStyleNone;
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.clearButtonMode = UITextFieldViewModeAlways;
       
        [_passwordTextField setValue:UIColorFromRGB(0xe6ebfb) forKeyPath:@"_placeholderLabel.textColor"];
        [_passwordTextField setValue:[UIFont systemFontOfSize:12.0f] forKeyPath:@"_placeholderLabel.font"];
        _passwordTextField.font = [UIFont systemFontOfSize:12.0f];


    }
    return _passwordTextField;
}

-(UIImageView *)userImage
{
    if (_userImage == nil) {
        
        _userImage =[[UIImageView alloc]init];
        _userImage.image =[UIImage imageNamed:@"usericon"];
        
    }
    return _userImage;
}

-(UIImageView *)passwordImage
{
    if (_passwordImage == nil) {
        
        _passwordImage =[[UIImageView alloc]init];
        _passwordImage.image =[UIImage imageNamed:@"passwordicon"];

    }
    return _passwordImage;
}

-(UIView *)centerView
{
    if (_centerView == nil) {
        
        _centerView =[[UIView alloc]init];

    }
    return _centerView;
}

-(UIView *)userLine
{
    if (_userLine == nil) {
    
        _userLine =[[UIView alloc]init];
        _userLine.backgroundColor = UIColorFromRGB(0xe6ebfb);
    }
    return _userLine;
}


-(UIView *)passwordLine
{
    if (_passwordLine == nil) {
        
        _passwordLine =[[UIView alloc]init];
        _passwordLine.backgroundColor = UIColorFromRGB(0xe6ebfb);
    }
    return _passwordLine;
}
//设置logo布局
-(void)setheaderImageframe
{
    [self addSubview:self.headerImage];
    [self.headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(self.centerView.mas_top).offset(-20);
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(self.headerImage.image.size.width);
        make.height.mas_equalTo(self.headerImage.image.size.height);
    }];
}
//设置中心view布局
-(void)setCenterViewframe
{
    //线的X 轴
    CGFloat lineX = 45;
    //图片X轴
    CGFloat imageX = 10 + lineX;
    //输入框X轴
    CGFloat textfieldX = self.userImage.image.size.width + imageX + 15;
    //输入框高度
    CGFloat height = 35;
    //顶部留白区域
    CGFloat top = 10;
    
    //添加中间输入框部分控件布局
    [self.centerView addSubview:self.userTextField];
    [self.centerView addSubview:self.passwordTextField];
    [self.centerView addSubview:self.userLine];
    [self.centerView addSubview:self.passwordLine];
    [self.centerView addSubview:self.userImage];
    [self.centerView addSubview:self.passwordImage];
    [self addSubview:self.centerView];
    
    //输入用户名
    [self.userTextField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(textfieldX);
        make.right.mas_equalTo(-lineX);
        make.top.mas_equalTo(top);
        make.height.mas_equalTo(height);
    }];
    
    //输入密码
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.mas_equalTo(self.userTextField.mas_leading);
        make.width.mas_equalTo(self.userTextField.mas_width);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(self.userTextField.mas_height);
    }];
    
    //用户名下划线
    [self.userLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(lineX);
        make.right.mas_equalTo(-lineX);
        make.top.mas_equalTo(height+top);
        make.height.mas_equalTo(1);
    }];
    
    //密码下划线
    [self.passwordLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.mas_equalTo(self.userLine.mas_leading);
        make.width.mas_equalTo(self.userLine.mas_width);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(self.userLine.mas_height);
    }];
    
    //用户名图片
    [self.userImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(imageX);
        make.width.mas_equalTo(self.userImage.image.size.width);
        make.centerY.mas_equalTo(self.userTextField.mas_centerY);
        make.height.mas_equalTo(self.userImage.image.size.height);
    }];
    
    //密码图片
    [self.passwordImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.mas_equalTo(self.userImage.mas_leading);
        make.width.mas_equalTo(self.passwordImage.image.size.width);
        make.centerY.mas_equalTo(self.passwordTextField.mas_centerY);
        make.height.mas_equalTo(self.passwordImage.image.size.height);
        
    }];
    
    //整个输入框view
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(120);
    }];
}
//设置按钮frame
-(void)setLoginBtnAndLaeblframe
{
    [self addSubview:self.LoginBtn];
    [self addSubview:self.label];
    
    [self.LoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.passwordLine.mas_bottom).offset(40);
        make.leading.mas_equalTo(self.passwordLine.mas_leading);
        make.width.mas_equalTo(self.passwordLine.mas_width);
        make.height.mas_equalTo(50);
    }];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.LoginBtn.mas_bottom).offset(30);
        make.leading.mas_equalTo(self.LoginBtn.mas_leading);
        make.width.mas_equalTo(self.LoginBtn.mas_width);
        make.height.mas_equalTo(60);
        
    }];
}





//点击收键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}


//通知键盘弹起
-(void)keyBoardShow:(NSNotification *)note{
    
    NSDictionary *info = note.userInfo;
    CGRect keyBoardFrame = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    
   
    double duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    keyBoardFrame = [self convertRect:keyBoardFrame toView:nil];
    CGFloat deltaY = keyBoardFrame.size.height;
    
    if (self.height - deltaY < self.LoginBtn.y + self.LoginBtn.height) {
        
        [UIView animateWithDuration:duration delay:0 options:[[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue]<<16 animations:^{
            self.transform = CGAffineTransformMakeTranslation(0, -(self.LoginBtn.y + self.LoginBtn.height - self.height + deltaY));
            
        } completion:nil];
    }
  
    
}
//通知键盘隐藏
-(void)keyBoardHide:(NSNotification *)note{
    
    self.transform = CGAffineTransformIdentity;
}
//键盘处理
//- (void)configKeyBoardRespond {
//    
//    self.keyboardUtil = [[ZYKeyboardUtil alloc] init];
//    
//    __weak SubUI_LoginView *weakSelf = self;
//#pragma explain - 全自动键盘弹出/收起处理 (需调用keyboardUtil 的 adaptiveViewHandleWithController:adaptiveView:)
//#pragma explain - use animateWhenKeyboardAppearBlock, animateWhenKeyboardAppearAutomaticAnimBlock will be invalid.
//    
//    [_keyboardUtil setAnimateWhenKeyboardAppearAutomaticAnimBlock:^(ZYKeyboardUtil *keyboardUtil) {
//        
//        [keyboardUtil adaptiveViewHandleWithController:weakSelf.vc adaptiveView:weakSelf.userTextField, weakSelf.passwordTextField,weakSelf.LoginBtn,nil];
//    }];
//}

//点击return 关闭键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
     [self.userTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    return YES;
}

@end
