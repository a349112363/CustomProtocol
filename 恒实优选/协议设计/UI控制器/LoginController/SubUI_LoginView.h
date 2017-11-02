//
//  SubUI_LoginView.h
//  LoginViewcontroller
//
//  Created by mmxd on 17/1/24.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SubUI_LoginView : UIView

@property (nonatomic,strong) UIViewController * vc;
@property (nonatomic,strong) UITextField * userTextField;//用户名输入框
@property (nonatomic,strong) UITextField * passwordTextField;//密码输入框
@property (nonatomic,strong) UIButton * LoginBtn;//登录按钮


-(id)initWithFrame:(CGRect)frame vc:(UIViewController *)vc;
@end
