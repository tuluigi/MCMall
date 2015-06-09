//
//  HHNetWorkEngine+Activity.m
//  MCMall
//
//  Created by Luigi on 15/5/26.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "HHNetWorkEngine+Activity.h"
#import "MCMallAPI.h"
#import "ActivityModel.h"
@implementation HHNetWorkEngine (Activity)
-(MKNetworkOperation *)getActivityListWithUserID:(NSString *)userID
                                         pageNum:(NSInteger)pageNum
                                         pageSize:(NSInteger)pageSize
                              onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok{
    WEAKSELF
    NSString *apiPath=[MCMallAPI getActivityListAPI];
    if (nil==userID) {
        userID=@"";
    }
    NSDictionary *postDic=[NSDictionary dictionaryWithObjectsAndKeys:userID,@"userid",@(pageNum),@"pageno",@(pageSize),@"records", nil];
    MKNetworkOperation *op= [[HHNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:apiPath parmarDic:postDic method:HHGET onCompletionHandler:^(HHResponseResult *responseResult) {
        responseResult=[weakSelf parseActivityListsWithResponseResult:responseResult];
        completionBlcok(responseResult);
    }];
    return op;
}
-(HHResponseResult *)parseActivityListsWithResponseResult:(HHResponseResult *)responseResult{
    if (responseResult.responseCode==HHResponseResultCode100) {
        NSMutableArray *array=[[NSMutableArray alloc]  init];
        for (NSDictionary *dic in responseResult.responseData) {
            ActivityModel *model=[ActivityModel activityModelWithResponseDic:dic];
            [array addObject:model];
        }
        responseResult.responseData=array;
    }
    return responseResult;
}
#pragma mark - 获取活动详情
-(MKNetworkOperation *)getActivityDetailWithActivityID:(NSString *)activityID
                                          activityType:(NSInteger)type
                                   onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok{
    WEAKSELF
    NSString *apiPath=[MCMallAPI getActivityDetailAPI];
    NSDictionary *postDic=[NSDictionary dictionaryWithObjectsAndKeys:activityID,@"activeid",@(type),@"atype", nil];
    MKNetworkOperation *op= [[HHNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:apiPath parmarDic:postDic method:HHGET onCompletionHandler:^(HHResponseResult *responseResult) {
        responseResult=[weakSelf parseActivityDetailWithResponseResult:responseResult];
        completionBlcok(responseResult);
    }];
    return op;
}
-(HHResponseResult *)parseActivityDetailWithResponseResult:(HHResponseResult *)responseResult{
    if (responseResult.responseCode==HHResponseResultCode100) {
        
    }
    return responseResult;
}
#pragma mark -投票
-(MKNetworkOperation *)voteActivityWithUserID:(NSString*)userID
                                   ActivityID:(NSString *)activityID
                                      voteNum:(NSInteger)num
                          onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok{
    //WEAKSELF
    NSString *apiPath=[MCMallAPI voteActivityAPI];
    NSDictionary *postDic=[NSDictionary dictionaryWithObjectsAndKeys:activityID,@"activeid",@(num),@"no",userID,@"userid", nil];
    MKNetworkOperation *op= [[HHNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:apiPath parmarDic:postDic method:HHGET onCompletionHandler:^(HHResponseResult *responseResult) {
        //responseResult=[weakSelf parseActivityDetailWithResponseResult:responseResult];
        completionBlcok(responseResult);
    }];
    return op;
}
#pragma mark - 报名
-(MKNetworkOperation *)applyActivityWithUserID:(NSString*)userID
                                    ActivityID:(NSString *)activityID
                           onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok{
    //WEAKSELF
    NSString *apiPath=[MCMallAPI voteActivityAPI];
    NSDictionary *postDic=[NSDictionary dictionaryWithObjectsAndKeys:activityID,@"activeid",userID,@"userid", nil];
    MKNetworkOperation *op= [[HHNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:apiPath parmarDic:postDic method:HHGET onCompletionHandler:^(HHResponseResult *responseResult) {
       // responseResult=[weakSelf parseActivityDetailWithResponseResult:responseResult];
        completionBlcok(responseResult);
    }];
    return op;
}
@end
