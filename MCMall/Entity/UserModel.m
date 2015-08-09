//
//  UserModel.m
//  MCMall
//
//  Created by Luigi on 15/5/20.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "UserModel.h"
#import "NSUserDefaults+AesEncrypt.h"
NSString *const MCMall_UserID       =@"MCMall_UserID";
NSString *const MCMall_UserName     =@"MCMall_UserName";
NSString *const MCMall_UserHeadUrl  =@"MCMall_UserHeadUrl";
NSString *const MCMall_UserAmount   =@"MCMall_UserAmount";
NSString *const MCMall_UserTel      =@"MCMall_UserTel";
NSString *const MCMall_ShopName   =@"MCMall_ShopName";
@implementation UserModel
+(UserModel *)userModelWithResponseDic:(NSDictionary *)dic shouldSynchronize:(BOOL)synchroniz{
    UserModel *userModel    =[[UserModel alloc]  init];
    userModel.userName      =[dic objectForKey:@"userName"];
    userModel.userTel       =[dic objectForKey:@"phone"];
    userModel.userAmount    =[NSDecimalNumber decimalNumberWithString:[dic objectForKey:@"money"]];
    userModel.userID        =[dic objectForKey:@"userId"];
    userModel.userHeadUrl   =[dic objectForKey:@"img"];
    userModel.shopName      =[dic objectForKey:@"shopName"];
    userModel.gender        =[dic objectForKey:@"sex"];

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
    [userDefault setAesEncryptValue:userModel.userID withkey:MCMall_UserID];
    [userDefault setAesEncryptValue:userModel.userName withkey:MCMall_UserName];
    [userDefault setAesEncryptValue:[NSString stringWithFormat:@"%@",userModel.userAmount] withkey:MCMall_UserAmount];
    [userDefault setAesEncryptValue:userModel.userHeadUrl withkey:MCMall_UserHeadUrl];
    [userDefault setAesEncryptValue:userModel.shopName withkey:MCMall_ShopName];
    [userDefault setAesEncryptValue:userModel.userTel withkey:MCMall_UserTel];
    [userDefault synchronize];
}
+(void)setUserHeaderImageUrl:(NSString *)headImagPath{
     NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
     [userDefault setAesEncryptValue:headImagPath withkey:MCMall_UserHeadUrl];
}
+(UserModel *)userModel{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    UserModel *model=[[UserModel alloc]  init];
    model.userID=[userDefault decryptedValueWithKey:MCMall_UserID];
    model.userName=[userDefault decryptedValueWithKey:MCMall_UserName];
    model.userHeadUrl=[userDefault decryptedValueWithKey:MCMall_UserHeadUrl];
    NSString *amountStr=[userDefault decryptedValueWithKey:MCMall_UserAmount];
    model.userAmount=[[NSDecimalNumber alloc]  initWithString:amountStr];
    model.userTel=[userDefault decryptedValueWithKey:MCMall_UserTel];
    model.shopName=[userDefault decryptedValueWithKey:MCMall_ShopName];
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
    NSString *userID=[[NSUserDefaults standardUserDefaults]  decryptedValueWithKey:MCMall_UserID];
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
