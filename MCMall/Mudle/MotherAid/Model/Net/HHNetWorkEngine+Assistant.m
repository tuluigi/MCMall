//
//  HHNetWorkEngine+Assistant.m
//  MCMall
//
//  Created by Luigi on 15/8/13.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "HHNetWorkEngine+Assistant.h"
#import "MCMallAPI.h"
#import "SignInModel.h"
#import "NoteModel.h"
@implementation HHNetWorkEngine (Assistant)
/**
 *  签到
 *
 *  @param userID     用户ID
 *  @param completion
 *
 *  @return
 */
-(HHNetWorkOperation *)signUpWithUserID:(NSString *)userID
                    onCompletionHandler:(HHResponseResultSucceedBlock)completion{
    NSString *apiPath=[MCMallAPI userSignInAPI];
    NSDictionary *postDic=@{@"userid":userID};
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine]  requestWithUrlPath:apiPath parmarDic:postDic method:HHGET onCompletionHandler:^(HHResponseResult *responseResult) {
        completion(responseResult);
    }];
    return op;
}
/**
 *  获取某年某月用户的签到列表
 *
 *  @param userID
 *  @param year
 *  @param month
 *  @param completion
 *
 *  @return
 */
-(HHNetWorkOperation *)getOneMonthSignupListWithUserID:(NSString *)userID
                                                 atDay:(NSDate *)date
                                   onCompletionHandler:(HHResponseResultSucceedBlock)completion{
    WEAKSELF
    
    NSString *year=@"";
    NSString *month=@"";
    NSDateFormatter *formatter=[[NSDateFormatter alloc]  init];
    formatter.dateFormat=@"yyyy";
    year=[formatter stringFromDate:date];
    formatter.dateFormat=@"MM";
    month=[formatter stringFromDate:date];
    NSString *apiPath=[MCMallAPI getUserSignListAPI];
    NSDictionary *postDic=@{@"userid":userID,@"y":year,@"m":month};
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine]  requestWithUrlPath:apiPath parmarDic:postDic method:HHGET onCompletionHandler:^(HHResponseResult *responseResult) {
        [weakSelf parseSignupListWithResponseResult:&responseResult];
        completion(responseResult);
    }];
    return op;
}
-(void )parseSignupListWithResponseResult:(HHResponseResult **)aResponseResult{
    HHResponseResult *responseResult=*aResponseResult;
    if (responseResult.responseCode==HHResponseResultCodeSuccess) {
        NSMutableArray *responseArray=[NSMutableArray new];
        NSArray *resultDataArray=[responseResult.responseData objectForKey:@"month"];
        for (NSDictionary *dic in resultDataArray  ) {
            NSError *error;
            SignInModel *signModel =[MTLJSONAdapter modelOfClass:[SignInModel class] fromJSONDictionary:dic error:&error];
            if (signModel) {
                [responseArray addObject:signModel];
            }
        }
        responseResult.responseData=responseArray;
    }
}
/**
 *  用户写日记
 *
 *  @param userID
 *  @param photoPath
 *  @param content
 *  @param completion
 *
 *  @return
 */
-(HHNetWorkOperation *)userWriteDiraryhUserID:(NSString *)userID
                                      diaryID:(NSString *)diaryID
                                    photoPath:(NSString *)photoPath
                                      content:(NSString *)content
                                 uploadProgress:(void(^)(CGFloat progress))progresBlock
                          onCompletionHandler:(HHResponseResultSucceedBlock)completion{
    NSString *apiPath=@"";
    NSDictionary *postDic;
    
    if (diaryID&&diaryID.length) {
        postDic=@{@"userid":userID,@"photo":photoPath,@"memodata":content,@"memoid":diaryID};
    }else{
        postDic=@{@"userid":userID,@"photo":photoPath,@"memodata":content};
    }

    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine]  uploadFileWithPath:apiPath filePath:photoPath parmarDic:postDic key:@"photo"
    uploadProgress:^(CGFloat progress) {
        if (progresBlock) {
            progresBlock(progress);
        }
    }  onCompletionHandler:^(HHResponseResult *responseResult) {
        completion(responseResult);
    }];
    return op;
}
-(HHNetWorkOperation *)getDiaryDetailUserID:(NSString *)userID
                                       date:(NSString *)date
                        onCompletionHandler:(HHResponseResultSucceedBlock)completion{
    NSString *apiPath=@"";
    NSDictionary *postDic=@{@"userid":userID,@"date":date};
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine]  requestWithUrlPath:apiPath parmarDic:postDic method:HHGET onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCodeSuccess) {
            NSError *error;
            NoteModel *noteModel =[MTLJSONAdapter modelOfClass:[NoteModel class] fromJSONDictionary:responseResult.responseData error:&error];
            responseResult.responseData=noteModel;
        }
        completion(responseResult);
    }];
    return op;
}
@end
