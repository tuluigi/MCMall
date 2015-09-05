//
//  OCPageLoadView.h
//  OpenCourse
//
//  Created by Luigi on 15/8/31.
//
//

#import <UIKit/UIKit.h>
#import "OCPageLoadViewHeader.h"

UIKIT_EXTERN NSString *const OCPageLoadViewTexKey;//显示单张图片的时候key

@interface OCPageLoadView : UIView

+(OCPageLoadView *)defaultPageLoadView;

/**
 *  初始化UI
 */
-(void)onInitUI;

/**
 *  显示自定义loadingView
 *
 *  @param loadView 自定义的View
 *  @param aView    再哪个view上显示
 *  @param delegate delegate
 */
-(void)showLoadingView:(UIView *)loadView inView:(UIView *)aView delegate:(id)delegate;
/**
 *  显示loading的信息
 *
 *  @param dic      dic字典里边存储的是将要显示的内容的信息。 
 *             ！——具体的key参考：OCPageLoadViewTexKey ；OCPageLoadViewImageKey；OCPageLoadingAnimationImagesKey；OCPageLoadingAnimationDurationKey--！
 *  @param aView    在哪个view上显示
 *  @param delegate delegate
 */
-(void)showLoadingData:(NSDictionary *)dic inView:(UIView *)aView delegate:(id)delegate;

/**
 *  隐藏消失当前View
 */
-(void)dismiss;

@end
