//
//  GoodsDetailPriceCell.m
//  MCMall
//
//  Created by Luigi on 15/9/27.
//  Copyright © 2015年 Luigi. All rights reserved.
//

#import "GoodsDetailPriceCell.h"
#import "GoodsTimeView.h"
@interface GoodsDetailPriceCell ()
@property(nonatomic,strong)UILabel *goodsNameLable,*storeLable;
@property(nonatomic,strong)UILabel *goodsPriceLable,*orignalPriceLable,*vipPriceLable;
@property(nonatomic,strong)GoodsTimeView *goodsTimeView;
@end

@implementation GoodsDetailPriceCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self onInitUI];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)onInitUI{
    WEAKSELF
    
    _goodsPriceLable=[[UILabel alloc]  initWithFrame:CGRectZero];
    _goodsPriceLable.textColor=[UIColor darkGrayColor];
    _goodsPriceLable.font=[UIFont systemFontOfSize:14];
    _goodsPriceLable.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:_goodsPriceLable];
    
    
    _orignalPriceLable=[UILabel labelWithText:@"" font:[UIFont systemFontOfSize:14] textColor:[UIColor darkGrayColor] textAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:_orignalPriceLable];
    
    _vipPriceLable=[UILabel labelWithText:@"" font:[UIFont systemFontOfSize:14] textColor:MCMallThemeColor textAlignment:NSTextAlignmentCenter];
    _vipPriceLable.numberOfLines=2;
    [self.contentView addSubview:_vipPriceLable];
    
    _storeLable=[[UILabel alloc]  init];
    _storeLable.font=[UIFont systemFontOfSize:14];
    _storeLable.textAlignment=NSTextAlignmentCenter;
    _storeLable.textColor=[UIColor darkGrayColor];
    [self.contentView addSubview:_storeLable];
    
    _goodsTimeView=[[GoodsTimeView alloc]  init];
    [self.contentView addSubview:_goodsTimeView];
    
  
    [_orignalPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView.mas_left).offset(8);
        make.right.mas_equalTo(weakSelf.contentView.mas_centerX);
        make.top.mas_equalTo(weakSelf.contentView.mas_top).offset(10);
        make.height.mas_equalTo(20);
    }];
    [_goodsPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.orignalPriceLable.mas_bottom).offset(5);
        make.left.width.height.mas_equalTo(weakSelf.orignalPriceLable);
    }];
    [_vipPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.orignalPriceLable);
        make.left.mas_equalTo(weakSelf.orignalPriceLable.mas_right);
        make.right.mas_equalTo(weakSelf.contentView.mas_right);
        make.bottom.mas_equalTo(weakSelf.goodsPriceLable.mas_bottom);
    }];
    
    [_goodsTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.left.mas_equalTo(weakSelf.orignalPriceLable);
        make.top.mas_equalTo(weakSelf.goodsPriceLable.mas_bottom).offset(5);
        make.height.mas_equalTo(23);
        make.bottom.mas_equalTo(weakSelf.contentView.mas_bottom).offset(-8);
    }];
    [_storeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.width.mas_equalTo(weakSelf.goodsTimeView);
        make.right.mas_equalTo(weakSelf.contentView.mas_right).offset(-8);
    }];
}
-(void)setOrignalPrice:(CGFloat)orignalPrice sellPrice:(CGFloat)sellPrice vipPrice:(CGFloat)vipPrice goodsPoints:(CGFloat)goodsPoints endTime:(NSDate *)endTime storeNum:(NSInteger)storeNum{
    NSString *orignalStr=[NSString stringWithFormat:@"原价:￥%.1f",orignalPrice];
    NSAttributedString *orignalAttStr=[orignalStr horizontalLineAttrStringWithTextColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:13]];
    _orignalPriceLable.attributedText=orignalAttStr;
    _goodsPriceLable.text=[NSString stringWithFormat:@"现价:￥%.1f",sellPrice];
    _vipPriceLable.text=[NSString stringWithFormat:@"专享价:\n %.1f积分+%.1f元",goodsPoints,vipPrice];
    _storeLable.text=[NSString stringWithFormat:@"剩余:%ld件",storeNum];
    self.goodsTimeView.date=endTime;
}
+(CGFloat)goodsDetailPriceHeight{
    return 90;
}
@end
