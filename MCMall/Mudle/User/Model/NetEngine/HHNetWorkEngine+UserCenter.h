//
//  HHNetWorkEngine+UserCenter.h
//  MCMall
//
//  Created by Luigi on 15/5/26.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "HHNetWorkEngine.h"

@interface HHNetWorkEngine (UserCenter)

/**
 *  用户登录
 *
 *  @param name            名
 *  @param pwd             密码
 *  @param completionBlcok
 *
 *  @return
 */
-(MKNetworkOperation *)userLoginWithUserName:(NSString *)name
                                         pwd:(NSString *)pwd
                         onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok;
/**
 *  用户注册
 *
 *  @param merchantID      商家ID
 *  @param name            用户名
 *  @param pwd             密码
 *  @param phoneNum        电话号码
 *  @param completionBlcok
 *
 *  @return <#return value description#>
 */
-(MKNetworkOperation *)userRegisterWithMerchantID:(NSString *)merchantID
                                         UserName:(NSString *)name
                                              pwd:(NSString *)pwd
                                         phoneNum:(NSString *)phoneNum
                              onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok;
/**
 *  用户修改密码
 *
 *  @param orignalPwd      原始密码
 *  @param newPwd          新密码
 *  @param completionBlcok
 *
 *  @return
 */
-(MKNetworkOperation *)editUserPassWordWithUserID:(NSString *)userID
                                       OrignalPwd:(NSString *)orignalPwd
                                              newsPwd:(NSString *)newPwd
                                  onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok;
@end
