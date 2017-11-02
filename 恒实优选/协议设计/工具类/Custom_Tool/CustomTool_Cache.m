//
//  Tool_Cache.m
//  装修项目管理
//
//  Created by mmxd on 17/1/13.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import "CustomTool_Cache.h"

@implementation CustomTool_Cache

+(void)appSetUserDefaults:(NSObject *)obj andKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(id)appObjUserDefault:(NSString *)key
{
    id obj = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    return obj;
}

+(void)removeObjectForKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+(BOOL)keyedArchiver:(id)obj key:(NSString *)key path:(NSString *)path
{
    
    NSMutableData *tpData = [NSMutableData data];
    NSKeyedArchiver *keyedArchiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:tpData];
    [keyedArchiver encodeObject:obj forKey:key];
    [keyedArchiver finishEncoding];
    return [tpData writeToFile:path atomically:YES];
}

+(id)keyedUnarchiver:(NSString *)key path:(NSString *)path
{
    NSMutableData *tpData = [NSMutableData dataWithContentsOfFile:path];
    NSKeyedUnarchiver *keyedUnarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:tpData];
    return [keyedUnarchiver decodeObjectForKey:key];
}


+(BOOL)removeArchiver:(NSString *)path
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    NSError * error = nil;
    NSAssert(error == nil, @"删除出错");
    return  [fileManager removeItemAtPath:path error:&error];

}


@end
