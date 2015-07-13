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
return [SufferName stringByAppendingString:@"enroll"];
}
//评论
+(NSString *)publishCommontActivityAPI{
    return [SufferName stringByAppendingString:@"replyphoto"];
}
//获取评论列表
+(NSString *)getPhotoCommonsListAPI{
    return [SufferName stringByAppendingString:@"getreplylist"];
}
//点赞
+(NSString *)favorPhotoAPI{
    return [SufferName stringByAppendingString:@"praise"];
}
+(NSString *)uploadActivityPhotoAPI{
    return [SufferName stringByAppendingString:@"updphoto"];
}
@end
