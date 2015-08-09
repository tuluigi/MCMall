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
@property(nonatomic,assign)CGFloat userPoint;
@property(nonatomic,copy)NSDecimalNumber *userAmount;
@property(nonatomic,copy)NSString *shopID;
@property(nonatomic,copy)NSString *shopName;
@property(nonatomic,copy)NSString * gender;//0男；1 女
@property(nonatomic,copy)NSDate *birthday;
@property(nonatomic,copy)NSString *bigNickName,*smallNickName;//大名 小明

+(void)setUserHeaderImageUrl:(NSString *)headImagPath;

+(UserModel *)userModelWithResponseDic:(NSDictionary *)dic shouldSynchronize:(BOOL)synchroniz;
+(UserModel *)userModel;
+(void)logout;
+(NSString *)userID;
+(BOOL)isLogin;
@end


