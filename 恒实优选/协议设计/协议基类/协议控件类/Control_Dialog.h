//
//  Control_Dialog.h
//  装修项目管理
//
//  Created by mmxd on 17/1/11.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import "ProtocolClass.h"
#import "SubUI_Dialogview.h"
@interface Control_Dialog : ProtocolClass




//声明弹框对象
@property (nonatomic,strong) SubUI_Dialogview * subDialog;

@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * titlefontsize;
@property (nonatomic,copy) NSString * titlecolor;

@property (nonatomic,copy) NSString * content;
@property (nonatomic,copy) NSString * contentfontsize;
@property (nonatomic,copy) NSString * contentcolor;

@property (nonatomic,copy) NSString * dialogbackcolor;

@property (nonatomic,assign) bool closeable;
//接收设置弹框参数
@property (nonatomic,copy)NSString * menus;

@end
