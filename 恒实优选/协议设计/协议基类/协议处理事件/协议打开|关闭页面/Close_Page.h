//
//  Close_Page.h
//  装修项目管理
//
//  Created by mmxd on 16/12/6.
//  Copyright © 2016年 mmxd. All rights reserved.
//

#import "ProtocolClass.h"

@interface Close_Page : ProtocolClass

//通过反射查找到类属性进行赋值 来进行js回调
@property (nonatomic,strong)NSString * jscallback;

@end
