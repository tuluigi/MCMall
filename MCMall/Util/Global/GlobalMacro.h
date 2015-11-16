//
//  GlobalMacro.h
//  MCMall
//
//  Created by Luigi on 15/5/26.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#ifndef MCMall_GlobalMacro_h
#define MCMall_GlobalMacro_h

#define MCMallPageSize      10

#define MCMallDefaultImg    [UIImage imageNamed:@"loading_Default"]
#define MCMallThemeColor     [UIColor colorWithRed:255.0/255.0 green:92.0/255.0 blue:134.0/255.0 alpha:1.0]
#define SYSTEM_VERSION ([[[UIDevice currentDevice] systemVersion] doubleValue])
#pragma mark - Notification
#define UserLoginSucceedNotification @"UserLoginSucceedNotification"
#define UserLogoutSucceedNotification @"UserLogoutSucceedNotification"

#define MCMallTimerTaskNotification @"MCMallTimerTaskNotification"

typedef void(^DidUserLoginCompletionBlock)(BOOL isSucceed,NSString *userID);

#define OCCOMMONSCALE (([UIScreen mainScreen].bounds.size.width)/375.0f) 
#define SCREEN_WIDTH     ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)
#ifndef StringNotNil
#define StringNotNil(str) ((str)==nil?@"":str)
#endif
typedef NS_ENUM(NSInteger, MCMallNotificationType) {
    MCMallNotificationTypeActivityCommon      =1,//普通
    MCMallNotificationTypeActivityVote        =3 ,//投票
    MCMallNotificationTypeActivityApply       =2,//报名
     MCMallNotificationTypeActivityPicture    =4,//图片活动
    MCMallNotificationTypeGoods               =5,//商品推送
};
typedef NS_ENUM(NSInteger,MCMallClientType) {
    MCMallClientTypeBaiJiaXin     =10,
    MCMallClientTypeBaoBeiEJia    ,
    MCMallClientTypeAiYingBao     ,
    MCMallClientTypeHaiTunBeiBei   ,
    MCMallClientTypeYingZiGu       ,
    MCMallClientTypeMiaoQiMuYing    ,
};

typedef NS_ENUM(NSInteger,MCVipGoodsItemTag) {
    MCVipGoodsItemTagTimeLimitedSales=1,//限时抢购
    MCVipGoodsItemTagImmediatelySend   =2,//及时送达
    MCVipGoodsItemTagGroupMother       =3,//妈妈团
    MCVipGoodsItemTagGroupDiscountGoods =4,//会生活列表
};
#endif
