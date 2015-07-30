//
//  HHNetWorkEngine+Subtitle.m
//  MCMall
//
//  Created by Luigi on 15/7/26.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "HHNetWorkEngine+Subtitle.h"
#import "MCMallAPI.h"
#import "SubjectModel.h"
@implementation HHNetWorkEngine (Subtitle)
/**
 *  获取主题列表
 *
 *  @param pageIndex  =
 *  @param pageSize
 *  @param completion
 *
 *  @return
 */
-(HHNetWorkOperation *)getSubjectListWithPageIndex:(NSInteger)pageIndex
                                          pageSize:(NSInteger )pageSize
                               onCompletionHandler:(HHResponseResultSucceedBlock)completion{
    WEAKSELF
    NSString *apiPath=[MCMallAPI getSubjectListAPI];
    NSDictionary *postDic=@{@"pageno":@(pageIndex),@"records":@(pageSize)};
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine]  requestWithUrlPath:apiPath parmarDic:postDic method:HHGET onCompletionHandler:^(HHResponseResult *responseResult) {
        [weakSelf parseSubjectListWithResponseResult:&responseResult];
        completion(responseResult);
    }];
    return op;
}
-(void )parseSubjectListWithResponseResult:(HHResponseResult **)aResponseResult{
    HHResponseResult *responseResult=*aResponseResult;
    NSMutableArray *responseArray=[NSMutableArray new];
    if (responseResult.responseCode==HHResponseResultCode100) {
        NSArray *resultDataArray=responseResult.responseData;
        for (NSDictionary *dic in resultDataArray  ) {
            NSError *error;
            SubjectModel *subjectModel=[MTLJSONAdapter modelOfClass:[SubjectModel class] fromJSONDictionary:dic error:&error];
            if (subjectModel) {
                [responseArray addObject:subjectModel];
            }
        }
        responseResult.responseData=responseArray;
    }
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
-(HHNetWorkOperation *)getSubjectDetailWithSubjectID:(NSString *)subjectID
                                              userID:(NSString *)userID
                                           pageIndex:(NSInteger)pageIndex
                                            pageSize:(NSInteger )pageSize
                                 onCompletionHandler:(HHResponseResultSucceedBlock)completion{
    WEAKSELF
    NSString *apiPath=[MCMallAPI getSubjectDetailAPI];
    NSDictionary *postDic=@{@"pageno":@(pageIndex),@"records":@(pageSize),@"id":subjectID,@"userid":userID};
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine]  requestWithUrlPath:apiPath parmarDic:postDic method:HHGET onCompletionHandler:^(HHResponseResult *responseResult) {
        [weakSelf parseSubjectDetailWithResponseResult:&responseResult];
        completion(responseResult);
    }];
    return op;
}
-(void )parseSubjectDetailWithResponseResult:(HHResponseResult **)aResponseResult{
    HHResponseResult *responseResult=*aResponseResult;
    if (responseResult.responseCode==HHResponseResultCode100) {
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
-(HHNetWorkOperation *)askSubjectQuestionWithSubjectID:(NSString *)subjectID
                                                userID:(NSString *)userID
                                       questionContent:(NSString *)question
                                   onCompletionHandler:(HHResponseResultSucceedBlock)completion{
    
    NSString *apiPath=[MCMallAPI askSubjectQuestionAPI];
    NSDictionary *postDic=@{@"userid":userID,@"data":question,@"id":subjectID};
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine]  requestWithUrlPath:apiPath parmarDic:postDic method:HHGET onCompletionHandler:^(HHResponseResult *responseResult) {
        completion(responseResult);
    }];
    return op;
}
@end
