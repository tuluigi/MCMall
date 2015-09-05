//
//  OCPageLoadViewHeader.h
//  OpenCourse
//
//  Created by Luigi on 15/8/31.
//
//

#ifndef OpenCourse_OCPageLoadViewHeader_h
#define OpenCourse_OCPageLoadViewHeader_h

@class OCPageLoadView;
@protocol OCPageLoadViewDelegate <NSObject>

-(void)ocPageLoadView:(OCPageLoadView *)loadView  willMoveToSuperView:(UIView *)aSuperView;
-(void)ocPageLoadView:(OCPageLoadView *)loadView  didMoveToSuperView:(UIView *)aSuperView;
-(void)ocPageLoadView:(OCPageLoadView *)loadView  willDismisFromSuperView:(UIView *)aSuperView;
-(void)ocPageLoadView:(OCPageLoadView *)loadView  didDismissFormSuperView:(UIView *)aSuperView;
/**
 *  屏幕被点击的
 */
-(void)ocPageLoadedViewOnTouced;

@end

#endif
