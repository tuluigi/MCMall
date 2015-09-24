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

 NSString * MCMallShopID;
 NSString *MCMallShopName;
#endif
