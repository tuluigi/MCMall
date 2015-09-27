//
//  GoodsDetailPriceCell.h
//  MCMall
//
//  Created by Luigi on 15/9/27.
//  Copyright © 2015年 Luigi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsDetailPriceCell : UITableViewCell
-(void)setOrignalPrice:(CGFloat)orignalPrice sellPrice:(CGFloat)sellPrice vipPrice:(CGFloat)vipPrice goodsPoints:(CGFloat)goodsPoints endTime:(NSDate *)endTime storeNum:(NSInteger)storeNum;
+(CGFloat)goodsDetailPriceHeight;
@end
