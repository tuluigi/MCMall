//
//  GoodsModel.h
//  MCMall
//
//  Created by Luigi on 15/6/18.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsModel : NSObject
@property(nonatomic,copy)NSString *goodsID;
@property(nonatomic,copy)NSString *goodsName;
@property(nonatomic,copy)NSString *goodsOrignalPrice;
@property(nonatomic,copy)NSString *goodsPresentPrice;
@property(nonatomic,copy)NSString *goodsThumbImageUrl;
@property(nonatomic,copy)NSString *goodsBigImageUrl;
@property(nonatomic,strong)NSMutableArray *goodsImagesArray;

@end
