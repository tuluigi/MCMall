//
//  HHUserManager.m
//  MCMall
//
//  Created by Luigi on 15/8/9.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "HHUserManager.h"
#import "LoginViewController.h"
@implementation HHUserManager


+(void)shouldUserLoginOnCompletionBlock:(DidUserLoginCompletionBlock)loginBlock{
    BOOL isLogin=[UserModel isLogin];
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
