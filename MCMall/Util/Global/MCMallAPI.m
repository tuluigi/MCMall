//
//  MCMallAPI.m
//  MCMall
//
//  Created by Luigi on 15/6/4.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "MCMallAPI.h"
NSString *const SufferName=@"muying/ws/";
@interface MCMallAPI ()

@end

@implementation MCMallAPI
+(NSString *)domainPath{
    return @"120.25.152.224:8080";
}

#pragma mark - 个人中心
+(NSString *)userLoginAPI{
    return [SufferName stringByAppendingString:@"login"];
}
+(NSString *)userRegisterAPI{
    return [SufferName stringByAppendingString:@"register"];
}
+(NSString *)userEditPwdAPI{
    return [SufferName stringByAppendingString:@"changepassoword"];
}

#pragma mark -活动
//活动列表
+(NSString *)getActivityListAPI{
    return [SufferName stringByAppendingString:@"getactivitylist"];
}
//获取活动详情
+(NSString *)getActivityDetailAPI{
    return [SufferName stringByAppendingString:@"getactivityinfo"];
}
//投票
+(NSString *)voteActivityAPI{
    return [SufferName stringByAppendingString:@"suffrage"];
}
//报名
+(NSString *)applyActivityAPI{
return [SufferName stringByAppendingString:@"getactivitylist"];
}
@end
