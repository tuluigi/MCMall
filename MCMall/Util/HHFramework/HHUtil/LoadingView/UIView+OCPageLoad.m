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
-(void)showOCPageLoadViewData:(NSDictionary *)dic delegate:(id)delegate{
//     OCPageLoadAnimationView *pageLoadView=[self pageLoadView];
//     [pageLoadView showLoadingData:dic inView:self delegate:delegate];
}

/**
 *  显示默认的加载动画页面
 */
-(void)showPageLoadingView{
//    NSDictionary *dic=@{OCPageLoadingAnimationImagesKey:@[[UIImage imageNamed:@"loading1_iphone"],[UIImage imageNamed:@"loading2_iphone"],[UIImage imageNamed:@"loading3_iphone"],[UIImage imageNamed:@"loading4_iphone"],[UIImage imageNamed:@"loading5_iphone"],],OCPageLoadingAnimationDurationKey:@(2),OCPageLoadViewTexKey:@"正在努力加载..."};
    NSDictionary *dic=@{OCPageLoadViewTexKey:@"正在努力加载..."};
    [self showOCPageLoadViewData:dic  delegate:nil];
}
/**
 *  带有提示的页面
 *
 *  @param message  提示内容
 *  @param delegate delegate
 */
-(void)showPageLoadedMessage:(NSString *)message delegate:(id)delegate{
//    NSDictionary *dic=@{OCPageLoadViewImageKey:[UIImage imageNamed:@"ico_no_content"],OCPageLoadViewTexKey:@"点击屏幕重新加载"};
//    [self showOCPageLoadViewData:dic delegate:delegate];
    
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
