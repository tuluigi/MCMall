//
//  HHTableView.m
//  SeaMallBuy
//
//  Created by d gl on 14-2-11.
//  Copyright (c) 2014年 d gl. All rights reserved.
//

#import "HHTableView.h"

@implementation HHTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame dataSource:(id)dataSource delegate:(id)delegate style:(UITableViewStyle )style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource             =   dataSource;
        self.delegate               =   delegate;
        self.separatorColor         =   [UIColor colorWithRed:197.0/255.0 green:197/255.0 blue:197/255.0 alpha:1];
        self.tableFooterView        =   [[UIView alloc] init];
        self.backgroundColor        =   [UIColor clearColor];
        self.showsHorizontalScrollIndicator =NO;
        self.showsVerticalScrollIndicator   =NO;
        if (style==UITableViewStyleGrouped) {
            self.backgroundView=nil;
        }
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
         dataSource:(id)dataSource
           delegate:(id)delegate
              style:(UITableViewStyle )style
     separatorColor:(UIColor *)separatorColor{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource             =   dataSource;
        self.delegate               =   delegate;
        self.separatorColor         =   separatorColor;
        self.tableFooterView        =   [[UIView alloc] init];
        self.backgroundColor        =   [UIColor clearColor];
        self.showsHorizontalScrollIndicator =NO;
        self.showsVerticalScrollIndicator   =NO;
        if (style==UITableViewStyleGrouped) {
            self.backgroundView=nil;
        }
    }
    return self;
}
@end
