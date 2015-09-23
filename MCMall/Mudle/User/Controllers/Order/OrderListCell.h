//
//  OrderListCell.h
//  MCMall
//
//  Created by Luigi on 15/9/23.
//  Copyright © 2015年 Luigi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderModel;
@interface OrderListCell : UITableViewCell
@property(nonatomic,strong)OrderModel *orderModel;
@end
