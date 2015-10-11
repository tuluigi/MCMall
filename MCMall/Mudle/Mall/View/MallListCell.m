//
//  MallListCell.m
//  MCMall
//
//  Created by Luigi on 15/8/10.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "MallListCell.h"
#import "GoodsModel.h"
#import "GoodsTimeView.h"
@interface MallListCell ()
@property(nonatomic,strong)UIImageView *goodsImageView;
@property(nonatomic,strong)UILabel *goodsNameLable, *goodsPriceLable;
@property(nonatomic,strong)GoodsTimeView *goodsTimeView;
@end

@implementation MallListCell
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self onInitUI];

    }
    return self;
}
-(void)onInitUI{
    WEAKSELF
    _goodsImageView=[UIImageView new];
    _goodsImageView.contentMode=UIViewContentModeScaleToFill;
    [self.contentView addSubview:_goodsImageView];
    
    _goodsNameLable=[[UILabel alloc]  init];
    _goodsNameLable.font=[UIFont systemFontOfSize:12];
    _goodsNameLable.textAlignment=NSTextAlignmentCenter;
    _goodsNameLable.textColor=[UIColor blackColor];
    [self.contentView addSubview:_goodsNameLable];
    
    _goodsPriceLable=[[UILabel alloc]  init];
    _goodsPriceLable.font=[UIFont systemFontOfSize:12];
    _goodsPriceLable.textAlignment=NSTextAlignmentCenter;
    _goodsPriceLable.textColor=MCMallThemeColor;
    [self.contentView addSubview:_goodsPriceLable];
    
    _goodsTimeView=[[GoodsTimeView alloc]  initWithFrame:CGRectZero];
    [self.contentView addSubview:_goodsTimeView];
    
    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.mas_equalTo(weakSelf.contentView);
        make.height.mas_equalTo(100);
    }];
    [_goodsNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView.mas_left).offset(10);
        make.top.mas_equalTo(_goodsImageView.mas_bottom).offset(5);
        make.right.mas_equalTo(weakSelf.goodsPriceLable.mas_left);
        make.height.mas_equalTo(20);
        make.bottom.mas_equalTo(weakSelf.contentView.mas_bottom).offset(-10);
    }];
    
    [_goodsPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.goodsTimeView.mas_left);
        make.top.height.mas_equalTo(_goodsNameLable);
        make.width.mas_equalTo(60);
    }];
    [_goodsTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_goodsPriceLable.mas_right);
        make.top.height.mas_equalTo(_goodsNameLable);
       make.width.mas_equalTo(150);
        make.right.mas_equalTo(weakSelf.contentView).offset(-10);
    }];
    
}
-(void)setGoodsModel:(GoodsModel *)goodsModel{
    _goodsModel=goodsModel;
    NSString *imageUrl=_goodsModel.goodsBigImageUrl;
    if (imageUrl==nil) {
        imageUrl=_goodsModel.goodsImageUrl;
    }
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:MCMallDefaultImg];
    _goodsNameLable.text=goodsModel.goodsName;
    _goodsPriceLable.text=[NSString stringWithFormat:@"%.2f元",goodsModel.sellPrice];
    _goodsTimeView.date=goodsModel.endTime;
}

@end
