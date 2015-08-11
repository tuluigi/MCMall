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
@property(nonatomic,assign)CGFloat orignalPrice;
@property(nonatomic,assign)CGFloat presenPrice;
@property(nonatomic,assign)NSInteger storeNum;//库存
@property(nonatomic,strong)NSDate   *endTime;
@end
