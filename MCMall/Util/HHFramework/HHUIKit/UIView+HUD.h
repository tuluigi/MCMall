//
//  UIView+HUD.h
//  MCMall
//
//  Created by Luigi on 15/9/4.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HUD)
-(void)showLoadingState;
-(void)showLoadingMessage:(NSString *)msg;
-(void)showSuccessMessage:(NSString *)msg;
-(void)showErrorMssage:(NSString *)msg;
-(void)showProgressWithMessage:(NSString *)msg;
-(void)showProgress:(CGFloat)progress;

-(void)dismiss;

-(void)makeToast:(NSString *)aMessage;
-(void)hideToast;
@end
