//
//  HomeMenuView.m
//  MCMall
//
//  Created by Luigi on 15/8/14.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "HomeMenuView.h"

@interface HomeMenuView ()

@end

@implementation HomeMenuView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self onInitUI];
    }
    return self;
}
-(instancetype)init{
    self=[self initWithFrame:CGRectZero];
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)onInitUI{
    _imageView=[UIImageView new];
    [self addSubview:_imageView];
    
    _titleLable=[[UILabel alloc]  init];
    _titleLable.textAlignment=NSTextAlignmentLeft;
    _titleLable.font=[UIFont systemFontOfSize:14];
    _titleLable.textColor=[UIColor darkGrayColor];
    [self addSubview:_titleLable];
    WEAKSELF
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.right.mas_equalTo(_titleLable.mas_left).offset(-5);
        make.left.mas_equalTo(weakSelf.mas_left).offset(10);
    }];
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_imageView.mas_right).offset(5);
        make.centerY.mas_equalTo(_imageView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60, 20));
        make.right.mas_equalTo(weakSelf).offset(-10);
    }];
}

+(CGSize )homeMenuViewSize{
    return CGSizeMake(115, 40);
}
@end
