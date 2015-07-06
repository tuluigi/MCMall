//
//  MCMallAPI.h
//  MCMall
//
//  Created by Luigi on 15/6/4.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCMallAPI : NSObject
+(NSString *)domainPath;

#pragma mark - 个人中心
+(NSString *)userLoginAPI;
+(NSString *)userRegisterAPI;
+(NSString *)userEditPwdAPI;

#pragma mark -活动
+(NSString *)getActivityListAPI;
//获取活动详情
+(NSString *)getActivityDetailAPI;
//投票
+(NSString *)voteActivityAPI;
//报名
+(NSString *)applyActivityAPI;
+(NSString *)publishActivityAPI;
@end
