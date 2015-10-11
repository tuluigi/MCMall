//
//  GoodsAddressListCell.m
//  MCMall
//
//  Created by Luigi on 15/9/27.
//  Copyright © 2015年 Luigi. All rights reserved.
//

#import "GoodsAddressListCell.h"
#import "AddressModel.h"
@interface GoodsAddressListCell ()
@end

@implementation GoodsAddressListCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle=UITableViewCellSelectionStyleGray;
        self.textLabel.font=[UIFont boldSystemFontOfSize:16];
        self.textLabel.textColor=[UIColor blackColor];
        self.detailTextLabel.textColor=[UIColor darkGrayColor];
        self.detailTextLabel.font=[UIFont systemFontOfSize:14];
        self.detailTextLabel.numberOfLines=2;
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
-(void)setAddressModel:(AddressModel *)addressModel{
    _addressModel=addressModel;
    NSString *defatultStr=@"";
    if (addressModel.isDefault) {
        defatultStr=@"默认地址";
    }
    self.textLabel.text=[[[[_addressModel.receiverName stringByAppendingString:@"   "] stringByAppendingString:_addressModel.receiverTel] stringByAppendingString:@"   "] stringByAppendingString:defatultStr];
    self.detailTextLabel.text=_addressModel.addressDetail;
}
@end
