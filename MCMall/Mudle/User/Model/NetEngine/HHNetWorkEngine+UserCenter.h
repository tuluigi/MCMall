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
-(HHNetWorkOperation *)userLoginWithUserName:(NSString *)name
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
 *  @return
 */
-(HHNetWorkOperation *)userRegisterWithUserName:(NSString *)name
                                            pwd:(NSString *)pwd
                                       phoneNum:(NSString *)phoneNum
                                     verfiyCode:(NSString *)verfiyCode
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
-(HHNetWorkOperation *)editUserPassWordWithUserID:(NSString *)userID
                                       OrignalPwd:(NSString *)orignalPwd
                                          newsPwd:(NSString *)newPwd
                              onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok;

/**
 *  获取手机验证码
 *
 *  @param phoneNumber
 *  @param completionBlcok
 *
 *  @return
 */
-(HHNetWorkOperation *)getVerifyPhoneCodeWithPhoneNumber:(NSString *)phoneNumber
                                     onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok;

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
                                     onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok;

/**
 *  获取用户的信息
 *
 *  @param userID          用户ID
 *  @param completionBlcok
 *
 *  @return
 */
-(HHNetWorkOperation *)getUserInfoWithUserID:(NSString *)userID
                              onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok;

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
                          onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok;

/**
 *  版本更新
 *
 *  @param version
 *  @param completionBlcok
 *
 *  @return <#return value description#>
 */
-(HHNetWorkOperation *)checkVersionUpdateWithVersion:(NSString *)version
                                 onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok;


@end
