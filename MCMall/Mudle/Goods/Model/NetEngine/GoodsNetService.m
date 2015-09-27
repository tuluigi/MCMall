//
//  GoodsNetService.m
//  MCMall
//
//  Created by Luigi on 15/9/27.
//  Copyright © 2015年 Luigi. All rights reserved.
//

#import "GoodsNetService.h"
#import "MCMallAPI.h"
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
@end
