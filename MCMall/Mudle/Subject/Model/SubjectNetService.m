//
//  SubjectNetService.m
//  MCMall
//
//  Created by Luigi on 15/9/4.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "SubjectNetService.h"
#import "MCMallAPI.h"
#import "SubjectModel.h"
@implementation SubjectNetService
/**
 *  获取主题列表
 *
 *  @param pageIndex  =
 *  @param pageSize
 *  @param completion
 *
 *  @return
 */
+(HHNetWorkOperation *)getSubjectListWithPageIndex:(NSInteger)pageIndex pageSize:(NSInteger )pageSize onCompletionHandler:(HHResponseResultSucceedBlock)completion{
    NSString *apiPath=[MCMallAPI getSubjectListAPI];
    NSDictionary *postDic=@{@"pageno":@(pageIndex),@"records":@(pageSize)};
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine] startRequestWithUrl:apiPath parmars:postDic method:HHGET onCompletionHander:^(id responseData, NSError *error) {
        [HHBaseNetService parseMcMallResponseObject:responseData modelClass:[SubjectModel class] error:error onCompletionBlock:^(HHResponseResult *responseResult) {
            completion(responseResult);
        }];
    }];
    return op;
}

/**
 *  获取主题详情
 *
 *  @param subjectID  主题ID
 *  @param pageIndex  第几页
 *  @param pageSize
 *  @param completion
 *
 *  @return
 */
+(HHNetWorkOperation *)getSubjectDetailWithSubjectID:(NSString *)subjectID
    userID:(NSString *)userID
    pageIndex:(NSInteger)pageIndex
    pageSize:(NSInteger )pageSize
    onCompletionHandler:(HHResponseResultSucceedBlock)completion{
    WEAKSELF
    NSString *apiPath=[MCMallAPI getSubjectDetailAPI];
    NSDictionary *postDic=@{@"pageno":@(pageIndex),@"records":@(pageSize),@"id":subjectID,@"userid":userID};
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine]  startRequestWithUrl:apiPath parmars:postDic method:OCNetGET onCompletionHander:^(id responseData, NSError *error) {
        HHResponseResult *responseResult=[HHResponseResult responseResultWithResponseObject:responseData error:error];
        [weakSelf parseSubjectDetailWithResponseResult:&responseResult];
        completion(responseResult);
    }];
    return op;
}
+(void )parseSubjectDetailWithResponseResult:(HHResponseResult **)aResponseResult{
    HHResponseResult *responseResult=*aResponseResult;
    if (responseResult.responseCode==HHResponseResultCodeSuccess) {
        NSMutableArray *responseArray=[NSMutableArray new];
        NSArray *resultDataArray=[responseResult.responseData objectForKey:@"list"];
        for (NSDictionary *dic in resultDataArray  ) {
            NSError *error;
            SubjectCommentModel *subjectModel=[MTLJSONAdapter modelOfClass:[SubjectCommentModel class] fromJSONDictionary:dic error:&error];
            if (subjectModel) {
                [responseArray addObject:subjectModel];
            }
        }
        responseResult.responseData=responseArray;
    }
}
+(HHNetWorkOperation *)askSubjectQuestionWithSubjectID:(NSString *)subjectID
                    userID:(NSString *)userID
                    questionContent:(NSString *)question
                    onCompletionHandler:(HHResponseResultSucceedBlock)completion{
    
    NSString *apiPath=[MCMallAPI askSubjectQuestionAPI];
    NSDictionary *postDic=@{@"userid":userID,@"data":question,@"id":subjectID};
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine]  startRequestWithUrl:apiPath parmars:postDic method:OCNetGET onCompletionHander:^(id responseData, NSError *error) {
        [HHBaseNetService parseMcMallResponseObject:responseData modelClass:nil error:error onCompletionBlock:^(HHResponseResult *responseResult) {
            completion(responseResult);
        }];
    }];
    return op;
}
@end
