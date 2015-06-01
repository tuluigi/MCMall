//
//  UserCenterAPI.m
//  MCMall
//
//  Created by Luigi on 15/5/27.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "UserCenterAPI.h"

@implementation UserCenterAPI
+(NSString *)userLoginAPI{
    return @"/BasePJ/ws/login";
}
+(NSString *)userRegisterAPI{
    return @"/BasePJ/ws/register";
}
+(NSString *)userEditPwdAPI{
    return @"/BasePJ/ws/changepassoword";
}

@end
