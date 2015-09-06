    //
    //  UIView+Addition.h
    //  HHUIKitFrameWork
    //
    //  Created by d gl on 14-5-30.
    //  Copyright (c) 2014年 luigi. All rights reserved.
    //
#import <UIKit/UIKit.h>

@interface UIView (Addition)
- (UIView *)subViewWithTag:(int)tag;

@end


@interface UIView (CGRect)
/**
 *  返回UIView及其子类的位置和尺寸。分别为左、右边界在X轴方向上的距离，上、下边界在Y轴上的距离，View的宽和高。
 */

@property(nonatomic) CGFloat left;
@property(nonatomic) CGFloat right;
@property(nonatomic) CGFloat top;
@property(nonatomic) CGFloat bottom;
@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;
@end


@interface UIView (Layer)
/**
 *  产生一个Image的倒影，并把这个倒影图片加在一个View上面。
 *  @param  image:被倒影的原图。
 *  @param  frame:盖在上面的图。
 *  @param  opacity:倒影的透明度，0为完全透明，即倒影不可见;1为完全不透明。
 *  @param  view:倒影加载在上面。
 *  return  产生倒影后的View。
 */
+ (UIView *)reflectImage:(UIImage *)image withFrame:(CGRect)frame opacity:(CGFloat)opacity atView:(UIView *)view;

    //开始和停止旋转动画
- (void)startRotationAnimatingWithDuration:(CGFloat)duration;
- (void)stopRotationAnimating;

    //暂停恢复动画
- (void)pauseAnimating;
- (void)resumeAnimating;
@end

@interface UIView (RoundCorner)
/**
 * 设置view 的圆角
 *
 *  @param rectCorner  某个角为圆角（左上，左下，右上，右下，全部）
 *  @param radiSize     圆角的大小（eg;CGSizeMake(10,10)）
 *  @param fillColor   view 的背景色
 *  @param borderColor 边框的颜色
 *  @param width       边框的宽度
 */
-(void)roundingCorners:(UIRectCorner)rectCorner
           cornerRadii:(CGSize)radiSize
             fillColor:(UIColor *)fillColor
           borderColor:(UIColor *)borderColor
           borderWidth:(CGFloat)width;
@end