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
    return @"/muying/ws//login";
}
+(NSString *)userRegisterAPI{
    return @"/muying/ws/register";
}
+(NSString *)userEditPwdAPI{
    return @"/muying/ws/changepassoword";
}

@end
