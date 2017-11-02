//
//  QFNavigationController.m
//  装修项目管理
//
//  Created by mmxd on 16/12/28.
//  Copyright © 2016年 mmxd. All rights reserved.
//

#import "QFNavigationController.h"



@interface QFNavigationController ()




@end

@implementation QFNavigationController


- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
                
        [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [self.navigationBar setShadowImage:[UIImage new]];
        [self.navigationBar setBarTintColor:[UIColor setColor:NavgationBarTintColor]];
        

    }
    return self;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    /**
     删除登录页面
     */
//    [self removeController:[[LogInViewController alloc]init]];
    
    if (self.childViewControllers.count > 0) {
        
       // self.hidesBottomBarWhenPushed = YES;
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"Icon_back"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [btn sizeToFit];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];

        
    }
    [super pushViewController:viewController animated:animated];
}

-(void)removeController:(UIViewController *)vc
{
    NSArray* tempVCA = self.childViewControllers;
    
    for(UIViewController *tempVC in tempVCA)
    {
        if([tempVC isKindOfClass:[vc class]])
        {
            [tempVC removeFromParentViewController];
        }
    }
}

-(void)back
{
    [self popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
   
    
    
}




@end
