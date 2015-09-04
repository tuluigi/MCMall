//
//  UIView+LoadingView.h
//  MoblieCity
//
//  Created by Luigi on 14-7-18.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHLoadingViewDelegate.h"
@interface UIView (LoadingView)
#pragma mrak
-(void)showPageLoadingView;
-(void)showPageLoadViewWithMessage:(NSString *)message;
-(void)dismissPageLoadView;



@end
