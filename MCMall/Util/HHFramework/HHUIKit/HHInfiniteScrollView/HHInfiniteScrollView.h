//
//  HHInfiniteScrollView.h
//  MCMall
//
//  Created by Luigi on 15/11/19.
//  Copyright © 2015年 Luigi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHInfiniteCell.h"
@class HHInfiniteScrollView;
@protocol HHInfiniteScrollViewDelegate <NSObject>
-(NSUInteger)numberOfRows;
-(HHInfiniteCell *)inifiteView:(HHInfiniteScrollView *)infiniteView cellForRow:(NSInteger)row;
-(void)inifiteView:(HHInfiniteScrollView *)infiniteView didSelectCellAtRow:(NSInteger)row;
@end


@interface HHInfiniteScrollView : UIScrollView
@property(nonatomic,weak)id<HHInfiniteScrollViewDelegate>infiniteDelegate;

-(instancetype)initWithFrame:(CGRect)frame isVertical:(BOOL)isVertical;
@end
