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
    NSString *apiPath=[MCMallAPI uploadActivityPhotoAPI];
    NSDictionary *postDic=[NSDictionary dictionaryWithObjectsAndKeys:userID,@"userid", nil];
    HHNetWorkOperation *op= [[HHNetWorkEngine sharedHHNetWorkEngine] uploadFileWithPath:apiPath filePath:imgPath parmarDic:postDic key:@"img" onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCode100) {
            responseResult.responseData=[HHGlobalVarTool fullImagePath:[responseResult.responseData objectForKey:@"photo"]];
        }
        completionBlcok(responseResult);
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
-(HHNetWorkOperation *)getUserInfoWithUserID:(NSString *)userID
                         onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok{
    WEAKSELF
    NSString *apiPath=[MCMallAPI  getUserInfoAPI];
    NSDictionary *postDic=@{@"userid":userID};
    HHNetWorkOperation *op= [[HHNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:apiPath parmarDic:postDic method:HHGET onCompletionHandler:^(HHResponseResult *responseResult) {
        //responseResult=[weakSelf parseUserLoginWithResponseResult:responseResult];
        completionBlcok(responseResult);
    }];
    return op;
}

/**
 *  修改用户信息
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
-(HHNetWorkOperation *)editUserInfoWithUserID:(NSString *)userID
                                     birthday:(NSString *)birthday
                                  bigNickName:(NSString *)bigNickName
                               smallNickeName:(NSString *)smallNickName
                                       gender:(BOOL)isBoy
                          onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok{
    WEAKSELF
    NSString *apiPath=[MCMallAPI  getUserInfoAPI];
    birthday=[NSString stringByReplaceNullString:birthday];
    bigNickName=[NSString stringByReplaceNullString:bigNickName];
    smallNickName=[NSString stringByReplaceNullString:smallNickName];
    NSDictionary *postDic=@{@"userid":userID,@"birth":birthday,@"full":bigNickName,@"child":smallNickName,@"sex":@(isBoy)};
    HHNetWorkOperation *op= [[HHNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:apiPath parmarDic:postDic method:HHGET onCompletionHandler:^(HHResponseResult *responseResult) {
        //responseResult=[weakSelf parseUserLoginWithResponseResult:responseResult];
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
