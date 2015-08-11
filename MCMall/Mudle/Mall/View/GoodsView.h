//
//  GoodsView.h
//  MCMall
//
//  Created by Luigi on 15/8/10.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsModel;
typedef void(^GoodsViewDidClickedBlock)(GoodsModel *goodsModel);
@interface GoodsView : UIView
@property(nonatomic,strong)GoodsModel *goodsModel;
@property(nonatomic,copy)GoodsViewDidClickedBlock goodsViewClickBlock;
@end
