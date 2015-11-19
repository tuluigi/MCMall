//
//  LimitGoodsInfinitScrollCell.h
//  MCMall
//
//  Created by Luigi on 15/11/19.
//  Copyright © 2015年 Luigi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsModel;
@interface LimitGoodsInfinitScrollCell : UITableViewCell
@property(nonatomic,strong,readonly)GoodsModel *goodsModel;
+(CGFloat)infiniteScrollCellHeight;
@end
