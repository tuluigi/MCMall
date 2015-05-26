//
//  HHCollectionView.m
//  SeaMallBuy
//
//  Created by d gl on 14-4-25.
//  Copyright (c) 2014年 d gl. All rights reserved.
//

#import "HHCollectionView.h"

@implementation HHCollectionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame delegate:(id)delegate dataSource:(id)dataSourse{
    UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc]init];
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.delegate=delegate;
        self.dataSource=dataSourse;
        self.backgroundColor=[UIColor clearColor];
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
