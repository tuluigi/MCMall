//
//  HHUserManager.m
//  MCMall
//
//  Created by Luigi on 15/8/9.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "HHUserManager.h"
#import "LoginViewController.h"
#import "UserModel.h"
#import "NSUserDefaults+AesEncrypt.h"
NSString *const MCMall_UserID       =@"MCMall_UserID";
NSString *const MCMall_UserName     =@"MCMall_UserName";
NSString *const MCMall_UserHeadUrl  =@"MCMall_UserHeadUrl";
NSString *const MCMall_UserAmount   =@"MCMall_UserAmount";
NSString *const MCMall_UserTel      =@"MCMall_UserTel";
NSString *const MCMall_ShopName   =@"MCMall_ShopName";
NSString *const MCMall_UserPoint   =@"MCMall_UsrPoint";
NSString *const MCMall_MotherSatte   =@"MCMall_MotherSatte";
@implementation HHUserManager
+(void)storeLoginUserModel:(UserModel *)userModel{
     NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    [userDefault setAesEncryptValue:userModel.userID withkey:MCMall_UserID];
    [userDefault setAesEncryptValue:userModel.userName withkey:MCMall_UserName];
    [userDefault setAesEncryptValue:[NSString stringWithFormat:@"%.2f",userModel.userAmount] withkey:MCMall_UserAmount];
    [userDefault setAesEncryptValue:userModel.userHeadUrl withkey:MCMall_UserHeadUrl];
    [userDefault setAesEncryptValue:userModel.shopName withkey:MCMall_ShopName];
    [userDefault setAesEncryptValue:userModel.userTel withkey:MCMall_UserTel];
    [userDefault setAesEncryptValue:[NSString stringWithFormat:@"%ld",userModel.motherState] withkey:MCMall_MotherSatte];
    [userDefault synchronize];
}
+(void)setUserHeaderImageUrl:(NSString *)headImagPath{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    [userDefault setAesEncryptValue:headImagPath withkey:MCMall_UserHeadUrl];
}
+(void)setMotherState:(NSInteger)state{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    [userDefault setAesEncryptValue:[NSString stringWithFormat:@"%ld",state] withkey:MCMall_MotherSatte];
}
+(void)setUserPoint:(NSString *)point{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    [userDefault setAesEncryptValue:point withkey:MCMall_UserPoint];
}
+(UserModel *)userModel{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    
    UserModel *model=[[UserModel alloc]  init];
    model.userID=[userDefault decryptedValueWithKey:MCMall_UserID];
    model.userName=[userDefault decryptedValueWithKey:MCMall_UserName];
    model.userHeadUrl=[userDefault decryptedValueWithKey:MCMall_UserHeadUrl];
    NSString *amountStr=[userDefault decryptedValueWithKey:MCMall_UserAmount];
    model.userAmount=[amountStr floatValue];
    model.userTel=[userDefault decryptedValueWithKey:MCMall_UserTel];
    model.shopName=[userDefault decryptedValueWithKey:MCMall_ShopName];
    model.motherState=[[userDefault decryptedValueWithKey:MCMall_MotherSatte] integerValue];
    model.userPoint=[[userDefault decryptedValueWithKey:MCMall_UserPoint] floatValue];
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
    [userDefault setObject:nil forKey:MCMall_UserPoint];
    [userDefault setObject:nil forKey:MCMall_MotherSatte];
    [userDefault synchronize];
    
}
+(NSString *)userID{
    NSString *userID=[[NSUserDefaults standardUserDefaults]  decryptedValueWithKey:MCMall_UserID];
    return userID;
}
+(BOOL)isLogin{
    NSString *userID=[HHUserManager userID];
    if (userID&&userID.length) {
        return YES;
    }else{
        return NO;
    }
}

+(void)shouldUserLoginOnCompletionBlock:(DidUserLoginCompletionBlock)loginBlock{
    BOOL isLogin=[HHUserManager isLogin];
    if (!isLogin) {
        LoginViewController *loginViewController=[[LoginViewController alloc]  initWithStyle:UITableViewStylePlain];
        
        loginViewController.userLoginCompletionBlock=^(BOOL isSucceed,NSString *userID){
            if (loginBlock) {
                loginBlock(isSucceed,userID);
            }
        };
        loginViewController.hidesBottomBarWhenPushed=YES;
        UINavigationController *rootNavController=[[UINavigationController alloc]  initWithRootViewController:loginViewController];
        UIViewController *rootViewController=[UIApplication sharedApplication].keyWindow.rootViewController;
        
        [rootViewController presentViewController:rootNavController animated:YES completion:^{
            
        }];
    }
}
@end
