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
        NSError *error;
        UserModel *userModel=[MTLJSONAdapter modelOfClass:[UserModel class] fromJSONDictionary:responseResult.responseData error:&error];
        [HHUserManager storeLoginUserModel:userModel];
//        responseResult.responseData=babeModel;
//        UserModel *userModel=[UserModel userModelWithResponseDic:responseResult.responseData shouldSynchronize:YES];
        responseResult.responseData=userModel;
    }
    return responseResult;
}
#pragma mark - 注册
-(HHNetWorkOperation *)userRegisterWithUserName:(NSString *)name
                                            pwd:(NSString *)pwd
                                       phoneNum:(NSString *)phoneNum
                                     verfiyCode:(NSString *)verfiyCode
                            onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok{
    WEAKSELF
    NSString *apiPath=[MCMallAPI userRegisterAPI];
    NSDictionary *postDic=@{@"username":name,@"password":pwd,@"phone":phoneNum,@"type":@"1",@"v":verfiyCode};
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

/**
 *  获取手机验证码
 *
 *  @param phoneNumber
 *  @param completionBlcok
 *
 *  @return
 */
-(HHNetWorkOperation *)getVerifyPhoneCodeWithPhoneNumber:(NSString *)phoneNumber
                                     onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok{
    WEAKSELF
    NSString *apiPath=[MCMallAPI  getUserPhoneVerfiyCodeAPI];
    NSDictionary *postDic=@{@"phone":phoneNumber};
    HHNetWorkOperation *op= [[HHNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:apiPath parmarDic:postDic method:HHGET onCompletionHandler:^(HHResponseResult *responseResult) {
        //responseResult=[weakSelf parseUserLoginWithResponseResult:responseResult];
        completionBlcok(responseResult);
    }];
    return op;
}



/**
 *  上传用户头像
 *
 *  @param userID          <#userID description#>
 *  @param imgPath         <#imgPath description#>
 *  @param completionBlcok <#completionBlcok description#>
 *
 *  @return <#return value description#>
 */
-(HHNetWorkOperation *)uploadUserImageWithUserID:(NSString *)userID
                                       imagePath:(NSString *)imgPath
                             onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok{
    userID=[NSString stringByReplaceNullString:userID];
    NSString *apiPath=[MCMallAPI uploadUserHeadImageAPI];
    NSDictionary *postDic=[NSDictionary dictionaryWithObjectsAndKeys:userID,@"userid",imgPath,@"img", nil];
    HHNetWorkOperation *op= [[HHNetWorkEngine sharedHHNetWorkEngine] uploadFileWithPath:apiPath filePath:imgPath parmarDic:postDic key:@"img" onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCode100) {
            responseResult.responseData=[HHGlobalVarTool fullImagePath:[responseResult.responseData objectForKey:@"img"]];
            [[NSFileManager defaultManager] removeItemAtPath:[[SDImageCache sharedImageCache] defaultCachePathForKey:responseResult.responseData] error:nil];
            [[SDImageCache sharedImageCache] storeImage:[UIImage imageWithContentsOfFile:imgPath] forKey:responseResult.responseData];
        }
        completionBlcok(responseResult);
    }];
    [op setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        [HHProgressHUD showProgress:totalBytesWritten/totalBytesExpectedToWrite];
    }];
    return op;
}


/**
 *  获取用户的信息
 *
 *  @param userID          用户ID
 *  @param completionBlcok
 *
 *  @return
 */
-(HHNetWorkOperation *)getBabeInfoWithUserID:(NSString *)userID
                         onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok{
    NSString *apiPath=[MCMallAPI  getUserInfoAPI];
    NSDictionary *postDic=@{@"userid":userID};
    HHNetWorkOperation *op= [[HHNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:apiPath parmarDic:postDic method:HHGET onCompletionHandler:^(HHResponseResult *responseResult) {
        NSError *error;
         BabeModel *babeModel=[MTLJSONAdapter modelOfClass:[BabeModel class] fromJSONDictionary:responseResult.responseData error:&error];
        responseResult.responseData=babeModel;
        completionBlcok(responseResult);
    }];
    return op;
}

/**
 *  修改宝宝信息
 *
 *  @param userID          用户
 *  @param birthday
 *  @param bigNickName  大名
 *  @param smallNickName    小名
 *  @param isBoy
 *  @param completionBlcok
 *
 *  @return
 */
-(HHNetWorkOperation *)editBabeInfoWithUserID:(NSString *)userID
                                     birthday:(NSString *)birthday
                                  bigNickName:(NSString *)bigNickName
                               smallNickeName:(NSString *)smallNickName
                                       gender:(NSString *)gender
                          onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok{
    NSString *apiPath=[MCMallAPI  editUserInfoAPI];
    birthday=[NSString stringByReplaceNullString:birthday];
    bigNickName=[NSString stringByReplaceNullString:bigNickName];
    smallNickName=[NSString stringByReplaceNullString:smallNickName];
    NSDictionary *postDic=@{@"userid":userID,@"birth":birthday,@"full":bigNickName,@"child":smallNickName,@"sex":gender,@"foresee":@""};
    HHNetWorkOperation *op= [[HHNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:apiPath parmarDic:postDic method:HHGET onCompletionHandler:^(HHResponseResult *responseResult) {
        completionBlcok(responseResult);
    }];
    return op;
}

/**
 *  版本更新
 *
 *  @param version
 *  @param completionBlcok
 *
 *  @return <#return value description#>
 */
-(HHNetWorkOperation *)checkVersionUpdateWithVersion:(NSString *)version
                                 onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok{
    WEAKSELF
    NSString *apiPath=[MCMallAPI  checkVersionUpdateAPI];
    NSDictionary *postDic=@{@"version":version,@"1":@"type"};
    HHNetWorkOperation *op= [[HHNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:apiPath parmarDic:postDic method:HHGET onCompletionHandler:^(HHResponseResult *responseResult) {
        //responseResult=[weakSelf parseUserLoginWithResponseResult:responseResult];
        completionBlcok(responseResult);
    }];
    return op;
}



@end
