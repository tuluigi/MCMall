//
//  HHScrollView.m
//  SeaMallSell
//
//  Created by d gl on 14-3-31.
//  Copyright (c) 2014年 d gl. All rights reserved.
//

#import "HHScrollView.h"

@implementation HHScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame  delegate:(id)delegate{
    self = [super initWithFrame:frame];
    if (self) {
            // Initialization code
        self.backgroundColor=[UIColor clearColor];
        self.showsHorizontalScrollIndicator=NO;
        self.showsVerticalScrollIndicator=NO;
        self.delegate=delegate;
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
