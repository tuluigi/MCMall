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
-(HHNetWorkOperation *)getActivityListWithUserID:(NSString *)userID
                                         pageNum:(NSInteger)pageNum
                                        pageSize:(NSInteger)pageSize
                             onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok{
    WEAKSELF
    NSString *apiPath=[MCMallAPI getActivityListAPI];
    if (nil==userID) {
        userID=@"";
    }
    NSDictionary *postDic=[NSDictionary dictionaryWithObjectsAndKeys:userID,@"userid",@(pageNum),@"pageno",@(pageSize),@"records", nil];
    HHNetWorkOperation *op= [[HHNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:apiPath parmarDic:postDic method:HHGET onCompletionHandler:^(HHResponseResult *responseResult) {
        responseResult=[weakSelf parseActivityListsWithResponseResult:responseResult];
        completionBlcok(responseResult);
    }];
    return op;
}
-(HHResponseResult *)parseActivityListsWithResponseResult:(HHResponseResult *)responseResult{
    if (responseResult.responseCode==HHResponseResultCodeSuccess) {
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
-(HHNetWorkOperation *)getActivityDetailWithActivityID:(NSString *)activityID
                                          activityType:(NSInteger)type
                                                userID:(NSString *)userID
                                            sortMethod:(NSString *)sort
                                   onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok{
    WEAKSELF
    if (nil==sort||sort.length==0) {
        sort=@"0";
    }
    NSString *apiPath=[MCMallAPI getActivityDetailAPI];
    userID=[NSString stringByReplaceNullString:userID];
    NSDictionary *postDic=[NSDictionary dictionaryWithObjectsAndKeys:userID,@"userid", activityID,@"activeid",@(type),@"atype",sort,@"sort", nil];
    HHNetWorkOperation *op= [[HHNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:apiPath parmarDic:postDic method:HHGET onCompletionHandler:^(HHResponseResult *responseResult) {
        responseResult=[weakSelf parseActivityDetailWithResponseResult:responseResult];
        completionBlcok(responseResult);
    }];
    return op;
}
-(HHResponseResult *)parseActivityDetailWithResponseResult:(HHResponseResult *)responseResult{
    if (responseResult.responseCode==HHResponseResultCodeSuccess) {
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
-(HHNetWorkOperation *)voteActivityWithUserID:(NSString*)userID
                                   ActivityID:(NSString *)activityID
                                      voteNum:(NSInteger)num
                          onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok{
    //WEAKSELF
    NSString *apiPath=[MCMallAPI voteActivityAPI];
    NSDictionary *postDic=[NSDictionary dictionaryWithObjectsAndKeys:activityID,@"activeid",@(num),@"no",userID,@"userid", nil];
    HHNetWorkOperation *op= [[HHNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:apiPath parmarDic:postDic method:HHGET onCompletionHandler:^(HHResponseResult *responseResult) {
        //responseResult=[weakSelf parseActivityDetailWithResponseResult:responseResult];
        completionBlcok(responseResult);
    }];
    return op;
}
#pragma mark - 报名
-(HHNetWorkOperation *)applyActivityWithUserID:(NSString*)userID
                                    ActivityID:(NSString *)activityID
                                       remarks:(NSString *)remarks
                           onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok{
    //WEAKSELF
    NSString *apiPath=[MCMallAPI applyActivityAPI];
    NSDictionary *postDic=[NSDictionary dictionaryWithObjectsAndKeys:activityID,@"activeid",userID,@"userid",remarks,@"remarks", nil];
    HHNetWorkOperation *op= [[HHNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:apiPath parmarDic:postDic method:HHGET onCompletionHandler:^(HHResponseResult *responseResult) {
        // responseResult=[weakSelf parseActivityDetailWithResponseResult:responseResult];
        completionBlcok(responseResult);
    }];
    return op;
}
-(HHNetWorkOperation *)publishActivityCommentWithUserID:(NSString*)userID
                                             ActivityID:(NSString *)activityID
                                                photoID:(NSString *)photoID
                                               comments:(NSString *)contents
                                    onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok{
    NSString *apiPath=[MCMallAPI publishCommontActivityAPI];
    NSDictionary *postDic=[NSDictionary dictionaryWithObjectsAndKeys:activityID,@"activeid",userID,@"userid",photoID,@"lineno",contents,@"reply", nil];
    HHNetWorkOperation *op= [[HHNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:apiPath parmarDic:postDic method:HHGET onCompletionHandler:^(HHResponseResult *responseResult) {
        // responseResult=[weakSelf parseActivityDetailWithResponseResult:responseResult];
        completionBlcok(responseResult);
    }];
    return op;
}
-(HHNetWorkOperation  *)favorPhotoActivitWithUserID:(NSString *)userID
                                      activityID:(NSString *)activityID
                                         photoID:(NSString *)photoID
                             onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok{

    NSString *apiPath=[MCMallAPI favorPhotoAPI];
    NSDictionary *postDic=[NSDictionary dictionaryWithObjectsAndKeys:activityID,@"activeid",userID,@"userid",photoID,@"lineno", nil];
    HHNetWorkOperation *op= [[HHNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:apiPath parmarDic:postDic method:HHGET onCompletionHandler:^(HHResponseResult *responseResult) {
        // responseResult=[weakSelf parseActivityDetailWithResponseResult:responseResult];
        completionBlcok(responseResult);
    }];
    return op;
}
-(HHNetWorkOperation *)getPhotoCommontsWithActivityID:(NSString*)activityID
                                               photoID:(NSString *)photoID
                                               userID:(NSString *)userID
                                             pageIndex:(NSInteger)pageIndex
                                              pageSize:(NSInteger)pageSize
                                  onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok{
    WEAKSELF
    userID=[NSString stringByReplaceNullString:userID];
    NSString *apiPath=[MCMallAPI getPhotoCommonsListAPI];
    NSDictionary *postDic=[NSDictionary dictionaryWithObjectsAndKeys:activityID,@"activeid",photoID,@"lineno",@(pageIndex),@"pageno",@(pageSize),@"records",userID,@"userid", nil];
    HHNetWorkOperation *op= [[HHNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:apiPath parmarDic:postDic method:HHGET onCompletionHandler:^(HHResponseResult *responseResult) {
        responseResult=[weakSelf parsePhotoCommontsListWithResponseResult:responseResult];
        completionBlcok(responseResult);
    }];
    return op;
}
-(HHResponseResult *)parsePhotoCommontsListWithResponseResult:(HHResponseResult *)responseResult{
    if (responseResult.responseCode==HHResponseResultCodeSuccess) {
        NSDictionary *resultDic=responseResult.responseData;
        NSArray *commentsListArray=[resultDic objectForKey:@"list"];
        PhotoModel *photoModel=[[PhotoModel alloc]  init];
        photoModel.favorCount=[[resultDic objectForKey:@"zan"] integerValue];
        photoModel.isFavor=[[resultDic objectForKey:@"already"] isEqualToString:@"true"];
        NSMutableArray *array=[NSMutableArray new];
        for (NSDictionary *itemDic in commentsListArray) {
            PhotoCommentModel *commentModel=[[PhotoCommentModel alloc]  init];
            commentModel.userImage=[HHGlobalVarTool fullImagePath:[NSString stringByReplaceNullString:[itemDic objectForKey:@"img"]]];
            commentModel.userName=[itemDic objectForKey:@"userName"];
            commentModel.commentTime=[itemDic objectForKey:@"time"];
            commentModel.commentContents=[itemDic objectForKey:@"reply"];
            [array addObject:commentModel];
        }
        photoModel.commentArray=array;
        responseResult.responseData=photoModel;
    }
    return responseResult;
}
-(HHNetWorkOperation *)uploadActivityPhotoWithActivityID:(NSString*)activityID
                                               photo:(NSString *)photo
                                                  userID:(NSString *)userID
                                     onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok{


    userID=[NSString stringByReplaceNullString:userID];
    NSString *apiPath=[MCMallAPI uploadActivityPhotoAPI];
    NSDictionary *postDic=[NSDictionary dictionaryWithObjectsAndKeys:activityID,@"activeid",userID,@"userid", nil];
    HHNetWorkOperation *op= [[HHNetWorkEngine sharedHHNetWorkEngine] uploadFileWithPath:apiPath filePath:photo parmarDic:postDic key:@"photo" onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCodeSuccess) {
            responseResult.responseData=[HHGlobalVarTool fullImagePath:[responseResult.responseData objectForKey:@"photo"]];
        }
        completionBlcok(responseResult);
    }];
    return op;
}

@end
