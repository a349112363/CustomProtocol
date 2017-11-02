//
//  NSDate+NSDateExtension.h
//  装修项目管理
//
//  Created by mmxd on 17/1/17.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (NSDateExtension)

/**
 *  时间进行比较 比较时分秒
 *
 *  @param currentDate 传入需要跟当前时间进行比较的时间
 *
 *  @return NSDateComponents
 */
-(NSDateComponents *)dateFrom:(NSDate *)currentDate;


-(NSDateComponents *)ComponentsdateFrom:(NSDate *)currentDate;
/**
 *  获取当前出入时间对应的星期
 *
 *  @param currentDate 当前传入时间
 *
 *  @return 返回星期
 */
-(NSInteger)getNowWeekday:(NSDate *)currentDate;

- (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate;



//这个月的天数
- (NSInteger)day:(NSDate *)date;

//第几月
- (NSInteger)month:(NSDate *)date;

//年份
- (NSInteger)year:(NSDate *)date;

//这个月的第一天是周几
- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date;

//这个月有几天
- (NSInteger)totaldaysInMonth:(NSDate *)date;

//第几个月的当前时间
- (NSDate *)lastMonth:(NSDate *)date andindex:(NSInteger)indexMonth;

//自定义格式时间
-(NSDate *)setDateTimeZone:(NSString *)dateStr andFormatter:(NSString *)matter;

//固定格式的时间
-(NSDate *)setDateTimeZone:(NSString *)dateStr;
@end
