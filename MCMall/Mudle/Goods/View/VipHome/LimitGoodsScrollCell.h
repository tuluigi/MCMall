//
//  LimitGoodsScrollCell.h
//  MCMall
//
//  Created by Luigi on 15/11/16.
//  Copyright © 2015年 Luigi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  GoodsModel;
@interface LimitGoodsScrollCell : UITableViewCell

@property(nonatomic,strong)GoodsModel *goodsModel;
+(CGFloat)infiniteScrollCellHeight;
@end
