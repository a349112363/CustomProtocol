//
//  Tool_SetNavgationBar.h
//  恒实珠宝
//
//  Created by 邱凡Bookpro on 2017/9/4.
//  Copyright © 2017年 hszb. All rights reserved.
//

#import "ProtocolClass.h"

@interface Tool_SetNavgationBar : ProtocolClass

@property (nonatomic,copy) NSString * navgationbarcolor; //设置下一个页面的头部背景颜色

@property (nonatomic,assign) BOOL isslide;//是否侧滑 true 可以策划  false 不能侧滑

@property (nonatomic,assign) BOOL istransparent; //判断头部是否透明



@end
