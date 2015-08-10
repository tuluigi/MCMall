//
//  MallListCell.m
//  MCMall
//
//  Created by Luigi on 15/8/10.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "MallListCell.h"
#import "GoodsModel.h"
@interface MallListCell ()
@property(nonatomic,strong)UIImageView *goodsImageView;
@property(nonatomic,strong)UILabel *goodsNameLable, *goodsPriceLable,*timeLable;
@end

@implementation MallListCell
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self onInitUI];
        WEAKSELF
        [[NSNotificationCenter defaultCenter] addObserverForName:MCMallTimerTaskNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
            weakSelf.timeLable.text=@"";
        }];
    }
    return self;
}
-(void)onInitUI{
    WEAKSELF
    _goodsImageView=[UIImageView new];
    [self.contentView addSubview:_goodsImageView];
    
    _goodsNameLable=[[UILabel alloc]  init];
    _goodsNameLable.font=[UIFont systemFontOfSize:12];
    _goodsNameLable.textAlignment=NSTextAlignmentCenter;
    _goodsNameLable.textColor=[UIColor blackColor];
    [self.contentView addSubview:_goodsNameLable];
    
    _goodsPriceLable=[[UILabel alloc]  init];
    _goodsPriceLable.font=[UIFont systemFontOfSize:12];
    _goodsPriceLable.textAlignment=NSTextAlignmentCenter;
    _goodsPriceLable.textColor=[UIColor blackColor];
    [self.contentView addSubview:_goodsPriceLable];
    
    _timeLable=[[UILabel alloc]  init];
    _timeLable.font=[UIFont systemFontOfSize:12];
    _timeLable.textAlignment=NSTextAlignmentCenter;
    _timeLable.textColor=[UIColor blackColor];
    [self.contentView addSubview:_timeLable];
    
    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(weakSelf.contentView);
        make.height.mas_equalTo(100);
    }];
    [_goodsNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView.mas_left).offset(10);
        make.top.mas_equalTo(_goodsImageView.mas_bottom);
        make.width.mas_lessThanOrEqualTo(100);
        make.height.mas_equalTo(20);
        make.bottom.mas_equalTo(weakSelf.mas_bottom).offset(10);
    }];
    [_goodsPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_goodsNameLable.mas_right);
        make.top.height.mas_equalTo(_goodsNameLable);
        make.width.mas_lessThanOrEqualTo(100);
    }];
    [_timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_goodsPriceLable.mas_right);
        make.top.height.mas_equalTo(_goodsNameLable);
        make.width.mas_lessThanOrEqualTo(100);
        make.right.mas_equalTo(weakSelf.contentView).offset(-10);
    }];
}
-(void)setGoodsModel:(GoodsModel *)goodsModel{
    _goodsModel=goodsModel;
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:goodsModel.goodsBigImageUrl] placeholderImage:MCMallDefaultImg];
    _goodsNameLable.text=goodsModel.goodsName;
    _goodsPriceLable.text=goodsModel.goodsOrignalPrice;
    _timeLable.text=@"";
}
@end
