//
//  MCMallAPI.m
//  MCMall
//
//  Created by Luigi on 15/6/4.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "MCMallAPI.h"
NSString *const SufferName  =@"ws/";
NSString *const DomainPath  =@"http://120.25.152.224:8080/muying/";
@interface MCMallAPI ()

@end

@implementation MCMallAPI
+(NSString *)domainPath{
    return DomainPath;
}
#pragma mark - 个人中心
+(NSString *)userLoginAPI{
    return [[DomainPath stringByAppendingString:SufferName] stringByAppendingString:@"login"];
}
+(NSString *)userRegisterAPI{
    return [[DomainPath stringByAppendingString:SufferName] stringByAppendingString:@"register"];
}
+(NSString *)userEditPwdAPI{
    return [[DomainPath stringByAppendingString:SufferName] stringByAppendingString:@"changepassoword"];
}
+(NSString *)getUserPhoneVerfiyCodeAPI{
    return [[DomainPath stringByAppendingString:SufferName] stringByAppendingString:@"sendcode"];
}
+(NSString *)checkVersionUpdateAPI{
    return [[DomainPath stringByAppendingString:SufferName] stringByAppendingString:@"autpupdate"];
}
+(NSString *)getUserInfoAPI{
    return [[DomainPath stringByAppendingString:SufferName] stringByAppendingString:@"getuserinfo"];
}
+(NSString *)editUserInfoAPI{
    return [[DomainPath stringByAppendingString:SufferName] stringByAppendingString:@"perfect"];
}
+(NSString *)uploadUserHeadImageAPI{
return [[DomainPath stringByAppendingString:SufferName] stringByAppendingString:@"upload"];
}
#pragma mark -活动
//活动列表
+(NSString *)getActivityListAPI{
    return [[DomainPath stringByAppendingString:SufferName] stringByAppendingString:@"getactivitylist"];
}
//获取活动详情
+(NSString *)getActivityDetailAPI{
    return [[DomainPath stringByAppendingString:SufferName] stringByAppendingString:@"getactivityinfo"];
}
//投票
+(NSString *)voteActivityAPI{
    return [[DomainPath stringByAppendingString:SufferName] stringByAppendingString:@"suffrage"];
}
//报名
+(NSString *)applyActivityAPI{
return [[DomainPath stringByAppendingString:SufferName] stringByAppendingString:@"enroll"];
}
//评论
+(NSString *)publishCommontActivityAPI{
    return [[DomainPath stringByAppendingString:SufferName] stringByAppendingString:@"replyphoto"];
}
//获取评论列表
+(NSString *)getPhotoCommonsListAPI{
    return [[DomainPath stringByAppendingString:SufferName] stringByAppendingString:@"getreplylist"];
}
//点赞
+(NSString *)favorPhotoAPI{
    return [[DomainPath stringByAppendingString:SufferName] stringByAppendingString:@"praise"];
}
+(NSString *)uploadActivityPhotoAPI{
    return [[DomainPath stringByAppendingString:SufferName] stringByAppendingString:@"updphoto"];
}
@end
