//
//  SubUI_Dialogview.h
//  装修项目管理
//
//  Created by mmxd on 17/1/11.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewController.h"

@interface SubUI_Dialogview : UIView<UIWebViewDelegate>

@property (nonatomic,strong) NSString * menueJson;

@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * titlefontsize;
@property (nonatomic,copy) NSString * titlecolor;
@property (nonatomic,copy) NSString * content;
@property (nonatomic,copy) NSString * contentfontsize;
@property (nonatomic,copy) NSString * contentcolor;
@property (nonatomic,copy) NSString * dialogbackcolor;

@property (nonatomic,assign) BOOL  closeable;

@property (nonatomic,strong) WebViewController * vc;

@property (nonatomic,strong) NSMutableArray * DialogButtonData;


-(id)initWithFrame:(CGRect)frame vc:(WebViewController *)vc;

-(void)setMenueListValue;

@end



/******** SubUI_DialogButtonModel ***********/


@interface SubUI_DialogButtonModel : NSObject

@property (nonatomic,copy) NSString * tag;
@property (nonatomic,copy) NSString * text;
@property (nonatomic,copy) NSString * textColor;
@property (nonatomic,copy) NSString * fontsize;
@property (nonatomic,copy) NSString * backColor;
@property (nonatomic,copy) NSString * eventString;

@end


/*****SubUI_DialogButtonModel*********/
