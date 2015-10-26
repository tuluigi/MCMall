//
//  HHUserManager.h
//  MCMall
//
//  Created by Luigi on 15/8/9.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserModel;
@interface HHUserManager : NSObject
+(void)storeLoginUserModel:(UserModel *)userModel;
+(void)setUserHeaderImageUrl:(NSString *)headImagPath;
+(void)setMotherState:(NSInteger)state;
+(void)setUserPoint:(NSString *)point;
+(void)logout;
+(UserModel *)userModel;
+(NSString *)userID;
+(BOOL)isLogin;

+(void)shouldUserLoginOnCompletionBlock:(DidUserLoginCompletionBlock)loginBlock;

+(void)updateUserPointOnCompletionBlock:(void(^)(BOOL isUpdateSucceed, NSInteger userpoint))completionBlock;
@end
