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
            NSInteger activityType=[[dic objectForKey:@"type"] integerValue];
            id activityModel;
            if (activityType==ActivityTypeCommon) {
                activityModel=[ActivityModel activityModelWithResponseDic:dic];
            }else if (activityType==ActivityTypeVote){
                activityModel=[VoteActivityModel activityModelWithResponseDic:dic];
            }else if (activityType==ActivityTypeApply){
                activityModel=[ApplyActivityModel activityModelWithResponseDic:dic];
            }else if (activityType==ActivityTypePicture){
                activityModel=[PhotoAcitvityModel activityModelWithResponseDic:dic];
            }
            [array addObject:activityModel];
        }
        responseResult.responseData=array;
    }
    return responseResult;
}
#pragma mark - 获取活动详情
-(MKNetworkOperation *)getActivityDetailWithActivityID:(NSString *)activityID
                                          activityType:(NSInteger)type
                                                userID:(NSString *)userID
                                   onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok{
    WEAKSELF
    NSString *apiPath=[MCMallAPI getActivityDetailAPI];
    userID=[NSString stringByReplaceNullString:userID];
    NSDictionary *postDic=[NSDictionary dictionaryWithObjectsAndKeys:userID,@"userid", activityID,@"activeid",@(type),@"atype", nil];
    MKNetworkOperation *op= [[HHNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:apiPath parmarDic:postDic method:HHGET onCompletionHandler:^(HHResponseResult *responseResult) {
        responseResult=[weakSelf parseActivityDetailWithResponseResult:responseResult];
        completionBlcok(responseResult);
    }];
    return op;
}
-(HHResponseResult *)parseActivityDetailWithResponseResult:(HHResponseResult *)responseResult{
    if (responseResult.responseCode==HHResponseResultCode100) {
        NSInteger activityType=[[responseResult.responseData objectForKey:@"atype"] integerValue];
        id activityModel;
        if (activityType==ActivityTypeCommon) {
            activityModel=[ActivityModel activityModelWithResponseDic:responseResult.responseData];
        }else if (activityType==ActivityTypeVote){
            activityModel=[VoteActivityModel activityModelWithResponseDic:responseResult.responseData];
        }else if (activityType==ActivityTypeApply){
            activityModel=[ApplyActivityModel activityModelWithResponseDic:responseResult.responseData];
        }else if (activityType==ActivityTypePicture){
            activityModel=[PhotoAcitvityModel activityModelWithResponseDic:responseResult.responseData];
        }
        
        responseResult.responseData=activityModel;
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
    NSString *apiPath=[MCMallAPI applyActivityAPI];
    NSDictionary *postDic=[NSDictionary dictionaryWithObjectsAndKeys:activityID,@"activeid",userID,@"userid", nil];
    MKNetworkOperation *op= [[HHNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:apiPath parmarDic:postDic method:HHGET onCompletionHandler:^(HHResponseResult *responseResult) {
        // responseResult=[weakSelf parseActivityDetailWithResponseResult:responseResult];
        completionBlcok(responseResult);
    }];
    return op;
}
-(MKNetworkOperation *)publishActivityCommentWithUserID:(NSString*)userID
                                             ActivityID:(NSString *)activityID
                                                photoID:(NSString *)photoID
                                               comments:(NSString *)contents
                                    onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok{
    NSString *apiPath=[MCMallAPI publishCommontActivityAPI];
    NSDictionary *postDic=[NSDictionary dictionaryWithObjectsAndKeys:activityID,@"activeid",userID,@"userid",photoID,@"lineno",contents,@"reply", nil];
    MKNetworkOperation *op= [[HHNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:apiPath parmarDic:postDic method:HHGET onCompletionHandler:^(HHResponseResult *responseResult) {
        // responseResult=[weakSelf parseActivityDetailWithResponseResult:responseResult];
        completionBlcok(responseResult);
    }];
    return op;
}
-(MKNetworkOperation *)getPhotoCommontsWithActivityID:(NSString*)activityID
                                               photoID:(NSString *)photoID
                                               userID:(NSString *)userID
                                             pageIndex:(NSInteger)pageIndex
                                              pageSize:(NSInteger)pageSize
                                  onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok{
    WEAKSELF
    userID=[NSString stringByReplaceNullString:userID];
    NSString *apiPath=[MCMallAPI getPhotoCommonsListAPI];
    NSDictionary *postDic=[NSDictionary dictionaryWithObjectsAndKeys:activityID,@"activeid",photoID,@"lineno",@(pageIndex),@"pageno",@(pageSize),@"records",userID,@"userid", nil];
    MKNetworkOperation *op= [[HHNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:apiPath parmarDic:postDic method:HHGET onCompletionHandler:^(HHResponseResult *responseResult) {
        responseResult=[weakSelf parsePhotoCommontsListWithResponseResult:responseResult];
        completionBlcok(responseResult);
    }];
    return op;
}
-(HHResponseResult *)parsePhotoCommontsListWithResponseResult:(HHResponseResult *)responseResult{
    if (responseResult.responseCode==HHResponseResultCode100) {
        NSMutableArray *array=[NSMutableArray new];
        for (NSDictionary *itemDic in array) {
            PhotoCommentModel *commentModel=[[PhotoCommentModel alloc]  init];
            commentModel.userImage=[itemDic objectForKey:@"img"];

            commentModel.userName=[itemDic objectForKey:@"username"];
            commentModel.commentTime=[itemDic objectForKey:@""];
            commentModel.commentContents=[itemDic objectForKey:@""];
        }
       // responseResult.responseData=activityModel;
    }
    return responseResult;
}

@end
