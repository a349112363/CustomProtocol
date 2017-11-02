//
//  Tool_Cache.h
//  装修项目管理
//
//  Created by mmxd on 17/1/13.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomTool_Cache : NSObject

/**
 *  保存偏好设置数据
 *
 *  @param obj 保存对象
 *  @param key 对应的key
 */
+(void)appSetUserDefaults:(NSObject *)obj andKey:(NSString *)key;
/**
 *  取出偏好设置数据
 *
 *  @param key 对应key
 *
 *  @return 返回取出对象
 */
+(id)appObjUserDefault:(NSString *)key;

/**
 *  删除偏好设置
 *
 *  @param key 对应key
 */
+(void)removeObjectForKey:(NSString *)key;




/**
 *  归档
 *
 *  @param obj  需要归档的类
 *  @param key  归档key
 *  @param path 归档路劲
 *
 *  @return YES表示归档成功，NO表示归档失败
 */
+(BOOL)keyedArchiver:(id)obj key:(NSString *)key path:(NSString *)path;



/**
 *  解档
 *
 *  @param key  解档key
 *  @param path 解档路径
 *
 *  @return 解析的结果
 */
+(id)keyedUnarchiver:(NSString *)key path:(NSString *)path;


/**
 *  删除某个文件
 *
 *  @param path 删除文件路径
 *
 *  @return 返回删除状态 成功 或者 失败
 */
+(BOOL)removeArchiver:(NSString *)path;

@end
