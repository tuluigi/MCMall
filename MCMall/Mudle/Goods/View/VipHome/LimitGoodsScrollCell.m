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
    
    _goodsImageView=[[UIImageView alloc]  init];
    [_bgView addSubview:_goodsImageView];
    _goodsNameLable=[UILabel labelWithText:@"" font:[UIFont systemFontOfSize:16] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft];
    [_bgView addSubview:self.goodsNameLable];
    
    _goodsPriceLable=[UILabel labelWithText:@"" font:[UIFont systemFontOfSize:16] textColor:[UIColor redColor] textAlignment:NSTextAlignmentLeft];
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
    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.bgView.mas_left).offset(30);
        make.top.mas_equalTo(weakSelf.bgView.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 150));
    }];
    [_goodsNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.goodsImageView.mas_right).offset(15);
        make.top.mas_equalTo(weakSelf.goodsImageView.mas_top).offset(20);
        make.right.mas_equalTo(weakSelf.bgView.mas_right).offset(-20);
        make.height.mas_equalTo(20);
    }];
    [_goodsPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.goodsNameLable.mas_left);
        make.top.mas_equalTo(weakSelf.goodsNameLable.mas_bottom).offset(10);
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

-(void)updateScrollCellWithGoodsModel:(GoodsModel *)goodsModel{
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:goodsModel.goodsImageUrl] placeholderImage:MCMallDefaultImg];
    _goodsNameLable.text=goodsModel.goodsName;
    _goodsPriceLable.text=[NSString stringWithFormat:@"%.2f",goodsModel.vipPrice];
    _goodsTimeView.date=goodsModel.endTime;
    _goodsCounetLable.text=[NSString stringWithFormat:@"%ld ",goodsModel.storeNum];
}
-(GoodsModel *)goodsModel{
    if (self.currentIndex<self.goodsArray.count) {
         return [self.goodsArray objectAtIndex:self.currentIndex];
    }else{
        return nil;
    }
}
-(void)setGoodsModel:(GoodsModel *)goodsModel{
    [self updateScrollCellWithGoodsModel:goodsModel];
}
@end
