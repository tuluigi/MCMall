//
//  HHInfiniteScrollView.m
//  MCMall
//
//  Created by Luigi on 15/11/19.
//  Copyright © 2015年 Luigi. All rights reserved.
//

#import "HHInfiniteScrollView.h"
#define kHHInfiniteScrollViewTag  20000
@interface HHInfiniteScrollView ()
@property(nonatomic,assign)NSUInteger firsttage,currenttage,lasttage;
@property(nonatomic,strong)HHInfiniteCell *cell0,*cell1,*cell2;
@property(nonatomic,assign)BOOL isVertical;
@end

@implementation HHInfiniteScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame isHorizontal:(BOOL)isVertical{
    if (self=[super initWithFrame:frame]) {
        [self onPreformInit];
    }
    return self;
}
-(void)onPreformInit{
    _firsttage=0;
    _currenttage=1;
    _lasttage=2;
    self.autoresizingMask=UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
    if (_infiniteDelegate&&[_infiniteDelegate respondsToSelector:@selector(inifiteView:cellForRow:)]) {
        _cell0=[_infiniteDelegate inifiteView:self cellForRow:_firsttage];
        _cell0.tag=kHHInfiniteScrollViewTag+_firsttage;
        [self addSubview:_cell0];
    }
    if (_infiniteDelegate&&[_infiniteDelegate respondsToSelector:@selector(inifiteView:cellForRow:)]) {
        _cell1=[_infiniteDelegate inifiteView:self cellForRow:_currenttage];
        [self addSubview:_cell1];
    }
    if (_infiniteDelegate&&[_infiniteDelegate respondsToSelector:@selector(inifiteView:cellForRow:)]) {
        _cell2=[_infiniteDelegate inifiteView:self cellForRow:_lasttage];
        [self addSubview:_cell2];
    }
}
-(HHInfiniteCell *)inifiniteCellAtRow:(NSInteger)row{
    NSInteger index=row%3;
    return [self viewWithTag:index];
}
-(HHInfiniteCell *)resuableInifiteCellAtRow:(NSInteger)row{
    return nil;
}
@end
