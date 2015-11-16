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
@property(nonatomic,strong)NSMutableArray *goodsArray;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIImageView *goodsImageView;
@property(nonatomic,strong)UILabel *goodsNameLable,*goodsPriceLable,*goodsCounetLable;
@property(nonatomic,strong)__block GoodsTimeView *goodsTimeView;
@property(nonatomic,assign)__block NSInteger currentIndex;
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
    _bgView=[[UIView alloc]  init];
    [self.contentView addSubview:_bgView];
    
    _goodsImageView=[[UIImageView alloc]  init];
    [_bgView addSubview:_goodsImageView];
    _goodsNameLable=[UILabel labelWithText:@"" font:[UIFont systemFontOfSize:16] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft];
    [_bgView addSubview:self.goodsNameLable];
    
    _goodsPriceLable=[UILabel labelWithText:@"" font:[UIFont systemFontOfSize:16] textColor:[UIColor redColor] textAlignment:NSTextAlignmentLeft];
    [_bgView addSubview:_goodsPriceLable];
    
    _goodsTimeView=[[GoodsTimeView alloc]  init];
    [_bgView addSubview:_goodsTimeView];
    
    _goodsCounetLable=[UILabel labelWithText:@"" font:[UIFont systemFontOfSize:14] textColor:[UIColor lightGrayColor] textAlignment:NSTextAlignmentLeft];
    [_bgView addSubview:_goodsCounetLable];
    WEAKSELF
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.contentView);
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
        make.left.mas_equalTo(weakSelf.goodsTimeView.mas_right).offset(10);
        make.centerY.mas_equalTo(weakSelf.goodsTimeView.mas_centerY);
        make.height.mas_equalTo(weakSelf.goodsTimeView);
        make.width.mas_equalTo(40);
    }];
    [[NSNotificationCenter defaultCenter] addObserverForName:MCMallTimerTaskNotification object:nil queue:[NSOperationQueue currentQueue] usingBlock:^(NSNotification * _Nonnull note) {
        if (weakSelf.goodsArray) {
            if ((weakSelf.currentIndex+1) ==weakSelf.goodsArray.count) {
                weakSelf.currentIndex=0;
            }else{
                weakSelf.currentIndex++;
            }
            GoodsModel *goodsModel=[weakSelf.goodsArray objectAtIndex:weakSelf.currentIndex];
            [weakSelf updateScrollCellWithGoodsModel:goodsModel];
        }
    }];
    [self getLimitGoodsList];
}
-(void)getLimitGoodsList{
    WEAKSELF
    [GoodsNetService getLimitedSalesGoodsListOnCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCodeSuccess) {
            if (nil==weakSelf.goodsArray) {
                weakSelf.goodsArray=[[NSMutableArray alloc]  init];
            }
            [weakSelf.goodsArray removeAllObjects];
            [weakSelf.goodsArray addObjectsFromArray:responseResult.responseData];
        }
    }];
}
-(void)setGoodsArray:(NSMutableArray *)goodsArray{
    _goodsArray=goodsArray;
    
}
-(void)updateScrollCellWithGoodsModel:(GoodsModel *)goodsModel{
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:goodsModel.goodsImageUrl] placeholderImage:MCMallDefaultImg];
    _goodsNameLable.text=goodsModel.goodsName;
    _goodsPriceLable.text=[NSString stringWithFormat:@"%f",goodsModel.vipPrice];
    _goodsTimeView.date=goodsModel.endTime;
    _goodsCounetLable.text=[NSString stringWithFormat:@"%ld",goodsModel.storeNum];
}
-(GoodsModel *)goodsModel{
    if (self.currentIndex<self.goodsArray.count) {
         return [self.goodsArray objectAtIndex:self.currentIndex];
    }else{
        return nil;
    }
}
@end
