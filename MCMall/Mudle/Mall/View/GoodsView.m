//
//  GoodsView.m
//  MCMall
//
//  Created by Luigi on 15/8/10.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "GoodsView.h"
#import "GoodsModel.h"

@interface GoodsView ()
@property(nonatomic,strong)UIImageView *goodsImageView;
@property(nonatomic,strong)UILabel *goodsNameLable, *goodsPriceLable,*timeLable,*storeLable;
@end

@implementation GoodsView
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
    _goodsImageView=[UIImageView new];
    [self addSubview:_goodsImageView];
    
    _goodsNameLable=[[UILabel alloc]  init];
    _goodsPriceLable.numberOfLines=2;
    _goodsNameLable.font=[UIFont systemFontOfSize:12];
    _goodsNameLable.textAlignment=NSTextAlignmentCenter;
    _goodsNameLable.textColor=[UIColor blackColor];
    [self addSubview:_goodsNameLable];
    
    _goodsPriceLable=[[UILabel alloc]  init];
    _goodsPriceLable.font=[UIFont systemFontOfSize:12];
    _goodsPriceLable.textAlignment=NSTextAlignmentCenter;
    _goodsPriceLable.textColor=[UIColor blackColor];
    [self addSubview:_goodsPriceLable];
    
    _storeLable=[[UILabel alloc]  init];
    _storeLable.font=[UIFont systemFontOfSize:12];
    _storeLable.textAlignment=NSTextAlignmentCenter;
    _storeLable.textColor=[UIColor blackColor];
    [self addSubview:_storeLable];

    
    _timeLable=[[UILabel alloc]  init];
    _timeLable.font=[UIFont systemFontOfSize:12];
    _timeLable.textAlignment=NSTextAlignmentCenter;
    _timeLable.textColor=[UIColor blackColor];
    [self addSubview:_timeLable];
    
    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.mas_equalTo(weakSelf);
        make.height.mas_equalTo(150);
    }];
    [_goodsNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.mas_left).offset(5);
        make.top.mas_equalTo(_goodsImageView.mas_bottom);
        make.height.mas_equalTo(30);
        make.right.mas_equalTo(weakSelf.mas_right).offset(-5);
    }];
    [_goodsPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_goodsNameLable);
        make.top.mas_equalTo(_goodsNameLable.mas_bottom);
        make.right.equalTo(weakSelf.mas_centerX);
        make.height.mas_equalTo(20);
    }];
    [_storeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_goodsPriceLable.mas_right);
        make.top.height.mas_equalTo(_goodsPriceLable);
        make.right.mas_equalTo(_goodsNameLable);
    }];
    [_timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_goodsNameLable);
        make.top.mas_equalTo(_goodsPriceLable.mas_bottom);
        make.bottom.mas_equalTo(weakSelf).offset(-10);
    }];
}
-(void)setGoodsModel:(GoodsModel *)goodsModel{
    _goodsModel=goodsModel;
    
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:goodsModel.goodsImageUrl] placeholderImage:MCMallDefaultImg];
    _goodsNameLable.text=_goodsModel.goodsName;
    _storeLable.text=[NSString stringWithFormat:@"%ld",_goodsModel.storeNum];
    _goodsPriceLable.text=[NSString stringWithFormat:@"%.2f",_goodsModel.orignalPrice];
    NSDateFormatter *fromatter=[NSDateFormatter defaultDateFormatter];
    _timeLable.text= [fromatter stringFromDate:_goodsModel.endTime];
    if (_goodsModel) {
        self.hidden=NO;
    }else{
        self.hidden=YES;
    }
   
}
@end
