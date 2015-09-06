//
//  NSDateFormatter+Addititon.m
//  HHFrameWorkKit
//
//  Created by Luigi on 14-11-14.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import "NSDateFormatter+Addititon.h"

@implementation NSDateFormatter (Addititon)
+ (id)dateFormatter
{
    return [[self alloc] init];
}

+ (id)dateFormatterWithFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[self alloc] init];
    dateFormatter.dateFormat = dateFormat;
    return dateFormatter;
}

+ (id)defaultDateFormatter
{
    return [self dateFormatterWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}
@end
