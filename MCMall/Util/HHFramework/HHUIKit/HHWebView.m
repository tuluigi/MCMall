//
//  HHWebView.m
//  SeaMallBuy
//
//  Created by d gl on 14-5-5.
//  Copyright (c) 2014年 d gl. All rights reserved.
//

#import "HHWebView.h"

@implementation HHWebView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame delegate:(id)delegate{
    
    self = [super initWithFrame:frame];
    if (self) {
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
