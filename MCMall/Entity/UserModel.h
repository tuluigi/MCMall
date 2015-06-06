//
//  UserModel.h
//  MCMall
//
//  Created by Luigi on 15/5/20.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
@property(nonatomic,copy)NSString *userID;
@property(nonatomic,copy)NSString *userName;
@property(nonatomic,copy)NSString *userHeadUrl;
@property(nonatomic,copy)NSString *userTel;
@property(nonatomic,copy)NSDecimalNumber *userAmount;
@property(nonatomic,copy)NSString *shopID;
@property(nonatomic,copy)NSString *shopName;
+(UserModel *)userModelWithResponseDic:(NSDictionary *)dic;
+(UserModel *)userModel;
+(void)logout;
+(NSString *)userID;
+(BOOL)isLogin;
@end
