//
//  HHNetWorkEngine+UserCenter.m
//  MCMall
//
//  Created by Luigi on 15/5/26.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "HHNetWorkEngine+UserCenter.h"
#import "MCMallAPI.h"
#import "UserModel.h"
@implementation HHNetWorkEngine (UserCenter)
-(HHNetWorkOperation *)userLoginWithUserName:(NSString *)name
                                         pwd:(NSString *)pwd
                         onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok{
    WEAKSELF
    NSString *apiPath=[MCMallAPI userLoginAPI];
    NSDictionary *postDic=[NSDictionary dictionaryWithObjectsAndKeys:name,@"username",pwd,@"password", nil];
    HHNetWorkOperation *op= [[HHNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:apiPath parmarDic:postDic method:HHGET onCompletionHandler:^(HHResponseResult *responseResult) {
        responseResult=[weakSelf parseUserLoginWithResponseResult:responseResult];
        completionBlcok(responseResult);
    }];
    return op;
}
-(HHResponseResult *)parseUserLoginWithResponseResult:(HHResponseResult *)responseResult{
    if (responseResult.responseCode==HHResponseResultCode100) {
        UserModel *userModel=[UserModel userModelWithResponseDic:responseResult.responseData];
        responseResult.responseData=userModel;
    }
    return responseResult;
}
#pragma mark - 注册
-(HHNetWorkOperation *)userRegisterWithUserName:(NSString *)name
                                            pwd:(NSString *)pwd
                                       phoneNum:(NSString *)phoneNum
                            onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok{
    WEAKSELF
    NSString *apiPath=[MCMallAPI userRegisterAPI];
    NSDictionary *postDic=@{@"username":name,@"password":pwd,@"phone":phoneNum,@"type":@"1"};
    HHNetWorkOperation *op= [[HHNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:apiPath parmarDic:postDic method:HHGET onCompletionHandler:^(HHResponseResult *responseResult) {
        responseResult=[weakSelf parseUserLoginWithResponseResult:responseResult];
        completionBlcok(responseResult);
    }];
    return op;
}
-(HHNetWorkOperation *)editUserPassWordWithUserID:(NSString *)userID
                                       OrignalPwd:(NSString *)orignalPwd
                                          newsPwd:(NSString *)newPwd
                              onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok{
    WEAKSELF
    NSString *apiPath=[MCMallAPI  userEditPwdAPI];
    NSDictionary *postDic=@{@"userid":userID,@"oldps":orignalPwd,@"newps":newPwd};
    HHNetWorkOperation *op= [[HHNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:apiPath parmarDic:postDic method:HHGET onCompletionHandler:^(HHResponseResult *responseResult) {
        responseResult=[weakSelf parseUserLoginWithResponseResult:responseResult];
        completionBlcok(responseResult);
    }];
    return op;
}
@end
