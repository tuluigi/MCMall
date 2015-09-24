//
//  GoodsAddressAddController.h
//  MCMall
//
//  Created by Luigi on 15/8/13.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "BaseTableViewController.h"
@class AddressModel;
@protocol GoodsAddressViewControllerDelegate <NSObject>

-(void)didSelectUserReceiveAddresss:(AddressModel *)addressModel;

@end

@interface GoodsAddressViewController : BaseTableViewController
@property(nonatomic,assign)BOOL isSelect;
@property(nonatomic,weak)id<GoodsAddressViewControllerDelegate>delegate;
@end
