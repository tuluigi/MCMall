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
    _brandImageView=[UIImageView new];
    [self.contentView addSubview:_brandImageView];
    
    _brandNameLable=[[UILabel alloc]  init];
    _brandNameLable.font=[UIFont systemFontOfSize:12];
    _brandNameLable.textAlignment=NSTextAlignmentLeft;
    _brandNameLable.textColor=[UIColor blackColor];
    [self.contentView addSubview:_brandNameLable];
    
    

    WEAKSELF
    [self.brandImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(weakSelf.contentView);
        make.height.mas_equalTo(150);
    }];
    [self.brandNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView).offset(15);
        make.top.mas_equalTo(weakSelf.brandImageView.mas_bottom).offset(5);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(20);
        make.bottom.mas_equalTo(weakSelf.contentView.mas_bottom).offset(-5);
    }];
}
-(void)setBrandModel:(BrandModel *)brandModel{
    _brandModel=brandModel;
    [_brandImageView sd_setImageWithURL:[NSURL URLWithString:brandModel.brandImgUrl] placeholderImage:MCMallDefaultImg];
    _brandNameLable.text=brandModel.brandName;
}
@end
