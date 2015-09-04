//
//  UIView+Addition.m
//  Line0New
//
//  Created by line0 on 13-5-17.
//  Copyright (c) 2013年 makeLaugh. All rights reserved.
//

#import "UIView+Addition.h"

@implementation UIView (Addition)

- (UIView *)subViewWithTag:(int)tag
{
	for (UIView *v in self.subviews)
    {
		if (v.tag == tag)
        {
			return v;
		}
	}
	return nil;
}
@end



@implementation UIView (CGRect)


- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

@end

@implementation UIView (Layer)

#define DEGREES_TO_RADIANS(d)   (d * M_PI / 180)
+ (UIView *)reflectImage:(UIImage *)image withFrame:(CGRect)frame opacity:(CGFloat)opacity atView:(UIView *)view
{
        // Image Layer
    CALayer *imageLayer = [CALayer layer];
    imageLayer.contents = (id)image.CGImage;
    imageLayer.frame = frame;
        //	imageLayer.borderColor = [UIColor darkGrayColor].CGColor;
        //	imageLayer.borderWidth = 6.0;
    [view.layer addSublayer:imageLayer];
    
        // Reflection Layer
    CALayer *reflectionLayer = [CALayer layer];
    reflectionLayer.contents = imageLayer.contents;
    reflectionLayer.frame = CGRectMake(imageLayer.frame.origin.x, imageLayer.frame.origin.y + imageLayer.frame.size.height, imageLayer.frame.size.width, imageLayer.frame.size.height);
        //	reflectionLayer.borderColor = imageLayer.borderColor;
        //	reflectionLayer.borderWidth = imageLayer.borderWidth;
    reflectionLayer.opacity = opacity;
        // Transform X by 180 degrees
    [reflectionLayer setValue:[NSNumber numberWithFloat:DEGREES_TO_RADIANS(180)] forKeyPath:@"transform.rotation.x"];
    
        // Gradient Layer - Use as mask
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.bounds = reflectionLayer.bounds;
    gradientLayer.position = CGPointMake(reflectionLayer.bounds.size.width / 2, reflectionLayer.bounds.size.height * 0.5);
    gradientLayer.colors = [NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor],(id)[[UIColor whiteColor] CGColor], nil];
    gradientLayer.startPoint = CGPointMake(0.5, 0.6);
    gradientLayer.endPoint = CGPointMake(0.5, 1.0);
    
        // Add gradient layer as a mask
    reflectionLayer.mask = gradientLayer;
    [view.layer addSublayer:reflectionLayer];
    
    return view;
}


- (void)startRotationAnimatingWithDuration:(CGFloat)duration
{
    CABasicAnimation *animation = [ CABasicAnimation animationWithKeyPath: @"transform" ];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    
        //围绕Z轴旋转，垂直与屏幕
    animation.toValue = [ NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0.0, 0.0, 1.0) ];
    animation.duration = duration;
        //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
    animation.cumulative = YES;
    animation.removedOnCompletion = NO;
    animation.repeatCount = HUGE_VALL;
    
    [self.layer setShouldRasterize:YES];//抗锯齿
    [self.layer setRasterizationScale:[[UIScreen mainScreen] scale]];
    [self.layer addAnimation:animation forKey:nil];
    
        //如果暂停了，则恢复动画运行
    if (self.layer.speed == 0.0)
    {
        [self resumeAnimating];
    }
}

- (void)stopRotationAnimating
{
    [self.layer removeAllAnimations];
}

- (void)pauseAnimating
{
    CFTimeInterval pausedTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.layer.speed = 0.0;
    self.layer.timeOffset = pausedTime;
}

- (void)resumeAnimating
{
    CFTimeInterval pausedTime = [self.layer timeOffset];
    self.layer.speed = 1.0;
    self.layer.timeOffset = 0.0;
    self.layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.layer.beginTime = timeSincePause;
}

@end
@implementation UIView (RoundCorner)
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
           borderWidth:(CGFloat)width{
    UIBezierPath *shapePath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                    byRoundingCorners:rectCorner
                                                          cornerRadii:radiSize];
    
    CAShapeLayer *shapeLayer =  [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.path = shapePath.CGPath;
    shapeLayer.fillColor = fillColor.CGColor;
    shapeLayer.strokeColor = borderColor.CGColor;
    shapeLayer.lineWidth=width;
    [self.layer insertSublayer:shapeLayer atIndex:0];
    
}
@end
