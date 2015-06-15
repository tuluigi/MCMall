//
//  UIScrollView+SVStopAnimation.h
//  HHCommonClass
//
//  Created by Luigi on 14-7-11.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (SVStopAnimation)
/**
 *  停止下拉刷新和加载更多的动画
 */
- (void)stopRefrshAndInfiniteAnimating;
/**
 *  处理下拉刷新和加载更多
 *
 *  @param pid       当前第几页每页多少条
 *  @param pageSize
 *  @param dataCount 一共多少条数据
 *
 *  @return 当前scrollview 是否支持加载更多
 */
-(BOOL)handlerInifitScrollingWithPageIndex:(NSInteger *)pid
                                  pageSize:(NSInteger)pageSize
                            totalDataCount:(NSInteger)dataCount;
@end
