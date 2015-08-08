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
NSString *const MCMall_UserAmount   =@"MCMall_UserAmount";
NSString *const MCMall_UserTel      =@"MCMall_UserTel";
NSString *const MCMall_ShopName   =@"MCMall_ShopName";
@implementation UserModel

/*
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        self.userID     =[aDecoder decodeObjectForKey:@"userID"];
        self.userName   =[aDecoder decodeObjectForKey:@"userName"];
        self.userTel    =[aDecoder decodeObjectForKey:@"userTel"];
        self.userAmount =[aDecoder decodeObjectForKey:@"userAmount"];
    }
    return self;
}
 */
+(UserModel *)userModelWithResponseDic:(NSDictionary *)dic shouldSynchronize:(BOOL)synchroniz{
    UserModel *userModel    =[[UserModel alloc]  init];
    userModel.userName      =[dic objectForKey:@"userName"];
    userModel.userTel       =[dic objectForKey:@"phone"];
    userModel.userAmount    =[NSDecimalNumber decimalNumberWithString:[dic objectForKey:@"money"]];
    userModel.userID        =[dic objectForKey:@"userId"];
    userModel.userHeadUrl   =[dic objectForKey:@"img"];
    userModel.shopName      =[dic objectForKey:@"shopName"];
    userModel.gender        =[[dic objectForKey:@"sex"] isEqual:[NSNull null]]?@(-1):@(1);

    NSString *birth         =[NSString stringByReplaceNullString:[dic objectForKey:@"birth"]];
    NSDateFormatter *fromatter=[NSDateFormatter dateFormatterWithFormat:@"yyyy-MM-dd"];
    userModel.birthday      =[fromatter  dateFromString:birth];
    userModel.bigNickName   =[NSString stringByReplaceNullString:[dic objectForKey:@"full"]];
    userModel.smallNickName =[NSString stringByReplaceNullString:[dic objectForKey:@"child"]];
    
    if (synchroniz) {
        [UserModel storeUserModel:userModel];
    }
    return userModel;
}
+(void)storeUserModel:(UserModel *)userModel{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    [userDefault setObject:userModel.userID forKey:MCMall_UserID];
    [userDefault setObject:userModel.userName forKey:MCMall_UserName];
    [userDefault setObject:userModel.userAmount forKey:MCMall_UserAmount];
    [userDefault setObject:userModel.userHeadUrl forKey:MCMall_UserHeadUrl];
    [userDefault setObject:userModel.shopName forKey:MCMall_ShopName];
    [userDefault setObject:userModel.userTel forKey:MCMall_UserTel];
    [userDefault synchronize];
}
+(UserModel *)userModel{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    UserModel *model=[[UserModel alloc]  init];
    model.userID=[userDefault objectForKey:MCMall_UserID];
    model.userName=[userDefault objectForKey:MCMall_UserName];
    model.userHeadUrl=[userDefault objectForKey:MCMall_UserHeadUrl];
    model.userAmount=[userDefault objectForKey:MCMall_UserAmount];
    model.userTel=[userDefault objectForKey:MCMall_UserTel];
    model.shopName=[userDefault objectForKey:MCMall_ShopName];
    return model;
}
+(void)logout{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    [userDefault setObject:nil forKey:MCMall_UserID];
    [userDefault setObject:nil forKey:MCMall_UserName];
    [userDefault setObject:nil forKey:MCMall_UserAmount];
    [userDefault setObject:nil forKey:MCMall_UserHeadUrl];
    [userDefault setObject:nil forKey:MCMall_ShopName];
    [userDefault setObject:nil forKey:MCMall_UserTel];
    [userDefault synchronize];

}
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
