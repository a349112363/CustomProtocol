//
//  Sub_ShareView.m
//  恒实优选
//
//  Created by 邱凡Bookpro on 2017/10/17.
//  Copyright © 2017年 shenzhenHengshi. All rights reserved.
//

#import "Sub_ShareView.h"

@interface Sub_ShareView()

@property (nonatomic,strong) UIView * CustomView;


@end

@implementation Sub_ShareView

-(UIView *)CustomView
{
    if (_CustomView == nil) {
        
        _CustomView =[[UIView alloc]initWithFrame:CGRectMake(0, IPHONE_HEIGHT - 200, IPHONE_WIDTH, 200)];
        _CustomView.backgroundColor =[UIColor whiteColor];
    }
    return _CustomView;
}

-(id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor =[[UIColor blackColor] colorWithAlphaComponent:0.5];
        [self addSubview:self.CustomView];
        [self setUI];
        
    }
    
    return self;
}

-(void)setUI
{
    for (int i = 0; i < 5; i++) {
        
        UIButton * ShareBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [ShareBtn setTitle:[NSString stringWithFormat:@"按钮%d",i] forState:UIControlStateNormal];
        [ShareBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        ShareBtn.frame = CGRectMake(i * IPHONE_WIDTH  / 5, 20, IPHONE_WIDTH / 5, 40);
        [_CustomView addSubview:ShareBtn];

        ShareBtn.transform = CGAffineTransformMakeTranslation(0,60);
        ShareBtn.alpha = 0;
//
//        /// 系统自带的弹簧效果
//        /// usingSpringWithDamping 0~1 数值越小「弹簧」的振动效果越明显
//        /// initialSpringVelocity 初始的速度，数值越大一开始移动越快
        [UIView animateWithDuration:0.6 delay:i * 0.05 usingSpringWithDamping:0.6 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{;
            ShareBtn.transform = CGAffineTransformMakeTranslation(0,0);
            ShareBtn.alpha = 1;
            
        } completion:^(BOOL finished) {
            
         
            
        }];

        
    }
}

//点击关闭页面
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}
@end
