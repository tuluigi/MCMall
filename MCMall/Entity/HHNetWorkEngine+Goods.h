//
//  HHNetWorkEngine+Goods.h
//  MCMall
//
//  Created by Luigi on 15/8/11.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "HHNetWorkEngine.h"

@interface HHNetWorkEngine (Goods)
/**
 *  获取商品类别
 *
 *  @param completion
 *
 *  @return
 */
-(HHNetWorkOperation *)getGoodsCategoryOnCompletionHandler:(HHResponseResultSucceedBlock)completion;
/**
 *  获取商品类别下的商品列表
 *
 *  @param catID      类别ID
 *  @param pid        第几页
 *  @param pageSize   每页多少条
 *  @param completion
 *
 *  @return
 */
-(HHNetWorkOperation *)getGoodsListWithCatID:(NSString *)catID
                                      userID:(NSString *)userID
                                     pageNum:(NSInteger)pid
                                    pageSize:(NSInteger)pageSize
                         onCompletionHandler:(HHResponseResultSucceedBlock)completion;
/**
 *  获取商品详情
 *
 *  @param goodsID
 *  @param completion
 *
 *  @return
 */
-(HHNetWorkOperation *)getGoodsDetailWithGoodsID:(NSString *)goodsID
                         onCompletionHandler:(HHResponseResultSucceedBlock)completion;
/**
 *  预定商品
 *
 *  @param goodsID
 *  @param userID
 *  @param phoneNum
 *  @param connact
 *  @param address
 *  @param completion
 *
 *  @return
 */
-(HHNetWorkOperation *)bookGoodsGoodsID:(NSString *)goodsID
                                 userID:(NSString *)userID
                               phoneNum:(NSString *)phoneNum
                                connact:(NSString *)connact
                                address:(NSString *)address
                             onCompletionHandler:(HHResponseResultSucceedBlock)completion;
@end
