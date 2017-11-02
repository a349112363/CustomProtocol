//
//  Tool_TabBar.h
//  装修项目管理
//
//  Created by mmxd on 17/2/8.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import "ProtocolClass.h"

@interface Tool_TabBar : ProtocolClass

//显示在对应的item上
@property (nonatomic,copy) NSString * itemindex;
//显示的数字
@property (nonatomic,copy) NSString * number;
//是否显示 yes 显示 no 不显示
@property (nonatomic,assign)bool status;

@end
