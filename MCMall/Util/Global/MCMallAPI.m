//
//  MCMallAPI.m
//  MCMall
//
//  Created by Luigi on 15/6/4.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "MCMallAPI.h"
NSString *const SufferName  =@"/muying/ws/";

@interface MCMallAPI ()

@end

@implementation MCMallAPI
+(NSString *)prefixPath{
    return [[HHGlobalVarTool domainPath] stringByAppendingString:SufferName];
}
#pragma mark - 个人中心
+(NSString *)getUserPointAPI{
    return [[[HHGlobalVarTool domainPath] stringByAppendingString:SufferName] stringByAppendingString:@"getpoint"];
}
+(NSString *)changeStateAPI{
    return [[[HHGlobalVarTool domainPath] stringByAppendingString:SufferName] stringByAppendingString:@"choice"];
}
+(NSString *)userLoginAPI{
    return [[[HHGlobalVarTool domainPath] stringByAppendingString:SufferName] stringByAppendingString:@"login"];
}
+(NSString *)userRegisterAPI{
    return [[[HHGlobalVarTool domainPath] stringByAppendingString:SufferName] stringByAppendingString:@"register"];
}
+(NSString *)userEditPwdAPI{
    return [[[HHGlobalVarTool domainPath] stringByAppendingString:SufferName] stringByAppendingString:@"changepassword"];
}
+(NSString *)getUserPhoneVerfiyCodeAPI{
    return [[[HHGlobalVarTool domainPath] stringByAppendingString:SufferName] stringByAppendingString:@"sendcode"];
}
+(NSString *)checkVersionUpdateAPI{
    return [[[HHGlobalVarTool domainPath] stringByAppendingString:SufferName] stringByAppendingString:@"autoupdate"];
}
+(NSString *)getUserInfoAPI{
    return [[[HHGlobalVarTool domainPath] stringByAppendingString:SufferName] stringByAppendingString:@"getuserinfo"];
}
+(NSString *)editUserInfoAPI{
    return [[[HHGlobalVarTool domainPath] stringByAppendingString:SufferName] stringByAppendingString:@"perfect"];
}
+(NSString *)uploadUserHeadImageAPI{
return [[[HHGlobalVarTool domainPath] stringByAppendingString:SufferName] stringByAppendingString:@"upload"];
}

+(NSString *)newAddressAPI{
    return [[[HHGlobalVarTool domainPath] stringByAppendingString:SufferName] stringByAppendingString:@"newaddress"];
}

+(NSString *)getAddressListAPI{
    return [[[HHGlobalVarTool domainPath] stringByAppendingString:SufferName] stringByAppendingString:@"getaddress"];
}

+(NSString *)deleteAddresssAPI{
    return [[[HHGlobalVarTool domainPath] stringByAppendingString:SufferName] stringByAppendingString:@"deladdress"];
}

