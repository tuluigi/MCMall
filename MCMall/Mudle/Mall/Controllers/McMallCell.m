//
//  McMallCell.m
//  MCMall
//
//  Created by Luigi on 15/6/18.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "McMallCell.h"

@interface McMallCell ()
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UILabel *titleLable;
@end


@implementation McMallCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}
-(void)onInitUI{
    _bgView=[[UIView alloc]  init];
    _bgView.layer.cornerRadius=5.0;
    _bgView.layer.masksToBounds=YES;
    [self.contentView addSubview:_bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0));
    }];
    
    for (NSInteger i=0; i<3; i++) {
        UIImageView *logoImgView=[[UIImageView alloc]  init];
        [_bgView addSubview:logoImgView];
        [logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
        }];
    }
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setGoodsModel:(GoodsModel *)goodsModel{
    _goodsModel=goodsModel;
}
@end
