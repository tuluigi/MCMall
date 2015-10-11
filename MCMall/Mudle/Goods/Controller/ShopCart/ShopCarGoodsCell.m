//
//  ShopCarGoodsCell.m
//  MCMall
//
//  Created by Luigi on 15/9/27.
//  Copyright © 2015年 Luigi. All rights reserved.
//

#import "ShopCarGoodsCell.h"

@implementation ShopCarGoodsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.contentMode = UIViewContentModeScaleToFill;
    self.imageView.frame = CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y, 60, 60);
    self.textLabel.frame=CGRectMake(CGRectGetMaxX(self.imageView.frame)+10, 10, 200, 20);
}
@end
