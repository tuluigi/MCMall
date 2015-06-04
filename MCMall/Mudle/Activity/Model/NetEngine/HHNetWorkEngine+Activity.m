//
//  HHNetWorkEngine+Activity.m
//  MCMall
//
//  Created by Luigi on 15/5/26.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "HHNetWorkEngine+Activity.h"
#import "MCMallAPI.h"
@implementation HHNetWorkEngine (Activity)
-(MKNetworkOperation *)getActivityListWithPageNum:(NSInteger)pageNum
                                         pageSize:(NSInteger)pageSize
                              onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok{
    WEAKSELF
    NSString *apiPath=[MCMallAPI getActivityListAPI];
    NSDictionary *postDic=[NSDictionary dictionaryWithObjectsAndKeys:@(pageNum),@"pageno",@(pageSize),@"records", nil];
    MKNetworkOperation *op= [[HHNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:apiPath parmarDic:postDic method:HHGET onCompletionHandler:^(HHResponseResult *responseResult) {
        responseResult=[weakSelf parseActivityListsWithResponseResult:responseResult];
        completionBlcok(responseResult);
    }];
    return op;
}
-(HHResponseResult *)parseActivityListsWithResponseResult:(HHResponseResult *)responseResult{
    if (responseResult.responseCode==HHResponseResultCode100) {
        
    }
    return responseResult;
}
@end
