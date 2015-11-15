//
//  GoodsNetService.h
//  MCMall
//
//  Created by Luigi on 15/9/27.
//  Copyright © 2015年 Luigi. All rights reserved.
//

#import "HHBaseNetService.h"

@interface GoodsNetService : HHBaseNetService

/**
 *  预定商品
 *
 *  @param userID
 *  @param goodsID
 *  @param addressID
 *  @param num
 *  @param price
 *  @param points
 *  @param payMethod
 *  @param completionBlcok
 *
 *  @return
 */
+(HHNetWorkOperation *)addOrderWithUserID:(NSString *)userID
                                  goodsID:(NSString *)goodsID
                                addressID:(NSString *)addressID
                                   buyNum:(NSInteger)num
                               totalPrice:(CGFloat)price
                                   points:(NSInteger)points payMethod:(NSString *)payMethod
                      onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok;
//获取限时抢购商品列表
+(HHNetWorkOperation *)getLimitedSalesGoodsListOnCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok;

//获取品牌列表
+(HHNetWorkOperation *)getBrandListWithPageIndex:(NSInteger)pageIndex
                                        pageSize:(NSInteger )pageSize
                                           group:(NSInteger )group
                             onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok;

+(HHNetWorkOperation *)getNewGoodsListWithTag:(NSInteger)tag
                                               CatID:(NSString *)catID
                                             brandID:(NSString *)brandID
                                             pageNum:(NSInteger)pid
                                            pageSize:(NSInteger)pageSize
                                 onCompletionHandler:(HHResponseResultSucceedBlock)completion;

@end
