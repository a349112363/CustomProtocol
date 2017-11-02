//
//  QFalertView.h
//  guoJiaJia
//
//  Created by mmxd on 16/8/16.
//  Copyright © 2016年 mmxd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QFalertView : UIView

/*
 *弹框view
 */
@property (nonatomic,strong)UIView * alertView;


/*
 *弹框提示标题
 */
@property (nonatomic,strong)UILabel * titleLabel;

/*
 *弹框提示内容
 */
@property (nonatomic,strong)UILabel * messageLabel;

/*
 *弹框确定按钮
 */
@property (nonatomic,strong)UIButton * sureBtn;

/*
 *弹框取消按钮
 */
@property (nonatomic,strong)UIButton * cancelBtn;

/*是否强制更新*/
@property (nonatomic,assign)BOOL isUpdate;

/*
 *更新内容
 */
@property (nonatomic,copy) NSString * messageStr;

/*
 *更新跳转url
 */
@property (nonatomic,copy) NSString * url;

-(void)viewShow;
@end
