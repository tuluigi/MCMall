    //
    //  UIView+LoadingView.m
    //  MoblieCity
    //
    //  Created by Luigi on 14-7-18.
    //  Copyright (c) 2014年 luigi. All rights reserved.
    //

#import "UIView+LoadingView.h"
#import "HHLoadingView.h"
@implementation UIView (LoadingView)

-(void)showLoadingView:(UIView *)view{
    [self stopAndPreventScrollEnable];
    [[HHLoadingView sharedLoadingView] hideLoadingView];
    if (view) {
        [[HHLoadingView sharedLoadingView] showWithView:view];
        [self addSubview:[HHLoadingView sharedLoadingView]];
    }
}
/**
 *  显示正在加载的动画
 *
 *  @param text        显示的文字
 *  @param imagesArray 需要显示动画的图片数组,(数组里边存放的是UIImage对象)
 *  @param duration    每次动画的持续时间
 */
- (void)showLoadingViewWithText:(NSString *)text
                animationImages:(NSArray *)imagesArray
              animationDuration:(NSTimeInterval)duration{
    [self stopAndPreventScrollEnable];
    [[HHLoadingView sharedLoadingView] hideLoadingView];
    [[HHLoadingView sharedLoadingView] showLoadingViewWithText:text animationImages:imagesArray animationDuration:duration];
    [self addSubview:[HHLoadingView sharedLoadingView]];
}
/**
 *  显示loadingView
 *
 *  @param text     显示的文字
 *  @param animated 是否显示正在加载的动画
 *  @param delegate delegate： 是否支持点击屏幕重新加载
 */
- (void)showLoadingViewWithText:(NSString *)text loadingAnimated:(BOOL)animated  delegate:(id)delegate{
    [self stopAndPreventScrollEnable];
    [[HHLoadingView sharedLoadingView] hideLoadingView];
    [[HHLoadingView sharedLoadingView] showLoadingViewWithText:text loadingAnimated:animated  delegate:delegate];
    [self addSubview:[HHLoadingView sharedLoadingView]];
}

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
                      touchType:(HHLoadingViewTouchType)type{
    [self stopAndPreventScrollEnable];
    [[HHLoadingView sharedLoadingView] hideLoadingView];
    [[HHLoadingView sharedLoadingView] showLoadingViewWithText:text showImage:image delegate:delegate touchType:type];
    [self addSubview:[HHLoadingView sharedLoadingView]];
}
-(void)hideLoadingView{
    [self resetScrollEnable];
    [[HHLoadingView sharedLoadingView] hideLoadingView];
}


-(void)stopAndPreventScrollEnable{
    if ([self isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView=(UIScrollView *)self;
        [scrollView setScrollEnabled:NO ];
        if (scrollView.contentOffset.y<0) {
            [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        }else
            [scrollView setContentOffset:scrollView.contentOffset animated:NO];
    }
}
-(void)resetScrollEnable{
    if ([self isKindOfClass:[UIScrollView class]]) {
        ((UIScrollView *)self).scrollEnabled=YES;
    }
}
@end
