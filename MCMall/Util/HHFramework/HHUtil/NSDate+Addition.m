//
//  NSDate+HW.m
//  StringDemo
//
//  Created by  on 12-10-11.
//  Copyright (c) 2012年 wsk. All rights reserved.
//

#import "NSDate+Addition.h"
#import "NSDateFormatter+Addititon.h"
#define D_MINUTE	60
#define D_HOUR		3600
#define D_DAY		86400
#define D_WEEK		604800
#define D_YEAR		31556926
#define DATE_COMPONENTS (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]
@implementation NSDate (Addition)
-(NSString *)stringDateByHHSoftDefaultFormate{
    NSDate *aDate=self;
    if (aDate) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
        NSString *dateStr = [dateFormatter stringFromDate:aDate];
        return dateStr;
    }else{
        return nil;
    }
}
- (NSString *)convertDateToStringWithFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
//    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
//    [dateFormatter setTimeZone:timeZone];
    NSString *dateStr = [dateFormatter stringFromDate:self];
    return dateStr;
}

- (NSDate *)convertStringToDate:(NSString *)string format:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateFormat:format];
//    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
//    [dateFormatter setTimeZone:timeZone];
    NSDate *date = [dateFormatter dateFromString:string];
    return date;
}

/*距离当前的时间间隔描述*/
- (NSString *)timeIntervalDescription
{
    NSTimeInterval timeInterval = -[self timeIntervalSinceNow];
    if (timeInterval < 60) {
        return @"1分钟内";
    } else if (timeInterval < 3600) {
        return [NSString stringWithFormat:@"%.f分钟前", timeInterval / 60];
    } else if (timeInterval < 86400) {
        return [NSString stringWithFormat:@"%.f小时前", timeInterval / 3600];
    } else if (timeInterval < 2592000) {//30天内
        return [NSString stringWithFormat:@"%.f天前", timeInterval / 86400];
    } else if (timeInterval < 31536000) {//30天至1年内
        NSDateFormatter *dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"M月d日"];
        return [dateFormatter stringFromDate:self];
    } else {
        return [NSString stringWithFormat:@"%.f年前", timeInterval / 31536000];
    }
}

/*精确到分钟的日期描述*/
- (NSString *)minuteDescription
{
    NSDateFormatter *dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"yyyy-MM-dd"];
    
    NSString *theDay = [dateFormatter stringFromDate:self];//日期的年月日
    NSString *currentDay = [dateFormatter stringFromDate:[NSDate date]];//当前年月日
    if ([theDay isEqualToString:currentDay]) {//当天
        [dateFormatter setDateFormat:@"ah:mm"];
        return [dateFormatter stringFromDate:self];
    } else if ([[dateFormatter dateFromString:currentDay] timeIntervalSinceDate:[dateFormatter dateFromString:theDay]] == 86400) {//昨天
        [dateFormatter setDateFormat:@"ah:mm"];
        return [NSString stringWithFormat:@"昨天 %@", [dateFormatter stringFromDate:self]];
    } else if ([[dateFormatter dateFromString:currentDay] timeIntervalSinceDate:[dateFormatter dateFromString:theDay]] < 86400 * 7) {//间隔一周内
        [dateFormatter setDateFormat:@"EEEE ah:mm"];
        return [dateFormatter stringFromDate:self];
    } else {//以前
        [dateFormatter setDateFormat:@"yyyy-MM-dd ah:mm"];
        return [dateFormatter stringFromDate:self];
    }
}




@end
