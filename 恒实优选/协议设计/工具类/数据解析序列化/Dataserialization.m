//
//  Dataserialization.m
//  装修项目管理
//
//  Created by mmxd on 16/12/28.
//  Copyright © 2016年 mmxd. All rights reserved.
//

#import "Dataserialization.h"

@implementation Dataserialization

+(id)JSONObjectWithData:(NSString *)str
{
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];

     id json =[NSJSONSerialization JSONObjectWithData:data
                                                     options:NSJSONReadingMutableContainers error:nil];
    
    return json;
}
@end
