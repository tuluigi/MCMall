//
//  HHBaseNetService.m
//  MCMall
//
//  Created by Luigi on 15/9/4.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "HHBaseNetService.h"

@implementation HHBaseNetService
+(void)parseMcMallResponseObject:(id)responseObject modelClass:(Class )modelClass error:(NSError *)error onCompletionBlock:(HHResponseResultBlock)completionBlock{
    HHResponseResult *responseResult=[HHResponseResult responseResultWithResponseObject:responseObject error:error];
    if (responseResult.responseData != nil && responseResult.responseData != [NSNull null] ){
        if ([responseResult.responseData isKindOfClass:[NSDictionary class]]) {
            NSError *aError;
            MTLModel *dataModel=[MTLJSONAdapter modelOfClass:modelClass fromJSONDictionary:responseResult.responseData error:&aError];
            if (dataModel&&nil==aError) {
                responseResult.responseData=dataModel;
            }
        }else if ([responseResult.responseData isKindOfClass:[NSArray class]]){
            NSError *aError;
            NSArray *array = [MTLJSONAdapter modelsOfClass:modelClass fromJSONArray:responseResult.responseData error:&aError];
            if (nil==aError) {
                responseResult.responseData=array;
            }
        }else if ([responseResult.responseData isKindOfClass:[NSString class]]){
            //如果是字符串,暂时不做处理
            
        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        completionBlock(responseResult);
    });

}
@end
