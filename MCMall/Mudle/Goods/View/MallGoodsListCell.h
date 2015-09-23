//
//  MallGoodsListCell.h
//  MCMall
//
//  Created by Luigi on 15/8/10.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsModel;
typedef void(^HandleGoodsViewClickedBlock)(GoodsModel *goodsModel);

@interface MallGoodsListCell : UITableViewCell
-(void)setGoodsModel0:(GoodsModel *)goodsModel0 goodsModel1:(GoodsModel *)goodsModel1;
@property(nonatomic,copy)HandleGoodsViewClickedBlock goodsViewClickedBlock;
@end