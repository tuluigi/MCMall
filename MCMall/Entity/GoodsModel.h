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
@property(nonatomic,copy)NSString *deliverNotice;//发货须知
@property(nonatomic,copy)NSString *goodsRemark;//商家自荐

//UI用
@property(nonatomic,assign)__block CGSize goodsImageSize;

@end

@interface OrderModel : BaseModel
@property(nonatomic,copy)NSString *orderID;
@property(nonatomic,copy)NSString *orderTime;
@property(nonatomic,copy)NSString *goodsID;
@property(nonatomic,copy)NSString *goodsName;
@property(nonatomic,copy)NSString *goodsThumbImageUrl;
@property(nonatomic,assign)CGFloat goodsPrice;//价钱
@property(nonatomic,assign)NSInteger goodsNum;//商品数量
@property(nonatomic,assign)CGFloat deductPoints;//抵扣积分
@property(nonatomic,assign)CGFloat totalPrice;//总价
@end