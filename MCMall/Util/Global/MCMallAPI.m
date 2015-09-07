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
//NSString *const DomainPath  =@"http://100.64.35.43:8080/BasePJ/";
@interface MCMallAPI ()

@end

@implementation MCMallAPI
+(NSString *)domainPath{
    return DomainPath;
}
#pragma mark - 个人中心
+(NSString *)getUserPointAPI{
    return [[DomainPath stringByAppendingString:SufferName] stringByAppendingString:@"getpoint"];
}
+(NSString *)changeStateAPI{
    return [[DomainPath stringByAppendingString:SufferName] stringByAppendingString:@"choice"];
}
+(NSString *)userLoginAPI{
    return [[DomainPath stringByAppendingString:SufferName] stringByAppendingString:@"login"];
}
+(NSString *)userRegisterAPI{
    return [[DomainPath stringByAppendingString:SufferName] stringByAppendingString:@"register"];
}
+(NSString *)userEditPwdAPI{
    return [[DomainPath stringByAppendingString:SufferName] stringByAppendingString:@"changepassword"];
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

+(NSString *)newAddressAPI{
    return [[DomainPath stringByAppendingString:SufferName] stringByAppendingString:@"newaddress"];
}

+(NSString *)getAddressListAPI{
    return [[DomainPath stringByAppendingString:SufferName] stringByAppendingString:@"getaddress"];
}

+(NSString *)deleteAddresssAPI{
    return [[DomainPath stringByAppendingString:SufferName] stringByAppendingString:@"deladdress"];
}

+(NSString *)getDefaultAddressAPI{
  return [[DomainPath stringByAppendingString:SufferName] stringByAppendingString:@"getdefaddr"];
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
#pragma mark -主题
//专家问答主题列表
+(NSString *)getSubjectListAPI{
return [[DomainPath stringByAppendingString:SufferName] stringByAppendingString:@"speciallist"];
}
//专家问答详情
+(NSString *)getSubjectDetailAPI{
return [[DomainPath stringByAppendingString:SufferName] stringByAppendingString:@"specialinfo"];
}
//专家问答详情
+(NSString *)askSubjectQuestionAPI{
    return [[DomainPath stringByAppendingString:SufferName] stringByAppendingString:@"ask"];
}

#pragma mark -商品部分
+(NSString *)getGoodsClassAPI{
 return [[DomainPath stringByAppendingString:SufferName] stringByAppendingString:@"getcategories"];
}
+(NSString *)getGoodsListAPI{
 return [[DomainPath stringByAppendingString:SufferName] stringByAppendingString:@"vipgo"];
}
+(NSString *)getGoodsDetailAPI{
 return [[DomainPath stringByAppendingString:SufferName] stringByAppendingString:@"getadvgoodsinfo"];
}
+(NSString *)bookGoodsAPI{
 return [[DomainPath stringByAppendingString:SufferName] stringByAppendingString:@"scheduled"];
}
#pragma mark -日记部分
+(NSString *)userSignInAPI{//用户签到
    return [[DomainPath stringByAppendingString:SufferName] stringByAppendingString:@"sign"];
}
+(NSString *)getUserSignListAPI{//用户签到列表
    return [[DomainPath stringByAppendingString:SufferName] stringByAppendingString:@"getsignlist"];
}
+(NSString *)userPublishDiaryAPI{//写日记
    return [[DomainPath stringByAppendingString:SufferName] stringByAppendingString:@"diary"];
}

+(NSString *)getDiraryDetailAPI{//获取日记详情
    return [[DomainPath stringByAppendingString:SufferName] stringByAppendingString:@"getdiaryinfo"];
}
#pragma mark- 广告
+(NSString *)getADListAPI{//获取广告列表
      return [[DomainPath stringByAppendingString:SufferName] stringByAppendingString:@"getadvertlist"];
}
@end
