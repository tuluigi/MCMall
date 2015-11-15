//
//  GoodsNetService.m
//  MCMall
//
//  Created by Luigi on 15/9/27.
//  Copyright © 2015年 Luigi. All rights reserved.
//

#import "GoodsNetService.h"
#import "MCMallAPI.h"
#import "GoodsModel.h"
#import "BrandModel.h"
@implementation GoodsNetService
+(HHNetWorkOperation *)addOrderWithUserID:(NSString *)userID
                                  goodsID:(NSString *)goodsID
                                addressID:(NSString *)addressID
                                   buyNum:(NSInteger)num
                               totalPrice:(CGFloat)price
                                   points:(NSInteger)points payMethod:(NSString *)payMethod
                      onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok{
    NSString *apiPath=[MCMallAPI bookGoodsAPI];
    NSDictionary *postDic=[NSDictionary dictionaryWithObjectsAndKeys:userID,@"userid",goodsID,@"goodid",addressID,@"addrid",@(num),@"num",@(price),@"money",@(points),@"point",payMethod,@"payment", nil];
    HHNetWorkOperation *op= [[HHNetWorkEngine sharedHHNetWorkEngine] startRequestWithUrl:apiPath parmars:postDic method:HHGET onCompletionHander:^(id responseData, NSError *error) {
        [HHBaseNetService parseMcMallResponseObject:responseData modelClass:nil error:error onCompletionBlock:^(HHResponseResult *responseResult) {
            if (completionBlcok) {
                completionBlcok(responseResult);
            }
        }];
    }];
    return op;
}
//获取限时抢购商品列表
+(HHNetWorkOperation *)getLimitedSalesGoodsListOnCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok{
    NSString *apiPath=[[MCMallAPI prefixPath] stringByAppendingString:@"rolllimitlist"];
    HHNetWorkOperation *op= [[HHNetWorkEngine sharedHHNetWorkEngine] startRequestWithUrl:apiPath parmars:nil method:HHGET onCompletionHander:^(id responseData, NSError *error) {
        [HHBaseNetService parseMcMallResponseObject:responseData modelClass:[GoodsModel class] error:error onCompletionBlock:^(HHResponseResult *responseResult) {
            if (completionBlcok) {
                completionBlcok(responseResult);
            }
        }];
    }];
    return op;
}
+(HHNetWorkOperation *)getBrandListWithPageIndex:(NSInteger)pageIndex
                                        pageSize:(NSInteger )pageSize
                                           group:(NSInteger )group
                             onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok{
    NSString *apiPath=[[MCMallAPI prefixPath] stringByAppendingString:@"brandlist"];
    NSMutableDictionary *postDic=[[NSMutableDictionary alloc]  initWithObjectsAndKeys:@(pageIndex),@"pageno",@(pageSize),@"records", nil];
    if (group==MCVipGoodsItemTagGroupMother) {
        [postDic setObject:@"0" forKey:@"brandid"];
    }else if (group==MCVipGoodsItemTagGroupDiscountGoods){
        [postDic setObject:@"9" forKey:@"brandid"];
    }
    HHNetWorkOperation *op= [[HHNetWorkEngine sharedHHNetWorkEngine] startRequestWithUrl:apiPath parmars:postDic method:HHGET onCompletionHander:^(id responseData, NSError *error) {
        [HHBaseNetService parseMcMallResponseObject:responseData modelClass:[BrandModel class] error:error onCompletionBlock:^(HHResponseResult *responseResult) {
            if (completionBlcok) {
                completionBlcok(responseResult);
            }
        }];
    }];
    return op;
}
+(HHNetWorkOperation *)getNewGoodsListWithTag:(NSInteger)tag
                                           CatID:(NSString *)catID
                                         brandID:(NSString *)brandID
                                     pageNum:(NSInteger)pid
                                    pageSize:(NSInteger)pageSize
                         onCompletionHandler:(HHResponseResultSucceedBlock)completion{
    NSString *apiPath=[MCMallAPI prefixPath];
    catID=[NSString stringByReplaceNullString:catID];
    NSMutableDictionary *postDic=[[NSMutableDictionary alloc]  initWithObjectsAndKeys:@(pid),@"pageno",@(pageSize),@"records",catID,@"classify",[HHUserManager userID],@"userid" ,nil];
    switch (tag) {
        case MCVipGoodsItemTagTimeLimitedSales:{//获取限时抢购列表
            apiPath=[apiPath stringByAppendingString:@"limitlist"];
        } break;
        case MCVipGoodsItemTagImmediatelySend:{//获取即时达3H商品列表
            apiPath=[apiPath stringByAppendingString:@"instantlist"];
        } break;
        case MCVipGoodsItemTagGroupMother:{//获取尝鲜妈妈团的产品列表
            apiPath=[apiPath stringByAppendingString:@"grouplist1"];
            brandID=StringNotNil(brandID);
            [postDic setObject:brandID forKey:@"brandid"];
        } break;
        case MCVipGoodsItemTagGroupDiscountGoods:{//获取惠生活的产品列表
            apiPath=[apiPath stringByAppendingString:@"grouplist2"];
            brandID=StringNotNil(brandID);
             [postDic setObject:brandID forKey:@"brandid"];
        } break;
        default:
            break;
    }
  
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine]  startRequestWithUrl:apiPath parmars:postDic method:HHGET onCompletionHander:^(id responseData, NSError *error) {
        [HHBaseNetService parseMcMallResponseObject:responseData modelClass:[GoodsModel class] error:error onCompletionBlock:^(HHResponseResult *responseResult) {
            if (completion) {
                completion(responseResult);
            }
        }];
    }];
    return op;
}
@end
