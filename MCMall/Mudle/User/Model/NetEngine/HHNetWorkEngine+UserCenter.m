//
//  HHNetWorkEngine+UserCenter.m
//  MCMall
//
//  Created by Luigi on 15/5/26.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "HHNetWorkEngine+UserCenter.h"
#import "UserCenterAPI.h"
@implementation HHNetWorkEngine (UserCenter)
-(MKNetworkOperation *)userLoginWithUserName:(NSString *)name
                                         pwd:(NSString *)pwd
                         onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok{
    WEAKSELF
    NSString *apiPath=[UserCenterAPI userLoginAPI];
    NSDictionary *postDic=[NSDictionary dictionaryWithObjectsAndKeys:name,@"username",pwd,@"password", nil];
    MKNetworkOperation *op= [[HHNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:apiPath parmarDic:postDic method:HHGET onCompletionHandler:^(HHResponseResult *responseResult) {
        responseResult=[weakSelf parseUserLoginWithResponseResult:responseResult];
        completionBlcok(responseResult);
    }];
    return op;
}
-(HHResponseResult *)parseUserLoginWithResponseResult:(HHResponseResult *)responseResult{
    if (responseResult.responseCode==HHResponseResultCode100) {
        
    }
    return responseResult;
}
#pragma mark - 注册
-(MKNetworkOperation *)userRegisterWithUserName:(NSString *)name
                                            pwd:(NSString *)pwd
                                       phoneNum:(NSString *)phoneNum
                            onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok{
    WEAKSELF
    NSString *apiPath=[UserCenterAPI userLoginAPI];
    NSDictionary *postDic=@{name:@"username",pwd:@"pwd"};
    MKNetworkOperation *op= [[HHNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:apiPath parmarDic:postDic method:HHGET onCompletionHandler:^(HHResponseResult *responseResult) {
        responseResult=[weakSelf parseUserRegisterWithResponseResult:responseResult];
        completionBlcok(responseResult);
    }];
    return op;
}
-(HHResponseResult *)parseUserRegisterWithResponseResult:(HHResponseResult *)responseResult{
    if (responseResult.responseCode==HHResponseResultCode100) {
        
    }
    return responseResult;
}

@end
