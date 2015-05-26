//
//  HHFrameWorkSetting.m
//  HHFrameWorkKit
//
//  Created by Luigi on 14-12-15.
//  Copyright (c) 2014年 luigi. All rights reserved.
//
#define kHHFrameWorkSettingOpenLog      @"HHNetWorkEngineOPENDELOG"
#import "HHFrameWorkSetting.h"

@implementation HHFrameWorkSetting
/**
 设置是否打开log输出，默认不打开，如果打开的话可以看到此sdk网络或者其他操作，有利于调试
 
 @param openLog 是否打开log输出
 
 */
+ (void)openLog:(BOOL)openLog{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    [userDefault setBool:openLog forKey:kHHFrameWorkSettingOpenLog];
}
    //是否支持打印信息
+(BOOL)enableDebugLog{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    return [userDefault boolForKey:kHHFrameWorkSettingOpenLog];
}
@end
