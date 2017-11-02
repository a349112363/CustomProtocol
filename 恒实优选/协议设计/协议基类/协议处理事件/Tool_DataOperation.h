//
//  Tool_DataOperation.h
//  恒实珠宝
//
//  Created by 邱凡Bookpro on 2017/9/4.
//  Copyright © 2017年 hszb. All rights reserved.
//

#import "ProtocolClass.h"

@interface Tool_DataOperation : ProtocolClass

@property (nonatomic,copy) NSString * type;

@property (nonatomic,strong) NSString * filename;

@property (nonatomic,strong) id data;


@end
