//
//  GoodsAddressAddController.h
//  MCMall
//
//  Created by Luigi on 15/9/7.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "BaseTableViewController.h"

@class AddressModel;


typedef void(^DidAddressModelChangedBlock)(AddressModel *address ,BOOL isAdd);
@interface GoodsAddressAddController : BaseTableViewController
-(instancetype)initWithAddressModel:(AddressModel *)addresssModel;
@property(nonatomic,copy)DidAddressModelChangedBlock addressModelChangeBlock;

@end
