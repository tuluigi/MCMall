    //
    //  HHLoadingView.h
    //  MedicineMall
    //
    //  Created by d gl on 14-6-19.
    //  Copyright (c) 2014年 d gl. All rights reserved.
    //

#import <UIKit/UIKit.h>
#import "HHLoadingViewDelegate.h"
@interface HHLoadingView : UIView
@property(nonatomic,strong,readonly)UILabel  *textLable;
@property(nonatomic,strong,readonly)UIImageView *imageView;



+(instancetype)sharedLoadingView;
/**
 *  显示自定义的LoadingView
 *
 *  @param view 自定义的view
 */
-(void)showWithView:(UIView *)view;


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
 *  @param text     显示的文字
 *  @param animated 是否显示正在加载的动画
 *  @param delegate delegate： 是否支持点击屏幕重新加载
 */
- (void)showLoadingViewWithText:(NSString *)text
                loadingAnimated:(BOOL)animated
                       delegate:(id)delegate;

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
 * 隐藏页面加载动画及信息提示
 */
- (void)hideLoadingView;
@end
