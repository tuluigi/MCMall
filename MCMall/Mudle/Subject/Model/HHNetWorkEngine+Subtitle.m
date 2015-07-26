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
    NSString *apiPath=[MCMallAPI getSubjectListAPI];
    NSDictionary *postDic=@{@"pageno":@(pageIndex),@"records":@(pageSize)};
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine]  requestWithUrlPath:apiPath parmarDic:postDic method:HHGET onCompletionHandler:^(HHResponseResult *responseResult) {
        NSMutableArray *responseArray=[NSMutableArray new];
        if (responseResult.responseCode==HHResponseResultCode100) {
            NSArray *resultDataArray=responseResult.responseData;
            for (NSDictionary *dic in resultDataArray  ) {
                NSError *error;
                SubjectModel *subjectModel=[MTLJSONAdapter modelOfClass:[SubjectModel class] fromJSONDictionary:dic error:&error];
               // SubjectModel *subjectModel=[[SubjectModel alloc]  initWithDictionary:dic error:&error];
                if (subjectModel) {
                    [responseArray addObject:subjectModel];
                }
            }
            responseResult.responseData=responseArray;
        }
        completion(responseResult);
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
-(HHNetWorkOperation *)getSubjectDetailWithSubjectID:(NSString *)subjectID
                                           pageIndex:(NSInteger)pageIndex
                                            pageSize:(NSInteger )pageSize
                                 onCompletionHandler:(HHResponseResultSucceedBlock)completion{
    NSString *apiPath=[MCMallAPI getSubjectDetailAPI];
    NSDictionary *postDic=@{@"pageno":@(pageIndex),@"records":@(pageSize),@"id":subjectID};
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine]  requestWithUrlPath:apiPath parmarDic:postDic method:HHGET onCompletionHandler:^(HHResponseResult *responseResult) {
        
    }];
    return op;
}
@end
