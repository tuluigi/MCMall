//
//  UIView+OCPageLoad.h
//  OpenCourse
//
//  Created by Luigi on 15/8/31.
//
//

#import <UIKit/UIKit.h>
#import "OCPageLoadViewHeader.h"
@interface UIView (OCPageLoad)
/**
 *  显示默认的加载动画页面
 */
-(void)showPageLoadingView;
/**
 *  带有提示的页面
 *
 *  @param message  提示内容
 *  @param delegate delegate
 */
-(void)showPageLoadedMessage:(NSString *)message delegate:(id)delegate;
-(void)showPageLoadingView:(CGRect)frame;
-(void)showPageLoadedMessage:(NSString *)message frame:(CGRect)frame delegate:(id)delegate;
/**
 *  隐藏delegate
 */
-(void)dismissPageLoadView;
/**
 *  当前view上的pageLoadView
 *
 *  @return 
 */
-(OCPageLoadView *)currentPageLoadView;


@end
