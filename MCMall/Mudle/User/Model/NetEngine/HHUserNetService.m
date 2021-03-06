
//
//  HHUserNetService.m
//  MCMall
//
//  Created by Luigi on 15/9/6.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "HHUserNetService.h"
#import "MCMallAPI.h"
#import "AddressModel.h"
#import "GoodsModel.h"
@implementation HHUserNetService
//添加或者修改收货人地址
+(HHNetWorkOperation *)addOrEditReceiveAddressWithUserID:(NSString *)userID
                                               addressID:(NSString *)addressID
                                           connecterName:(NSString *)connecterName
                                            connecterTel:(NSString *)connecterTel
                                                 address:(NSString *)address
                                               isDefatul:(BOOL)isDefault
                                     onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok{
    NSString *apiPath=[MCMallAPI newAddressAPI];
    NSDictionary *postDic;
    addressID=[NSString stringByReplaceNullString:addressID];
        postDic=[NSDictionary dictionaryWithObjectsAndKeys:@(isDefault),@"def",userID,@"userid",addressID,@"addrid",connecterName,@"contact",connecterTel,@"phone",address,@"address", nil];
   
       HHNetWorkOperation *op= [[HHNetWorkEngine sharedHHNetWorkEngine] startRequestWithUrl:apiPath parmars:postDic method:HHGET onCompletionHander:^(id responseData, NSError *error) {
        [HHBaseNetService parseMcMallResponseObject:responseData modelClass:nil error:error onCompletionBlock:^(HHResponseResult *responseResult) {
            if (responseResult.responseCode==HHResponseResultCodeSuccess) {
                responseResult.responseData=[responseResult.responseData objectForKey:@"addrId"];
            }
            
            if (completionBlcok) {
                completionBlcok(responseResult);
            }
        }];
    }];
    return op;
}

//获取收货地址列表
+(HHNetWorkOperation *)getReceiveAddressListWithUserID:(NSString *)userID
                                   onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok{
    NSString *apiPath=[MCMallAPI getAddressListAPI];
    NSDictionary *postDic=[NSDictionary dictionaryWithObjectsAndKeys:userID,@"userid", nil];
    HHNetWorkOperation *op= [[HHNetWorkEngine sharedHHNetWorkEngine] startRequestWithUrl:apiPath parmars:postDic method:HHGET onCompletionHander:^(id responseData, NSError *error) {
        [HHBaseNetService parseMcMallResponseObject:responseData modelClass:[AddressModel class] error:error onCompletionBlock:^(HHResponseResult *responseResult) {
            if (completionBlcok) {
                completionBlcok(responseResult);
            }
        }];
    }];
    return op;
}

//删除收货地址
+(HHNetWorkOperation *)deleteReceiveAddressWithUserID:(NSString *)userID
                                            addressID:(NSString *)addressID
                                  onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok{
    NSString *apiPath=[MCMallAPI deleteAddresssAPI];
    NSDictionary *postDic=[NSDictionary dictionaryWithObjectsAndKeys:userID,@"userid",addressID,@"addrid", nil];
    HHNetWorkOperation *op= [[HHNetWorkEngine sharedHHNetWorkEngine] startRequestWithUrl:apiPath parmars:postDic method:HHGET onCompletionHander:^(id responseData, NSError *error) {
        [HHBaseNetService parseMcMallResponseObject:responseData modelClass:nil error:error onCompletionBlock:^(HHResponseResult *responseResult) {
            if (completionBlcok) {
                completionBlcok(responseResult);
            }
        }];
    }];
    return op;
}
+(HHNetWorkOperation *)getDefaultAddressWithUserID:(NSString *)userID
                               onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok{
    NSString *apiPath=[MCMallAPI getDefaultAddressAPI];
    NSDictionary *postDic=[NSDictionary dictionaryWithObjectsAndKeys:userID,@"userid", nil];
    HHNetWorkOperation *op= [[HHNetWorkEngine sharedHHNetWorkEngine] startRequestWithUrl:apiPath parmars:postDic method:HHGET onCompletionHander:^(id responseData, NSError *error) {
        [HHBaseNetService parseMcMallResponseObject:responseData modelClass:[AddressModel class] error:error onCompletionBlock:^(HHResponseResult *responseResult) {
            if (completionBlcok) {
                completionBlcok(responseResult);
            }
        }];
    }];
    return op;   
}
//获取配送员列表
+(HHNetWorkOperation *)getSalersOnCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok{
    NSString *apiPath=[MCMallAPI getSalesListAPI];
    NSDictionary *postDic=nil;
    HHNetWorkOperation *op= [[HHNetWorkEngine sharedHHNetWorkEngine] startRequestWithUrl:apiPath parmars:postDic method:HHGET onCompletionHander:^(id responseData, NSError *error) {
        [HHBaseNetService parseMcMallResponseObject:responseData modelClass:[SalerModel class] error:error onCompletionBlock:^(HHResponseResult *responseResult) {
            if (completionBlcok) {
                completionBlcok(responseResult);
            }
        }];
    }];
    return op;
}
//获取预定列表
+(HHNetWorkOperation *)getOrderListWithUserID:(NSString *)userID pageIndex:(NSInteger)index pageSize:(NSInteger)pageSize
                          onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok{
    NSString *apiPath=[MCMallAPI getOrderListAPI];
    NSDictionary *postDic=@{@"userid":userID,@"pageno":@(index),@"records":@(pageSize)};
    HHNetWorkOperation *op= [[HHNetWorkEngine sharedHHNetWorkEngine] startRequestWithUrl:apiPath parmars:postDic method:HHGET onCompletionHander:^(id responseData, NSError *error) {
        [HHBaseNetService parseMcMallResponseObject:responseData modelClass:[OrderModel class] error:error onCompletionBlock:^(HHResponseResult *responseResult) {
            if (completionBlcok) {
                completionBlcok(responseResult);
            }
        }];
    }];
    return op;
}
@end
