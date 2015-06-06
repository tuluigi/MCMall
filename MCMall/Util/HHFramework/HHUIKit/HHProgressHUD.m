//
//  HHProgressHUD.m
//  MCMall
//
//  Created by Luigi on 15/6/1.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "HHProgressHUD.h"
#import "SVProgressHUD.h"
@implementation HHProgressHUD
+(void)showLoadingMessage:(NSString *)msg{
    [SVProgressHUD showWithStatus:msg];
}
+(void)showLoadingState{
    [self showLoadingMessage:@"请稍等..."];
}
+(void)showSuccessMessage:(NSString *)msg{
    [SVProgressHUD showSuccessWithStatus:msg];
}
+(void)showErrorMssage:(NSString *)msg{
    [SVProgressHUD showErrorWithStatus:msg];
}
+(void)showProgressWithMessage:(NSString *)msg{
    [SVProgressHUD showProgress:1 status:msg];
}

+(void)dismiss{
    [SVProgressHUD dismiss];
}
@end
