//
//  GoodsView.m
//  MCMall
//
//  Created by Luigi on 15/8/10.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "GoodsView.h"
#import "GoodsModel.h"
#import <CoreText/CoreText.h>
#import "DTAttributedLabel.h"
@interface GoodsView ()
@property(nonatomic,strong)UIImageView *goodsImageView;
@property(nonatomic,strong)UILabel *goodsNameLable,*timeLable,*storeLable;
@property(nonatomic,strong)DTAttributedLabel *goodsPriceLable;
@end

@implementation GoodsView
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MCMallTimerTaskNotification object:nil];
}
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
    [[NSNotificationCenter defaultCenter] addObserverForName:MCMallTimerTaskNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        [weakSelf updateTimeLableText];
    }];
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]  initWithTarget:self action:@selector(handTapGesture:)];
    [self addGestureRecognizer:tapGesture];
    self.layer.borderColor=[UIColor red:243 green:243 blue:243 alpha:1].CGColor;
    self.layer.borderWidth=0.5;
    _goodsImageView=[UIImageView new];
    [self addSubview:_goodsImageView];
    
    _goodsNameLable=[[UILabel alloc]  init];
    _goodsNameLable.numberOfLines=2;
    _goodsNameLable.font=[UIFont systemFontOfSize:14];
    _goodsNameLable.textAlignment=NSTextAlignmentLeft;
    _goodsNameLable.textColor=[UIColor blackColor];
    [self addSubview:_goodsNameLable];
    
    _goodsPriceLable=[[DTAttributedLabel alloc]  init];
    [self addSubview:_goodsPriceLable];
    
    _storeLable=[[UILabel alloc]  init];
    _storeLable.font=[UIFont systemFontOfSize:12];
    _storeLable.textAlignment=NSTextAlignmentRight;
    _storeLable.textColor=[UIColor darkGrayColor];
    [self addSubview:_storeLable];
    
    
    _timeLable=[[UILabel alloc]  init];
    _timeLable.font=[UIFont systemFontOfSize:12];
    _timeLable.textAlignment=NSTextAlignmentLeft;
    _timeLable.textColor=[UIColor blackColor];
    [self addSubview:_timeLable];
    
    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(weakSelf).offset(10);
        make.right.mas_equalTo(weakSelf).offset(-10);
        make.height.mas_equalTo(200);
    }];
    [_goodsNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.mas_left).offset(5);
        make.top.mas_equalTo(_goodsImageView.mas_bottom);
        make.height.mas_equalTo(30);
        make.right.mas_equalTo(weakSelf.mas_right).offset(-5);
    }];
    [_goodsPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf);
        make.top.mas_equalTo(_goodsNameLable.mas_bottom).offset(10);
        //  make.right.equalTo(weakSelf.mas_centerX);
        make.height.mas_equalTo(20);
    }];
    [_storeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_goodsPriceLable.mas_right);
        make.centerY.height.mas_equalTo(_goodsPriceLable);
        make.right.mas_equalTo(_goodsNameLable);
    }];
    [_timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_goodsNameLable);
        make.top.mas_equalTo(_goodsPriceLable.mas_bottom).offset(5);
        make.bottom.mas_equalTo(weakSelf).offset(-10);
    }];
}
-(void)setGoodsModel:(GoodsModel *)goodsModel{
    _goodsModel=goodsModel;
    
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:goodsModel.goodsImageUrl] placeholderImage:MCMallDefaultImg];
    _goodsNameLable.text=_goodsModel.goodsName;
    _storeLable.text=[NSString stringWithFormat:@"剩余%ld件",_goodsModel.storeNum];

    NSAttributedString *priceAttrStr=[NSString attributedStringWithOrignalPrice:_goodsModel.orignalPrice orignalFontSize:16 newPrice:_goodsModel.presenPrice newFontSize:12];
    _goodsPriceLable.attributedString=priceAttrStr;
    if (_goodsModel) {
        self.hidden=NO;
    }else{
        self.hidden=YES;
    }
    [self updateTimeLableText];
}
-(void)updateTimeLableText{
    if (_goodsModel.endTime) {
        NSDate *earlyDate=[_goodsModel.endTime  earlierDate:[NSDate date]];
        if (earlyDate==_goodsModel.endTime) {
            NSString *timeStr=@"还有天0小时0分0秒";
            _timeLable.text=timeStr;
        }else{
            NSDateComponents *components=[_goodsModel.endTime componentsToDate:[NSDate date]];
            NSString *timeStr=[NSString stringWithFormat:@"还有%ld天%ld小时%ld分%ld秒",components.day,components.hour,components.minute,components.second];
            _timeLable.text=timeStr;
        }
    }
}
-(void)handTapGesture:(UITapGestureRecognizer *)tapGesture{
    if (self.goodsViewClickBlock) {
        self.goodsViewClickBlock(self.goodsModel);
    }
}
@end
