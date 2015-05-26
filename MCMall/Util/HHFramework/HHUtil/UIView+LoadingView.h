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


/**
 *  显示自定义的LoadingView
 *
 *  @param view: 想要显示的view
 */
- (void)showLoadingView:(UIView *)view;


/**
 *  显示正在加载的动画
 *
 *  @param text        显示的文字
 *  @param imagesArray 需要显示动画的图片数组,(数组里边存放的是UIImage对象)
 *  @param duration    每次动画的持续时间
 */
- (void)showLoadingViewWithText:(NSString *)text
                animationImages:(NSArray *)imagesArray
              animationDuration:(NSTimeInterval)duration;

/**
 *  显示loadingView
 *
 *  @param text          显示的文字
 *  @param image         显示的图片
 *  @param delegate      delegate
 *  @param imgViewEnable 图片是否支持触摸操作
 *  @param bgEnable      loadingView是否支持触摸操作
 */
- (void)showLoadingViewWithText:(NSString *)text
                      showImage:(UIImage *)image
                       delegate:(id)delegate
                      touchType:(HHLoadingViewTouchType)type;

/**
 *  隐藏显示的view
 */
-(void)hideLoadingView;

@end
