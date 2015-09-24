//
//  HHNetWorkEngine+Goods.m
//  MCMall
//
//  Created by Luigi on 15/8/11.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "HHNetWorkEngine+Goods.h"
#import "GoodsModel.h"
#import "MCMallAPI.h"
@implementation HHNetWorkEngine (Goods)
/**
 *  获取商品类别
 *
 *  @param completion
 *
 *  @return
 */
-(HHNetWorkOperation *)getGoodsCategoryOnCompletionHandler:(HHResponseResultSucceedBlock)completion{
    WEAKSELF
    NSString *apiPath=[MCMallAPI getGoodsClassAPI];
    NSDictionary *postDic=nil;
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine]  requestWithUrlPath:apiPath parmarDic:postDic method:HHGET onCompletionHandler:^(HHResponseResult *responseResult) {
        [weakSelf parseCategoryWithResponseResult:&responseResult];
        completion(responseResult);
    }];
    return op;
}
-(void )parseCategoryWithResponseResult:(HHResponseResult **)aResponseResult{
    HHResponseResult *responseResult=*aResponseResult;
    if (responseResult.responseCode==HHResponseResultCodeSuccess) {
        NSMutableArray *responseArray=[NSMutableArray new];
        NSArray *resultDataArray=responseResult.responseData;
        for (NSDictionary *dic in resultDataArray  ) {
            NSError *error;
            CategoryModel *catModel=[MTLJSONAdapter modelOfClass:[CategoryModel class] fromJSONDictionary:dic error:&error];
            if (catModel) {
                [responseArray addObject:catModel];
            }
        }
        responseResult.responseData=responseArray;
    }
}

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
                         onCompletionHandler:(HHResponseResultSucceedBlock)completion{
    WEAKSELF
    NSString *apiPath=[MCMallAPI getGoodsListAPI];
    catID=[NSString stringByReplaceNullString:catID];
     userID=[NSString stringByReplaceNullString:userID];
    NSDictionary *postDic=@{@"userid":userID,@"pageno":@(pid),@"records":@(pageSize),@"classify":catID};
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine]  requestWithUrlPath:apiPath parmarDic:postDic method:HHGET onCompletionHandler:^(HHResponseResult *responseResult) {
        [weakSelf parseGoodsListWithResponseResult:&responseResult];
        completion(responseResult);
    }];
    return op;
}
-(void )parseGoodsListWithResponseResult:(HHResponseResult **)aResponseResult{
    HHResponseResult *responseResult=*aResponseResult;
    if (responseResult.responseCode==HHResponseResultCodeSuccess) {
        NSMutableArray *responseArray=[NSMutableArray new];
        NSArray *resultDataArray=responseResult.responseData;
        for (NSDictionary *dic in resultDataArray  ) {
            NSError *error;
            GoodsModel *goodsModel=[MTLJSONAdapter modelOfClass:[GoodsModel class] fromJSONDictionary:dic error:&error];
            if (goodsModel) {
                [responseArray addObject:goodsModel];
            }
        }
        responseResult.responseData=responseArray;
    }
}
/**
 *  获取商品详情
 *
 *  @param goodsID
 *  @param completion
 *
 *  @return
 */
-(HHNetWorkOperation *)getGoodsDetailWithGoodsID:(NSString *)goodsID
                                          userID:(NSString *)userID
                             onCompletionHandler:(HHResponseResultSucceedBlock)completion{
    WEAKSELF
    goodsID=[NSString stringByReplaceNullString:goodsID];
    userID=[NSString stringByReplaceNullString:userID];
    NSString *apiPath=[MCMallAPI getGoodsDetailAPI];
    NSDictionary *postDic=@{@"goodid":goodsID,@"userid":userID};
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine]  requestWithUrlPath:apiPath parmarDic:postDic method:HHGET onCompletionHandler:^(HHResponseResult *responseResult) {
        [weakSelf parseGoodsDetailWithResponseResult:&responseResult];
        completion(responseResult);
    }];
    return op;
}
-(void )parseGoodsDetailWithResponseResult:(HHResponseResult **)aResponseResult{
    HHResponseResult *responseResult=*aResponseResult;
    if (responseResult.responseCode==HHResponseResultCodeSuccess) {
        NSError *error;
        GoodsModel *goodsModel=[MTLJSONAdapter modelOfClass:[GoodsModel class] fromJSONDictionary:responseResult.responseData error:&error];
        responseResult.responseData=goodsModel;
    }
}
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
                    onCompletionHandler:(HHResponseResultSucceedBlock)completion{
    NSString *apiPath=[MCMallAPI bookGoodsAPI];
    NSDictionary *postDic=@{@"goodid":goodsID,@"userid":userID,@"phone":phoneNum,@"contact":connact,@"address":address};
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine]  requestWithUrlPath:apiPath parmarDic:postDic method:HHGET onCompletionHandler:^(HHResponseResult *responseResult) {
        completion(responseResult);
    }];
    return op;
}

@end
