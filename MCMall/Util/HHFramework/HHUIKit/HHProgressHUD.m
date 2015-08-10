//
//  HHProgressHUD.m
//  MCMall
//
//  Created by Luigi on 15/6/1.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "HHProgressHUD.h"
#import "SVProgressHUD.h"
#import "UIView+Toast.h"
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
+(void)showProgress:(CGFloat)progress{
    [SVProgressHUD showProgress:progress];
}


+(void)dismiss{
    [SVProgressHUD dismiss];
}
+(void)makeToast:(NSString *)aMessage{
    if ([SVProgressHUD isVisible]) {
        [SVProgressHUD dismiss];
    }
    [[UIApplication sharedApplication].keyWindow hideToastActivity];
    [[UIApplication sharedApplication].keyWindow makeToast:aMessage duration:0.8 position:[NSValue valueWithCGPoint:CGPointMake([UIApplication sharedApplication].keyWindow.center.x,[UIApplication sharedApplication].keyWindow.frame.size.height-100 )]];
}
+(void)hideToast{
    [[UIApplication sharedApplication].keyWindow hideToastActivity];
}
@end
