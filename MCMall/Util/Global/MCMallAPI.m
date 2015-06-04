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
+(NSString *)getActivityListAPI{
    return [SufferName stringByAppendingString:@"getactivitylist"];
}
@end
