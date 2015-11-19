//
//  LimitGoodsScrollCell.m
//  MCMall
//
//  Created by Luigi on 15/11/16.
//  Copyright © 2015年 Luigi. All rights reserved.
//

#import "LimitGoodsScrollCell.h"
#import "GoodsNetService.h"
#import "GoodsTimeView.h"
#import "GoodsModel.h"
@interface LimitGoodsScrollCell ()
@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *goodsArray;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIImageView *goodsImageView;
@property(nonatomic,strong)UILabel *goodsNameLable,*goodsPriceLable,*goodsCounetLable;
@property(nonatomic,strong)__block GoodsTimeView *goodsTimeView;
@property(nonatomic,assign)__block NSInteger currentIndex,timeSpanIndex;
@end

@implementation LimitGoodsScrollCell
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
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
    _timeSpanIndex=1;
     self.contentView.backgroundColor=[UIColor red:245.0 green:245.0 blue:245.0 alpha:1];
    _bgView=[[UIView alloc]  init];
    _bgView.backgroundColor=[UIColor whiteColor];
    _bgView.layer.cornerRadius=5.0;
    _bgView.layer.masksToBounds=YES;
    [self.contentView addSubview:_bgView];
    
    UIView *topLineView=[UIView new];
    topLineView.backgroundColor=MCMallThemeColor;
    [_bgView addSubview:topLineView];
    _goodsImageView=[[UIImageView alloc]  init];
    [_bgView addSubview:_goodsImageView];
    _goodsImageView.layer.cornerRadius=5.0;
    _goodsImageView.layer.masksToBounds=YES;
    _goodsNameLable=[UILabel labelWithText:@"" font:[UIFont systemFontOfSize:16] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft];
    [_bgView addSubview:self.goodsNameLable];
    
    _goodsPriceLable=[[UILabel alloc]  init];
    _goodsPriceLable.textAlignment=NSTextAlignmentLeft;
    [_bgView addSubview:_goodsPriceLable];
    
    _goodsTimeView=[[GoodsTimeView alloc]  init];
    [_bgView addSubview:_goodsTimeView];
    
    _goodsCounetLable=[UILabel labelWithText:@"" font:[UIFont systemFontOfSize:14] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
    _goodsCounetLable.backgroundColor=[UIColor lightGrayColor];
    _goodsCounetLable.layer.cornerRadius=5.0;
    _goodsCounetLable.layer.masksToBounds=YES;
    [_bgView addSubview:_goodsCounetLable];
    WEAKSELF
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(5, 5, 5, 5));
    }];
    [topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(weakSelf.bgView);
        make.height.mas_equalTo(3);
    }];
    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.bgView.mas_left).offset(30);
        make.top.mas_equalTo(weakSelf.bgView.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(80*OCCOMMONSCALE, 120*OCCOMMONSCALE));
    }];
    [_goodsNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.goodsImageView.mas_right).offset(15);
        make.top.mas_equalTo(weakSelf.goodsImageView.mas_top).offset(20);
        make.right.mas_equalTo(weakSelf.bgView.mas_right).offset(-20);
        make.height.mas_equalTo(20);
    }];
    [_goodsPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.goodsNameLable.mas_left);
        make.bottom.mas_equalTo(weakSelf.goodsImageView.mas_bottom).offset(-10);
        make.right.mas_equalTo(weakSelf.goodsNameLable);
        make.height.mas_equalTo(weakSelf.goodsNameLable);
    }];
    [_goodsTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.bgView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(150, 25));
        make.top.mas_equalTo(weakSelf.goodsImageView.mas_bottom).offset(10);
        make.bottom.mas_equalTo(weakSelf.bgView.mas_bottom).offset(-10);
    }];
    [_goodsCounetLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.goodsTimeView.mas_right).offset(5);
        make.centerY.mas_equalTo(weakSelf.goodsTimeView.mas_centerY);
        make.height.mas_equalTo(20);
        make.width.mas_greaterThanOrEqualTo(20);
    }];
}
-(void)setGoodsModel:(GoodsModel *)goodsModel{
    _goodsModel=goodsModel;
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:goodsModel.goodsImageUrl] placeholderImage:MCMallDefaultImg];
    _goodsNameLable.text=goodsModel.goodsName;
    NSMutableAttributedString *attrString1=[[NSMutableAttributedString alloc]  initWithString:[NSString stringWithFormat:@"￥%.1f",goodsModel.orignalPrice]]
    ;
    [attrString1 addAttributes:@{NSForegroundColorAttributeName:MCMallThemeColor,NSFontAttributeName:[UIFont boldSystemFontOfSize:20]} range:NSMakeRange(0, attrString1.length) ];
    
    NSMutableAttributedString *attrString2=[[NSMutableAttributedString alloc]  initWithString:[NSString stringWithFormat:@"  ￥%.1f",goodsModel.sellPrice]]
    ;
    [attrString2 addAttributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:12]} range:NSMakeRange(0, attrString2.length) ];
    [attrString1  appendAttributedString:attrString2];
    _goodsPriceLable.attributedText=attrString1;
//    _goodsPriceLable.text=[NSString stringWithFormat:@"￥%.2f ￥%.2f",goodsModel.orignalPrice,goodsModel.sellPrice];
    _goodsTimeView.date=goodsModel.endTime;
    _goodsCounetLable.text=[NSString stringWithFormat:@"%ld ",goodsModel.storeNum];

}
+(CGFloat)infiniteScrollCellHeight{
    return 45+120*OCCOMMONSCALE;
}
@end
