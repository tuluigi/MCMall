//
//  GoodsAddressAddViewController.h
//  MCMall
//
//  Created by Luigi on 15/8/13.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "BaseTableViewController.h"
@class GoodsModel ;
@class AddressModel;
@interface GoodsAddressAddViewController : BaseTableViewController
@property(nonatomic,strong)GoodsModel *goodsModel;

-(instancetype)initWithAddressModel:(AddressModel *)addresssModel;
@end
