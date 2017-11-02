//
//  Open_HTML.h
//  装修项目管理
//
//  Created by mmxd on 16/12/7.
//  Copyright © 2016年 mmxd. All rights reserved.
//

#import "ProtocolClass.h"

@interface Open_HTML : ProtocolClass

//打开页面后 对页面头部设置初始化
@property (nonatomic,strong)NSString * initwebview;

//如果它工作在iPhone 5S和更高好像32/64位的问题，因为自从5S所有的iPhone都是64位。更确切地说对于32位系统BOOL是一个signed char，而在64位这是一个bool
@property (nonatomic,assign) bool isslide;//是否侧滑

@property (nonatomic,assign) bool istransparent; //判断头部是否透明


//设置导航条背景色
@property (nonatomic,strong) NSString * headbackgroundcolor;
@end
