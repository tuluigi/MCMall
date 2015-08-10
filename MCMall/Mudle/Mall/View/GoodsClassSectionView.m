//
//  GoodsClassSectionView.m
//  MCMall
//
//  Created by Luigi on 15/8/10.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "GoodsClassSectionView.h"

@interface GoodsClassSectionView ()
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIButton *allButton;
@end

@implementation GoodsClassSectionView
-(instancetype)init{
    self=[self initWithFrame:CGRectZero];
    if (self) {
        
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self onInitUI];
    }
    return self;
}
-(void)onInitUI{
    WEAKSELF
}
@end
