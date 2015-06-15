//
//  UIScrollView+SVStopAnimation.m
//  HHCommonClass
//
//  Created by Luigi on 14-7-11.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import "UIScrollView+SVStopAnimation.h"
#import "UIScrollView+SVInfiniteScrolling.h"
#import "UIScrollView+SVPullToRefresh.h"
@implementation UIScrollView (SVStopAnimation)
- (void)stopRefrshAndInfiniteAnimating{
    UIScrollView *svScrollView=self;
    [svScrollView.pullToRefreshView stopAnimating];
    if (svScrollView.infiniteScrollingView.enabled) {
         [svScrollView.infiniteScrollingView stopAnimating];
    }
}
-(BOOL)handlerInifitScrollingWithPageIndex:(NSInteger *)pid
                                  pageSize:(NSInteger)pageSize
                            totalDataCount:(NSInteger)dataCount{
    if (dataCount==(*pid)*pageSize) {
        (*pid)++;
        self.infiniteScrollingView.enabled=YES;
    }else if(dataCount<(*pid)*pageSize){
        if (dataCount%pageSize) {
            self.infiniteScrollingView.enabled=NO;
        }else{
            (*pid)--;
            self.infiniteScrollingView.enabled=YES;
        }
    }else{
        self.infiniteScrollingView.enabled=NO;
    }
    [self.infiniteScrollingView stopAnimating];
    [self.pullToRefreshView stopAnimating];
    return self.infiniteScrollingView.enabled;
}
@end
