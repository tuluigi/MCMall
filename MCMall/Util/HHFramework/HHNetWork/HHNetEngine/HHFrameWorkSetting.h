//
//  HHFrameWorkSetting.h
//  HHFrameWorkKit
//
//  Created by Luigi on 14-12-15.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHFrameWorkSetting : NSObject
/**
 设置是否打开log输出，默认不打开，如果打开的话可以看到此sdk网络或者其他操作，有利于调试
 @param openLog 是否打开log输出
 */
+ (void)openLog:(BOOL)openLog;

//是否支持打印信息,default is NO
+(BOOL)enableDebugLog;
@end
