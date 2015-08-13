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
-(HHNetWorkOperation *)getSignupListWithUserID:(NSString *)userID
                                          year:(NSString *)year
                                         month:(NSString *)month onCompletionHandler:(HHResponseResultSucceedBlock)completion{
    WEAKSELF
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
    if (responseResult.responseCode==HHResponseResultCode100) {
        NSMutableArray *responseArray=[NSMutableArray new];
        NSArray *resultDataArray=responseResult.responseData;
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
                                    photoPath:(NSString *)photoPath
                                      content:(NSString *)content
                          onCompletionHandler:(HHResponseResultSucceedBlock)completion{
    NSString *apiPath=[MCMallAPI getUserSignListAPI];
    NSDictionary *postDic=@{@"userid":userID,@"photo":photoPath,@"memodata":content};
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine]  requestWithUrlPath:apiPath parmarDic:postDic method:HHGET onCompletionHandler:^(HHResponseResult *responseResult) {
        completion(responseResult);
    }];
    return op;
}
@end