+(NSString *)getDefaultAddressAPI{
  return [[[HHGlobalVarTool domainPath] stringByAppendingString:SufferName] stringByAppendingString:@"getdefaddr"];
}
//获取配送员列表
+(NSString *)getSalesListAPI{
    return [[[HHGlobalVarTool domainPath] stringByAppendingString:SufferName] stringByAppendingString:@"getsaleslist"];
}
//获取我的预定列表
+(NSString *)getOrderListAPI{
    return [[[HHGlobalVarTool domainPath] stringByAppendingString:SufferName] stringByAppendingString:@"myorder"];
}
#pragma mark -活动
//活动列表
+(NSString *)getActivityListAPI:(BOOL)isSelf{
    if (isSelf) {
        return [[[HHGlobalVarTool domainPath] stringByAppendingString:SufferName] stringByAppendingString:@"getselfactivitylist"];
    }else{
        return [[[HHGlobalVarTool domainPath] stringByAppendingString:SufferName] stringByAppendingString:@"getactivitylist"];
    }
}
//获取活动详情
+(NSString *)getActivityDetailAPI{
    return [[[HHGlobalVarTool domainPath] stringByAppendingString:SufferName] stringByAppendingString:@"getactivityinfo"];
}
//投票
+(NSString *)voteActivityAPI{
    return [[[HHGlobalVarTool domainPath] stringByAppendingString:SufferName] stringByAppendingString:@"suffrage"];
}
//报名
+(NSString *)applyActivityAPI{
return [[[HHGlobalVarTool domainPath] stringByAppendingString:SufferName] stringByAppendingString:@"enroll"];
}
//评论
+(NSString *)publishCommontActivityAPI{
    return [[[HHGlobalVarTool domainPath] stringByAppendingString:SufferName] stringByAppendingString:@"replyphoto"];
}
//获取评论列表
+(NSString *)getPhotoCommonsListAPI{
    return [[[HHGlobalVarTool domainPath] stringByAppendingString:SufferName] stringByAppendingString:@"getreplylist"];
}
//点赞
+(NSString *)favorPhotoAPI{
    return [[[HHGlobalVarTool domainPath] stringByAppendingString:SufferName] stringByAppendingString:@"praise"];
}
+(NSString *)uploadActivityPhotoAPI{
    return [[[HHGlobalVarTool domainPath] stringByAppendingString:SufferName] stringByAppendingString:@"updphoto"];
}
#pragma mark -主题
//专家问答主题列表
+(NSString *)getSubjectListAPI{
return [[[HHGlobalVarTool domainPath] stringByAppendingString:SufferName] stringByAppendingString:@"speciallist"];
}
//专家问答详情
+(NSString *)getSubjectDetailAPI{
return [[[HHGlobalVarTool domainPath] stringByAppendingString:SufferName] stringByAppendingString:@"specialinfo"];
}
//专家问答详情
+(NSString *)askSubjectQuestionAPI{
    return [[[HHGlobalVarTool domainPath] stringByAppendingString:SufferName] stringByAppendingString:@"ask"];
}

#pragma mark -商品部分
+(NSString *)getGoodsClassAPI{
 return [[[HHGlobalVarTool domainPath] stringByAppendingString:SufferName] stringByAppendingString:@"getcategories"];
}
+(NSString *)getGoodsListAPI{
 return [[[HHGlobalVarTool domainPath] stringByAppendingString:SufferName] stringByAppendingString:@"vipgo"];
}
+(NSString *)getGoodsDetailAPI{
 return [[[HHGlobalVarTool domainPath] stringByAppendingString:SufferName] stringByAppendingString:@"getadvgoodsinfo"];
}
+(NSString *)bookGoodsAPI{
 return [[[HHGlobalVarTool domainPath] stringByAppendingString:SufferName] stringByAppendingString:@"scheduled"];
}
#pragma mark -日记部分
+(NSString *)userSignInAPI{//用户签到
    return [[[HHGlobalVarTool domainPath] stringByAppendingString:SufferName] stringByAppendingString:@"sign"];
}
+(NSString *)getUserSignListAPI{//用户签到列表
    return [[[HHGlobalVarTool domainPath] stringByAppendingString:SufferName] stringByAppendingString:@"getsignlist"];
}


+(NSString *)getBabyPothoListAPI{//获取babay照片列表
    return [[[HHGlobalVarTool domainPath] stringByAppendingString:SufferName] stringByAppendingString:@"getbabylist"];
}
+(NSString *)editBabyPhotoAPI{//修改照片
    return [[[HHGlobalVarTool domainPath] stringByAppendingString:SufferName] stringByAppendingString:@"moditext"];
}
+(NSString *)uploadBabyPhotoAPI{//修改照片
    return [[[HHGlobalVarTool domainPath] stringByAppendingString:SufferName] stringByAppendingString:@"upbabyphoto"];
}
+(NSString *)deleteBabyPhotoDiaryAPI{//删除日记
    return [[[HHGlobalVarTool domainPath] stringByAppendingString:SufferName] stringByAppendingString:@"delbabyphoto"];
}

#pragma mark- 广告
+(NSString *)getADListAPI{//获取广告列表
      return [[[HHGlobalVarTool domainPath] stringByAppendingString:SufferName] stringByAppendingString:@"getadvertlist"];
}
@end
