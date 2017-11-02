//
//  QFalertView.m
//  guoJiaJia
//
//  Created by mmxd on 16/8/16.
//  Copyright © 2016年 mmxd. All rights reserved.
//

#import "QFalertView.h"
static const CGFloat value = 40;//底部按钮高度

@implementation QFalertView
{
    CGFloat width;//弹窗宽度
    UIView * messageview;//内容view
    UIView * sureview;//按钮view
    CGFloat fontSize;//按钮和内容文字大小
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor =[[UIColor blackColor]colorWithAlphaComponent:0.4f];
        
    }
    return self;
}

/*
 *初始化
 */
-(void)viewShow
{
    fontSize = 14.0f;
    
    [self isForciblyUpdete:self.isUpdate];
   
}
/****判断是否是强制更新******/
-(void)isForciblyUpdete:(BOOL)isFprcoby
{
    //创建弹窗
    [self creatAlertview];
    //创建标题
    [self creatTitleLabel];
    //创建内容
    [self creatMessageLabel];
    //创建更新按钮
    [self creatBottomBtn:isFprcoby];

    //最后更新弹窗高度
    [self updateAlertHeight];

    
}
-(void)creatAlertview
{
    self.alertView =[[UIView alloc]init];
    self.alertView.frame = CGRectMake(50, 0, IPHONE_WIDTH - 100, 200);
    self.alertView.center = self.center;
    self.alertView.backgroundColor =UIColorFromRGB(0xcacaca);
    self.alertView.layer.cornerRadius = 5;
    self.alertView.clipsToBounds = YES;
    [self addSubview:self.alertView];
    
    width =self.alertView.width;
}
-(void)creatTitleLabel
{

    
    self.titleLabel = [UILabel setLabelTitle:@"版本更新"
                                     setFont:16.0f
                                    setframe:CGRectMake(0, 0,width, 44)
                                 setposition:ControlPositionCenter
                                   setweight:0
                            setnumberOfLines:0
                               settitlecolor:@"434343"];
    
    self.titleLabel.backgroundColor =[UIColor whiteColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:16.0f weight:1.0f];
    [self.alertView addSubview:self.titleLabel];
}
-(void)creatMessageLabel
{
    CGFloat wordheight;
    //获取文字高度
    if (IPHONE_WIDTH == 320) {
        
        wordheight = 12.0f;
    }
    else
    {
        wordheight = 14.0f;

    }
    CGFloat height = [self.messageStr boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:wordheight]} context:nil].size.height;
    
    messageview =[[UIView alloc]init];
    if (self.isUpdate==YES) {
        messageview.frame =CGRectMake(0, self.titleLabel.height+1, width, height+10);
    }
    else
    {
        messageview.frame =CGRectMake(0, self.titleLabel.height, width, height+10);

    }
    messageview.backgroundColor =[UIColor whiteColor];
    
    [self.alertView addSubview:messageview];
    
    self.messageLabel = [UILabel setLabelTitle:self.messageStr
                                     setFont:wordheight
                                    setframe:CGRectMake(20, 5, width - 40, height)
                                 setposition:ControlPositionLeft
                                   setweight:0
                            setnumberOfLines:0
                               settitlecolor:@"4b4b4b"];

    self.messageLabel.numberOfLines = 0;
    self.messageLabel.backgroundColor =[UIColor whiteColor];
    [messageview addSubview:self.messageLabel];
}

-(void)creatBottomBtn:(BOOL)update
{
        self.sureBtn =[UIButton setBtnTitle:@"立即更新"
                                   setImage:nil
                               setbackimage:nil
                                    setFont:fontSize
                                   setframe:CGRectZero
                                     settag:1000
                                setposition:ControlPositionCenter
                                  setweight:0
                              settitlecolor:@"ffffff"];
    
     CGFloat y = messageview.height + messageview.y;
    //强制更新的时候 只有一个按钮
    if (update==YES) {
        
        sureview=[[UIView alloc]initWithFrame:CGRectMake(0,y, width,value)];
        sureview.backgroundColor =[UIColor whiteColor];
        [self.alertView addSubview:sureview];
        
        self.sureBtn.frame = CGRectMake(40,0, width - 80, 30);
        self.sureBtn.backgroundColor =UIColorFromRGB(0xffa800);
        self.sureBtn.layer.cornerRadius = 5;
        self.sureBtn.clipsToBounds = YES;
        [sureview addSubview:self.sureBtn];
    }
    else
    {
        //非强制更新 两个按钮
        self.sureBtn.frame = CGRectMake(width / 2,y + 1, width / 2, value-1);
        [self.sureBtn setTitleColor:UIColorFromRGB(0xffa800) forState:UIControlStateNormal];
        self.sureBtn.backgroundColor =[UIColor whiteColor];
        
        self.cancelBtn =[UIButton setBtnTitle:@"暂不更新"
                                     setImage:nil
                                 setbackimage:nil
                                      setFont:fontSize
                                     setframe:CGRectZero
                                       settag:10001
                                  setposition:ControlPositionCenter
                                    setweight:0
                                settitlecolor:@"0x9a9a9a"];
        
        self.cancelBtn.frame =CGRectMake(0,y+1, width / 2-1, value-1);
        [self.cancelBtn setTitleColor:UIColorFromRGB(0x9a9a9a) forState:UIControlStateNormal];
        self.cancelBtn.backgroundColor =[UIColor whiteColor];
        
        [self.cancelBtn addTarget:self action:@selector(clickCancel) forControlEvents:UIControlEventTouchUpInside];
        
        [self.alertView addSubview:self.cancelBtn];
        [self.alertView addSubview:self.sureBtn];
    }
    [self.sureBtn addTarget:self action:@selector(clickUpdate) forControlEvents:UIControlEventTouchUpInside];

}
-(void)updateAlertHeight
{
    CGFloat alertHeight =self.titleLabel.height + messageview.height + value;
    self.alertView.frame = CGRectMake(50, 0, IPHONE_WIDTH - 100, alertHeight);
    self.alertView.center = self.center;
    
    QFLOG(@"%lf",alertHeight);
}

/*******
 点击取消
 ********/
-(void)clickCancel
{
    [self removeFromSuperview];
}

/*******
 点击立即更新
 *********/
-(void)clickUpdate
{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.url]];
    
     [self removeFromSuperview];
    //只有强制退出的时候 才退出app
    if (self.isUpdate == YES) {
        
        [self exitApplication];
    }
}
- (void)exitApplication {
    
    //退出app
    UIWindow *window =[AppDelegate appdelegate].window;
    
    [UIView animateWithDuration:1.0f animations:^{
        window.alpha = 0;
        window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
    } completion:^(BOOL finished) {
        exit(0);
    }];
    
    
}
@end
