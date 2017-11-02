//
//  GJJTabBarViewController.m
//
//  Created by 邱凡Bookpro on 16/7/7.
//  Copyright © 2016年 邱凡Bookpro. All rights reserved.
//

#import "GJJTabBarViewController.h"

#import "QFNavigationController.h"
#import "WebViewController.h"

@interface GJJTabBarViewController ()

@end

@implementation GJJTabBarViewController

+ (void)initialize
{
    UITabBarItem * item =[UITabBarItem appearance];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor setColor:@"666666"]} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor setColor:@"24293d"]} forState:UIControlStateSelected];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置tabbar背景图片
    //    UIImageView * imageview =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, 49)];
    //    imageview.image = [UIImage imageNamed:@"tabbar_background_icon"];
    //    [self.tabBar insertSubview:imageview atIndex:0];
    
    //        if (self.navigationController.viewControllers.count == 1) {
    //
    //            QFLOG(@"%@",self.tabBarController.tabBar.subviews);
    //
    //            for (UIView * view in self.tabBarController.tabBar.subviews) {
    //
    //                if ([view isKindOfClass:[UIImageView class]]) {
    //
    //                    [view removeFromSuperview];
    //                }
    //            }
    //
    //            self.tabBarController.tabBar.backgroundColor = [UIColor whiteColor];
    //            self.tabBarController.tabBar.layer.shadowColor = [UIColor setColor:@"e1e1e1"].CGColor;
    //            self.tabBarController.tabBar.layer.shadowOffset = CGSizeMake(0, 0.5);
    //            self.tabBarController.tabBar.layer.shadowOpacity = 1;
    //
    //        }
    
    
    NSDictionary * firstdata   = @{@"title":@"商品分类",
                                   @"selimage":@"classify_btn_sel",
                                   @"norimage":@"classify_btn_nor",
                                   @"weburl":@"/app/cat_all.php"};
    
    NSDictionary * seconddata = @{@"title":@"客服",
                                  @"selimage":@"service_btn_sel",
                                  @"norimage":@"service_btn_nor",
                                  @"weburl":@"http://free.appkefu.com/AppKeFu/float/web/chat.php"};
    
    NSDictionary * thirddata  = @{@"title":@"首页",
                                  @"selimage":@"home_btn_sel",
                                  @"norimage":@"home_btn_nor",
                                  @"weburl":@"/app/index.php"};
    
    NSDictionary * fourcedata = @{@"title":@"购物车",
                                  @"selimage":@"shopping_btn_sel",
                                  @"norimage":@"shopping_btn_nor",
                                  @"weburl":@"/app/flow.php"};
    
    NSDictionary * fivedata   = @{@"title":@"关于我们",
                                  @"selimage":@"about_us_btn_sel",
                                  @"norimage":@"about_us_btn_nor",
                                  @"weburl":@"/app/article.php?id=74"};
    
    NSArray * vcs = @[firstdata,seconddata,thirddata,fourcedata,fivedata];
    
    for (int i = 0; i < vcs.count; i++) {
        
        WebViewController * vc = [[WebViewController alloc]init];
        vc.webvUrl = vcs[i][@"weburl"];
        [self setUpChirl:vc title:vcs[i][@"title"] image:vcs[i][@"norimage"] selected:vcs[i][@"selimage"]];
    }
    
//        SPFLViewController  * SPFL  = [[SPFLViewController alloc] init];
//        KFViewController    * KF    = [[KFViewController alloc] init];
//        RootViewController  * Root  = [[RootViewController alloc] init];
//        LQTJViewController  * LQTJ  = [[LQTJViewController alloc] init];
//        GYWMViewController  * GYWM  = [[GYWMViewController alloc] init];
//    
//        [self setUpChirl:SPFL title:@"商品分类"
//                   image:@"classify_btn_nor"
//                selected:@"classify_btn_sel"];
//    
//        [self setUpChirl:KF title:@"客服"
//                   image:@"service_btn_nor"
//                selected:@"service_btn_sel"];
//    
//        [self setUpChirl:Root title:@"首页"
//                   image:@"home_btn_nor"
//                selected:@"home_btn_sel"];
//    
//        [self setUpChirl:LQTJ title:@"购物车"
//                   image:@"shopping_btn_nor"
//                selected:@"shopping_btn_sel"];
//    
//    
//        [self setUpChirl:GYWM title:@"关于我们"
//                   image:@"about_us_btn_nor"
//                selected:@"about_us_btn_sel"];
    
    
}

-(void)setUpChirl:(UIViewController *)vc
            title:(NSString *)title
            image:(NSString *)image
         selected:(NSString *)selected
{
    
    [vc.tabBarItem setTitle:title];
    
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selected]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    

    
    QFNavigationController * nav = [[QFNavigationController alloc]initWithRootViewController:vc];
    
    [self addChildViewController:nav];
    
}





@end
