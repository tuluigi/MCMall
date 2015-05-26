//
//  UserModel.m
//  MCMall
//
//  Created by Luigi on 15/5/20.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "UserModel.h"
NSString *const MCMall_UserID       =@"MCMall_UserID";
NSString *const MCMall_UserName     =@"MCMall_UserName";
NSString *const MCMall_UserHeadUrl  =@"MCMall_UserHeadUrl";
NSString *const MCMall_UserAmount   =@"MCMall_UserHeadUrl";
NSString *const MCMall_MerchantName   =@"MCMall_MerchantName";
@implementation UserModel
+(NSString *)userID{
    NSString *userID=[[NSUserDefaults standardUserDefaults]  objectForKey:MCMall_UserID];
    return userID;
}
+(BOOL)isLogin{
    NSString *userID=[UserModel userID];
    if (userID&&userID.length) {
        return YES;
    }else{
        return NO;
    }
}
@end
