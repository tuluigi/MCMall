//
//  NSDate+HW.h
//  StringDemo
//
//

#import <Foundation/Foundation.h>

@interface NSDate (Addition)
    //将日期转化为以斜杠分开的时间格式
-(NSString *)stringDateByHHSoftDefaultFormate;
/**
 *  将日期转化为字符串。
 *  @param  format:转化格式，形如@"yyyy年MM月dd日hh时mm分ss秒"。
 *  return  返回转化后的字符串。
 */
- (NSString *)convertDateToStringWithFormat:(NSString *)format;

/**
 *  将字符串转化为日期。
 *  @param  string:给定的字符串日期。
 *  @param  format:转化格式，形如@"yyyy年MM月dd日hh时mm分ss秒"。日期格式要和string格式一致，否则会为空。
 *  return  返回转化后的日期。
 */
- (NSDate *)convertStringToDate:(NSString *)string format:(NSString *)format;

- (NSString *)timeIntervalDescription;//距离当前的时间间隔描述

@end
