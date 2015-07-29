//
//  HHProgressHUD.h
//  MCMall
//
//  Created by Luigi on 15/6/1.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHProgressHUD : UIView
+(void)showLoadingState;
+(void)showLoadingMessage:(NSString *)msg;
+(void)showSuccessMessage:(NSString *)msg;
+(void)showErrorMssage:(NSString *)msg;
+(void)showProgressWithMessage:(NSString *)msg;

+(void)dismiss;

+(void)makeToast:(NSString *)aMessage;
+(void)hideToast;
@end
