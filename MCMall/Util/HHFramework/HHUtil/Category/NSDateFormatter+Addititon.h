//
//  NSDateFormatter+Addititon.h
//  HHFrameWorkKit
//
//  Created by Luigi on 14-11-14.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (Addititon)
+ (id)dateFormatter;
+ (id)dateFormatterWithFormat:(NSString *)dateFormat;

+ (id)defaultDateFormatter;/*yyyy-MM-dd HH:mm:ss*/
@end
