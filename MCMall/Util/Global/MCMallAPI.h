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
+(NSString *)getUserPointAPI;
+(NSString *)changeStateAPI;
+(NSString *)userLoginAPI;
+(NSString *)userRegisterAPI;
+(NSString *)userEditPwdAPI;
+(NSString *)getUserPhoneVerfiyCodeAPI;
+(NSString *)checkVersionUpdateAPI;
+(NSString *)getUserInfoAPI;
+(NSString *)editUserInfoAPI;
+(NSString *)uploadUserHeadImageAPI;

+(NSString *)newAddressAPI;
+(NSString *)getAddressListAPI;
+(NSString *)deleteAddresssAPI;
+(NSString *)getDefaultAddressAPI;
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
//专家问答详情
+(NSString *)askSubjectQuestionAPI;

#pragma mark -商品部分
+(NSString *)getGoodsClassAPI;
+(NSString *)getGoodsListAPI;
+(NSString *)getGoodsDetailAPI;
+(NSString *)bookGoodsAPI;//预定

#pragma mark -日记部分
+(NSString *)userSignInAPI;//用户签到
+(NSString *)getUserSignListAPI;//签到列表
+(NSString *)userPublishDiaryAPI;//写日记
+(NSString *)getDiraryDetailAPI;//获取日记列表
#pragma mark- 广告
+(NSString *)getADListAPI;//获取广告列表
@end
