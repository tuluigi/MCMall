//
//  HHADNetService.m
//  MCMall
//
//  Created by Luigi on 15/11/15.
//  Copyright © 2015年 Luigi. All rights reserved.
//

#import "HHADNetService.h"
#import "MCMallAPI.h"
#import "HHFlowModel.h"
@implementation HHADNetService
+(HHNetWorkOperation *)getAdvertisementListWithType:(NSInteger)type OnCompletionHandler:(HHResponseResultSucceedBlock)completion{
        NSString *apiPath=[MCMallAPI getADListAPI];
        NSDictionary *postDic=@{@"position":[NSString stringWithFormat:@"%02ld",type]};
        HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine]  startRequestWithUrl:apiPath parmars:postDic method:HHGET onCompletionHander:^(id responseData, NSError *error) {
            [HHBaseNetService parseMcMallResponseObject:responseData modelClass:[HHFlowModel class] error:error onCompletionBlock:^(HHResponseResult *responseResult) {
                if (completion) {
                    completion(responseResult);
                }
            }];
        }];
        return op;
}
@end
