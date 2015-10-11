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

#pragma mark - Notification
#define UserLoginSucceedNotification @"UserLoginSucceedNotification"
#define UserLogoutSucceedNotification @"UserLogoutSucceedNotification"

#define MCMallTimerTaskNotification @"MCMallTimerTaskNotification"

typedef void(^DidUserLoginCompletionBlock)(BOOL isSucceed,NSString *userID);



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

NSString * MCMallShopID;
NSString *MCMallShopName;
NSString  *APNSKEY;
NSString *APNSSECRET;
#endif
