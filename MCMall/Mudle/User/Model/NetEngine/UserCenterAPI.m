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
    return [[HHGlobalVarTool domainPath] stringByAppendingPathExtension:@""];
}
+(NSString *)userRegisterAPI{
    return [[HHGlobalVarTool domainPath] stringByAppendingPathExtension:@""];
}
+(NSString *)userEditPwdAPI{
    return [[HHGlobalVarTool domainPath] stringByAppendingPathExtension:@""];
}

@end
