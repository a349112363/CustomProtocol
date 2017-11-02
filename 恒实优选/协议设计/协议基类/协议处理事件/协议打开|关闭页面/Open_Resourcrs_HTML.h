//
//  Open_Resourcrs_HTML.h
//  装修项目管理
//
//  Created by mmxd on 16/12/9.
//  Copyright © 2016年 mmxd. All rights reserved.
//

#import "ProtocolClass.h"

@interface Open_Resourcrs_HTML : ProtocolClass

//原生页面上按钮执行的事件
@property (nonatomic,strong) NSString * eventstring;

//打开页面后 对页面头部设置初始化
@property (nonatomic,strong)NSString * initwebview;

@property (nonatomic,assign) bool isslide;//是否侧滑

@property (nonatomic,assign) bool istransparent; //判断头部是否透明

//设置导航条背景色
@property (nonatomic,strong) NSString * headbackgroundcolor;

@property (nonatomic,assign) int currentindex;
/**
 *  通过协议参数赋值，得到图片集合,标识
 */
@property (nonatomic,strong) NSString * picturestr;


@property (nonatomic,strong) NSString * group;

@end
