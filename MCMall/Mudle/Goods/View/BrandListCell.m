//
//  BrandListCell.m
//  MCMall
//
//  Created by Luigi on 15/11/15.
//  Copyright © 2015年 Luigi. All rights reserved.
//

#import "BrandListCell.h"
#import "BrandModel.h"
@interface BrandListCell ()
@property(nonatomic,strong)UIImageView *brandImageView;
@property(nonatomic,strong)UILabel *brandNameLable,*brandPriceLable;
@end

@implementation BrandListCell
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
       self.contentView.backgroundColor=[UIColor red:245 green:245 blue:245 alpha:1];
    UIView *bgView=[UIView new];
    bgView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:bgView];
//    bgView.layer.cornerRadius=5.0;
//    bgView.layer.masksToBounds=YES;
    
    self.selectionStyle=UITableViewCellSeparatorStyleNone;
    _brandImageView=[UIImageView new];
    [bgView addSubview:_brandImageView];
    
    _brandNameLable=[[UILabel alloc]  init];
    _brandNameLable.font=[UIFont systemFontOfSize:12];
    _brandNameLable.textAlignment=NSTextAlignmentLeft;
    _brandNameLable.textColor=[UIColor blackColor];
    [bgView addSubview:_brandNameLable];
    
    _brandPriceLable=[[UILabel alloc]  init];
    _brandPriceLable.font=[UIFont systemFontOfSize:12];
    _brandPriceLable.textAlignment=NSTextAlignmentLeft;
    _brandPriceLable.textColor=MCMallThemeColor;
    [bgView addSubview:_brandPriceLable];

    WEAKSELF
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.contentView);
        make.top.left.right.mas_equalTo(weakSelf.contentView);
        make.bottom.mas_equalTo(weakSelf.contentView.mas_bottom).offset(-5);
    }];
    [self.brandImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(bgView);
        make.height.mas_equalTo((SCREEN_WIDTH)/2.5);
    }];
    [self.brandNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bgView).offset(15);
        make.top.mas_equalTo(weakSelf.brandImageView.mas_bottom).offset(5);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(20);
        make.bottom.mas_equalTo(bgView.mas_bottom).offset(-5);
    }];
    [self.brandPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.brandNameLable.mas_right).offset(20);
        make.top.height.mas_equalTo(weakSelf.brandNameLable);
        make.width.mas_equalTo(100);
    }];
}
-(void)setBrandModel:(BrandModel *)brandModel{
    _brandModel=brandModel;
    [_brandImageView sd_setImageWithURL:[NSURL URLWithString:brandModel.brandImgUrl] placeholderImage:MCMallDefaultImg];
    _brandNameLable.text=brandModel.brandName;
    _brandPriceLable.text=brandModel.brandDeclaration;
}
@end
