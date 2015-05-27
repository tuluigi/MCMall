//
//  UIViewController+MCMall.m
//  MCMall
//
//  Created by Luigi on 15/5/27.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "UIViewController+MCMall.h"
#import "LoginViewController.h"

@implementation UIViewController (MCMall)
-(BOOL)verfiyUserLogin{
    BOOL isLogin=[UserModel isLogin];
    if (!isLogin) {
        LoginViewController *loginViewController=[[LoginViewController alloc]  initWithStyle:UITableViewStylePlain];
        loginViewController.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:loginViewController animated:YES];
    }
    return isLogin;
}
@end
