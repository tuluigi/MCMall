//
//  MCMallAPI.h
//  MCMall
//
//  Created by Luigi on 15/6/4.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCMallAPI : NSObject

#pragma mark - 个人中心
+(NSString *)domainPath;
+(NSString *)userLoginAPI;
+(NSString *)userRegisterAPI;
+(NSString *)userEditPwdAPI;
+(NSString *)getUserPhoneVerfiyCodeAPI;
+(NSString *)checkVersionUpdateAPI;
+(NSString *)getUserInfoAPI;
+(NSString *)editUserInfoAPI;
+(NSString *)uploadUserHeadImageAPI;
#pragma mark -活动
+(NSString *)getActivityListAPI;
//获取活动详情
+(NSString *)getActivityDetailAPI;
//投票
+(NSString *)voteActivityAPI;
//报名
+(NSString *)applyActivityAPI;
//发表评论
+(NSString *)publishCommontActivityAPI;
//获取评论列表
+(NSString *)getPhotoCommonsListAPI;
//点赞
+(NSString *)favorPhotoAPI;
//上传活动图片
+(NSString *)uploadActivityPhotoAPI;


#pragma mark -主题
//专家问答主题列表
+(NSString *)getSubjectListAPI;
//专家问答详情
+(NSString *)getSubjectDetailAPI;
@end
