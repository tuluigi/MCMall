//
//  MallGoodsListCell.m
//  MCMall
//
//  Created by Luigi on 15/8/10.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "MallGoodsListCell.h"
#import "GoodsView.h"

@interface MallGoodsListCell ()
@property(nonatomic,strong)GoodsView *goodsView0,*goodsView1;
@end

@implementation MallGoodsListCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self onInitUI];
    }
    return self;
}
-(void)onInitUI{
        WEAKSELF
    _goodsView0=[[GoodsView alloc]  init];
    [self.contentView addSubview:_goodsView0];
    _goodsView0.goodsViewClickBlock=^(GoodsModel *goodsModel){
        if (weakSelf.goodsViewClickedBlock) {
            weakSelf.goodsViewClickedBlock(goodsModel);
        }
    };
    _goodsView1=[[GoodsView alloc]  init];
    _goodsView1.goodsViewClickBlock=^(GoodsModel *goodsModel){
        if (weakSelf.goodsViewClickedBlock) {
            weakSelf.goodsViewClickedBlock(goodsModel);
        }
    };
    [self.contentView addSubview:_goodsView1];


    [_goodsView0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(weakSelf.contentView);
        make.right.mas_equalTo(weakSelf.contentView.mas_centerX);
    }];
    
    [_goodsView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(weakSelf.contentView);
        make.left.mas_equalTo(weakSelf.contentView.mas_centerX);
    }];
}
-(void)setGoodsModel0:(GoodsModel *)goodsModel0 goodsModel1:(GoodsModel *)goodsModel1{
    self.goodsView0.goodsModel=goodsModel0;
    self.goodsView1.goodsModel=goodsModel1;
}
+(CGFloat)mallGoodsListCellHeight{
    return 100;
}
@end
