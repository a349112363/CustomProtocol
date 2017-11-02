//
//  NSDate+NSDateExtension.m
//  装修项目管理
//
//  Created by mmxd on 17/1/17.
//  Copyright © 2017年 mmxd. All rights reserved.
//

#import "NSDate+NSDateExtension.h"

@implementation NSDate (NSDateExtension)

/**
 *  比较当前时间得到相差的年 月 日
 *
 *  @param currentDate 传入的时间
 *
 *  @return 返回比较后的时间
 */
-(NSDateComponents *)dateFrom:(NSDate *)currentDate
{
    NSCalendar * calendar =[NSCalendar currentCalendar];
    NSCalendarUnit  unit =NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents * cmps =[calendar components:unit fromDate:currentDate toDate:self options:0];
    
    return cmps;
}



/**
 *  得到传入时间的年月日
 *
 *  @param currentDate 传入的时间
 *
 *  @return 返回传入时间的年月日
 */
-(NSDateComponents *)ComponentsdateFrom:(NSDate *)currentDate
{
    NSCalendar * calendar =[NSCalendar currentCalendar];
    NSCalendarUnit  unit =NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *comps =[calendar components:unit fromDate:currentDate];
    return comps;
}

/**
 *  获取当前出入时间对应的星期
 *
 *  @param currentDate 当前传入时间
 *
 *  @return 返回星期
 */
-(NSInteger)getNowWeekday:(NSDate *)currentDate
{
    NSCalendar * calendar =[NSCalendar currentCalendar];
    
    NSCalendarUnit  unit =NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday;
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSDateComponents *comps =[calendar components:unit fromDate:currentDate];
    //0 - 6 星期天 - 星期六
    return comps.weekday - 1;
}

//当前时区
- (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    
    return destinationDateNow;
}

//这个第几天
- (NSInteger)day:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components day];
}

//第几月
- (NSInteger)month:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components month];
}

//年份
- (NSInteger)year:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components year];
}

//这个月的第一天是周几
- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:2];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    
    return firstWeekday-1;
}



//这个月有几天
- (NSInteger)totaldaysInMonth:(NSDate *)date{
    NSRange daysInLastMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInLastMonth.length;
}

//第几个月的当前时间
- (NSDate *)lastMonth:(NSDate *)date andindex:(NSInteger)indexMonth{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = indexMonth;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}
//返回当前时区 自定义格式时间
-(NSDate *)setDateTimeZone:(NSString *)dateStr andFormatter:(NSString *)matter
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"CET"]];
    [calendar setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:+28800]];
    // NSDateFormatter 设置时区
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置时区，设置为 GMT
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [formatter setDateFormat:matter];//设定时间格式,这里可以设置成自己需要的格式
    
    NSDate * date =[formatter dateFromString:dateStr];
    
    
    return  date;
}

-(NSDate *)setDateTimeZone:(NSString *)dateStr
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"CET"]];
    [calendar setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:+28800]];
    // NSDateFormatter 设置时区
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置时区，设置为 GMT
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [formatter setDateFormat:@"yyyy-MM"];//设定时间格式,这里可以设置成自己需要的格式
    
    NSDate * date =[formatter dateFromString:dateStr];
    
    
    return  date;
}
@end
