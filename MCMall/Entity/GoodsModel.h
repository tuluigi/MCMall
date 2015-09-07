//
//  GoodsModel.h
//  MCMall
//
//  Created by Luigi on 15/6/18.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "BaseModel.h"

@interface CategoryModel : BaseModel
@property(nonatomic,copy)NSString *catID;
@property(nonatomic,copy)NSString *catName;
@end

@interface GoodsModel : BaseModel
@property(nonatomic,copy)NSString *goodsID;
@property(nonatomic,copy)NSString *goodsName;
@property(nonatomic,copy)NSString *goodsImageUrl;
@property(nonatomic,copy)NSString *goodsBigImageUrl;
@property(nonatomic,assign)CGFloat orignalPrice;//市场价
@property(nonatomic,assign)CGFloat sellPrice;//直销价
@property(nonatomic,assign)CGFloat vipPrice;//专享价格
@property(nonatomic,assign)CGFloat deductionPoint;//抵扣积分
@property(nonatomic,assign)NSInteger storeNum;//库存
@property(nonatomic,strong)NSDate   *endTime;
@property(nonatomic,copy)NSString *goodsDetail;
@end
