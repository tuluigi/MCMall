//
//  GoodsCollectionViewCell.m
//  MCMall
//
//  Created by Luigi on 15/10/11.
//  Copyright © 2015年 Luigi. All rights reserved.
//

#import "GoodsCollectionViewCell.h"
#import "GoodsModel.h"
#import "GoodsTimeView.h"
@interface GoodsCollectionViewCell ()
@property(nonatomic,strong)UIImageView *goodsImageView;
@property(nonatomic,strong)UILabel *goodsNameLable,*storeLable;
@property(nonatomic,strong)UILabel *goodsPriceLable,*orignalPriceLable,*vipPriceLable;
@property(nonatomic,strong)GoodsTimeView *goodsTimeView;
@end

@implementation GoodsCollectionViewCell
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MCMallTimerTaskNotification object:nil];
}
-(instancetype)init{
    self=[super initWithFrame:CGRectZero];
    if (self) {
        
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self onInitUI];
    }
    return self;
}
-(void)onInitUI{
    WEAKSELF
    self.layer.borderColor=[UIColor red:243 green:243 blue:243 alpha:1].CGColor;
    self.layer.borderWidth=0.5;
    _goodsImageView=[UIImageView new];
    [self.contentView addSubview:_goodsImageView];
    
    _goodsNameLable=[[UILabel alloc]  init];
    _goodsNameLable.numberOfLines=1;
    _goodsNameLable.font=[UIFont systemFontOfSize:14];
    _goodsNameLable.textAlignment=NSTextAlignmentCenter;
    _goodsNameLable.textColor=[UIColor blackColor];
    [self.contentView addSubview:_goodsNameLable];
    
    _goodsPriceLable=[[UILabel alloc]  initWithFrame:CGRectZero];
    _goodsPriceLable.textColor=[UIColor darkGrayColor];
    _goodsPriceLable.font=[UIFont systemFontOfSize:12];
    _goodsPriceLable.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:_goodsPriceLable];
    
    
    _orignalPriceLable=[UILabel labelWithText:@"" font:[UIFont systemFontOfSize:12] textColor:[UIColor darkGrayColor] textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_orignalPriceLable];
    
    _vipPriceLable=[UILabel labelWithText:@"" font:[UIFont systemFontOfSize:13] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:_vipPriceLable];
    
    _storeLable=[[UILabel alloc]  init];
    _storeLable.font=[UIFont systemFontOfSize:12];
    _storeLable.textAlignment=NSTextAlignmentRight;
    _storeLable.textColor=[UIColor darkGrayColor];
    [self.contentView addSubview:_storeLable];
    
    _goodsTimeView=[[GoodsTimeView alloc]  init];
    [self.contentView addSubview:_goodsTimeView];
    
    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.contentView).offset(5);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-5);
        make.height.mas_equalTo(200);
    }];
    [_goodsNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(5);
        make.top.mas_equalTo(weakSelf.goodsImageView.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-5);
    }];
    [_orignalPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(3);
        make.right.mas_equalTo(self.contentView.mas_centerX);
        make.top.mas_equalTo(weakSelf.goodsNameLable.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
    }];
    [_goodsPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right);
        make.top.mas_equalTo(weakSelf.orignalPriceLable);
        make.left.mas_equalTo(weakSelf.orignalPriceLable.mas_right);
        make.height.mas_equalTo(weakSelf.orignalPriceLable.mas_height);
    }];
    [_vipPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.orignalPriceLable.mas_bottom).offset(5);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.left.mas_equalTo(self.contentView.mas_left);
        make.height.mas_equalTo(20);
        
    }];
    
    [_goodsTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.contentView);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.top.mas_equalTo(weakSelf.vipPriceLable.mas_bottom).offset(5);
        make.height.mas_equalTo(23);
    }];
    [_storeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.goodsTimeView.mas_bottom).offset(5);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-5);
        make.height.mas_equalTo(20);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-5);
    }];
}
-(void)setGoodsModel:(GoodsModel *)goodsModel{
    _goodsModel=goodsModel;
    
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:goodsModel.goodsImageUrl] placeholderImage:MCMallDefaultImg];
    _goodsNameLable.text=_goodsModel.goodsName;
    _storeLable.text=[NSString stringWithFormat:@"剩余:%ld件",_goodsModel.storeNum];
    self.goodsTimeView.date=_goodsModel.endTime;
    NSString *orignalStr=[NSString stringWithFormat:@"原价:￥%.1f",_goodsModel.orignalPrice];
    NSAttributedString *orignalAttStr=[orignalStr horizontalLineAttrStringWithTextColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:13]];
    _orignalPriceLable.attributedText=orignalAttStr;
    _goodsPriceLable.text=[NSString stringWithFormat:@"现价:￥%.1f",_goodsModel.sellPrice];
    
    _vipPriceLable.attributedText=[self vipAttrstring];
    if (_goodsModel) {
        self.hidden=NO;
    }else{
        self.hidden=YES;
    }
}
-(NSAttributedString *)vipAttrstring{
    NSString *nameStr=@"专享价:";
    NSString *valueStr=[NSString stringWithFormat:@"%.1f积分+%.1f元",self.goodsModel.goodsPoints,self.goodsModel.vipPrice];
    NSMutableAttributedString *attrString=[[NSMutableAttributedString alloc]  initWithString:[nameStr stringByAppendingString:valueStr]]
    ;
    [attrString addAttributes:@{NSForegroundColorAttributeName:MCMallThemeColor,NSFontAttributeName:[UIFont systemFontOfSize:13]} range:[attrString.string rangeOfString:nameStr]];
    return attrString;
}
@end
