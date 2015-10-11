//
//  UIView+OCPageLoad.m
//  OpenCourse
//
//  Created by Luigi on 15/8/31.
//
//

#import "UIView+OCPageLoad.h"
#import "OCPageLoadAnimationView.h"
static NSString * const OCPageLoadingViewPropertyKey = @"__OCPageLoadingViewPropertyKey";
@implementation UIView (OCPageLoad)
-(void)showPageLoadingData:(NSDictionary  *)dic{

}
-(void)showOCPageLoadViewData:(NSDictionary *)dic frame:(CGRect)frame delegate:(id)delegate{
    OCPageLoadAnimationView *pageLoadView=[self pageLoadView];
    if (CGRectIsEmpty(frame)||CGRectEqualToRect(CGRectZero, frame)) {
        if (pageLoadView.superview) {
            pageLoadView.frame=pageLoadView.superview.bounds;
        }
    }else{
        pageLoadView.frame=frame;
    }
    [pageLoadView showLoadingData:dic inView:self delegate:delegate];
}
/**
 *  显示默认的加载动画页面
 */
-(void)showPageLoadingView{
    [self showPageLoadingView:CGRectZero];
}
/**
 *  带有提示的页面
 *
 *  @param message  提示内容
 *  @param delegate delegate
 */
-(void)showPageLoadedMessage:(NSString *)message delegate:(id)delegate{
    [self showPageLoadedMessage:message frame:CGRectZero delegate:delegate];
}
-(void)showPageLoadingView:(CGRect)frame{
    NSDictionary *dic=@{OCPageLoadViewTexKey:@"正在加载...",OCPageLoadViewIsLoadingKey:@(YES)};
    [self showOCPageLoadViewData:dic frame:CGRectZero  delegate:nil];
}
-(void)showPageLoadedMessage:(NSString *)message frame:(CGRect)frame delegate:(id)delegate{
    NSDictionary *dic=@{OCPageLoadViewTexKey:message};
    [self showOCPageLoadViewData:dic frame:frame delegate:delegate];
}
/**
 *  隐藏delegate
 */
-(void)dismissPageLoadView{
    OCPageLoadAnimationView *pageView=(OCPageLoadAnimationView *)[self currentPageLoadView];
    if (pageView) {
        [pageView dismiss];
    }
}
-(OCPageLoadAnimationView *)pageLoadView{
   __block OCPageLoadAnimationView *pageView;
    pageView=(OCPageLoadAnimationView *)[self currentPageLoadView];
    if (nil==pageView) {
        pageView=[OCPageLoadAnimationView defaultPageLoadView];
    }
    return pageView;
}
-(OCPageLoadView *)currentPageLoadView{
    __block OCPageLoadAnimationView *pageView;
    [self.subviews enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[OCPageLoadView class]]) {
            pageView=obj;
            return ;
        }
    }];
    return pageView;
}


@end
