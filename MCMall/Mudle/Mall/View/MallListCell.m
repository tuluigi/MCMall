//
//  MallListCell.m
//  MCMall
//
//  Created by Luigi on 15/8/10.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "MallListCell.h"
#import "GoodsModel.h"
#import <CoreText/CoreText.h>
#import "TTTAttributedLabel.h"
@interface MallListCell ()
@property(nonatomic,strong)UIImageView *goodsImageView;
@property(nonatomic,strong)UILabel *goodsNameLable, *goodsPriceLable;
@property(nonatomic,strong)TTTAttributedLabel *timeLable;
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
            [weakSelf updateTimeLableText];
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
    _goodsPriceLable.textColor=MCMallThemeColor;
    [self.contentView addSubview:_goodsPriceLable];
    
    _timeLable=[[TTTAttributedLabel alloc]  initWithFrame:CGRectZero];
    _timeLable.font=[UIFont systemFontOfSize:12];
    _timeLable.textAlignment=NSTextAlignmentCenter;
    _timeLable.textColor=[UIColor blackColor];
    [self.contentView addSubview:_timeLable];
    
    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.mas_equalTo(weakSelf.contentView);
        make.height.mas_equalTo(100);
    }];
    [_goodsNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView.mas_left).offset(10);
        make.top.mas_equalTo(_goodsImageView.mas_bottom).offset(5);
        make.width.mas_lessThanOrEqualTo(120);
        make.height.mas_lessThanOrEqualTo(20);
        make.bottom.mas_equalTo(weakSelf.contentView.mas_bottom).offset(-10);
    }];
    
    [_goodsPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_goodsNameLable.mas_right);
        make.top.height.mas_equalTo(_goodsNameLable);
        make.width.mas_lessThanOrEqualTo(100);
    }];
    [_timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_goodsPriceLable.mas_right);
        make.top.height.mas_equalTo(_goodsNameLable);
       // make.width.mas_lessThanOrEqualTo(100);
        make.right.mas_equalTo(weakSelf.contentView).offset(-10);
    }];
    
}
-(void)setGoodsModel:(GoodsModel *)goodsModel{
    _goodsModel=goodsModel;
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:goodsModel.goodsImageUrl] placeholderImage:MCMallDefaultImg];
    _goodsNameLable.text=goodsModel.goodsName;
    _goodsPriceLable.text=[NSString stringWithFormat:@"%.2f元",goodsModel.presenPrice];
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
            
            NSString *dayStr=[NSString stringWithFormat:@"%ld",components.day];
            NSString *hourStr=[NSString stringWithFormat:@"%ld",components.hour];
            NSString *miniutStr=[NSString stringWithFormat:@"%ld",components.minute];
            NSString *secondStr=[NSString stringWithFormat:@"%ld",components.second];
            NSString *timeStr=[NSString stringWithFormat:@"还有%@天%@小时%@分%@秒",dayStr,hourStr,miniutStr,secondStr];
            NSMutableAttributedString *attTimeStr=[[NSMutableAttributedString alloc]  initWithString:timeStr];
            [attTimeStr beginEditing];
            [attTimeStr addAttributes:@{(id)kCTForegroundColorAttributeName:(id)[MCMallThemeColor CGColor]} range:[timeStr rangeOfString:secondStr]];
            [attTimeStr endEditing];
            [attTimeStr addAttributes:@{(id)kCTForegroundColorAttributeName:(id)[MCMallThemeColor CGColor]} range:[timeStr rangeOfString:hourStr]];
            [attTimeStr addAttributes:@{(id)kCTForegroundColorAttributeName:(id)[MCMallThemeColor CGColor]} range:[timeStr rangeOfString:miniutStr]];
            
            [attTimeStr addAttributes:@{(id)kCTForegroundColorAttributeName:(id)[MCMallThemeColor CGColor]} range:[timeStr rangeOfString:dayStr]];
            [_timeLable setText:attTimeStr];
        }
    }
}
@end
