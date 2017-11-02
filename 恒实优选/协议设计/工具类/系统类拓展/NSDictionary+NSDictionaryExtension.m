//
//  NSDictionary+NSDictionaryExtension.m
//  装修项目管理
//
//  Created by mmxd on 16/12/7.
//  Copyright © 2016年 mmxd. All rights reserved.
//

#import "NSDictionary+NSDictionaryExtension.h"

@implementation NSDictionary (NSDictionaryExtension)

+(NSDictionary *)setJsonStr:(NSString *)jsonstr
{
    NSData *data = [jsonstr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary * dic =[NSJSONSerialization JSONObjectWithData:data
                                                        options:NSJSONReadingMutableContainers error:nil];
    
    return dic;
}


@end
