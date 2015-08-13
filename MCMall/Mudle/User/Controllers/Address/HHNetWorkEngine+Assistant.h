//
//  HHNetWorkEngine+Assistant.h
//  MCMall
//
//  Created by Luigi on 15/8/13.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "HHNetWorkEngine.h"

@interface HHNetWorkEngine (Assistant)
/**
 *  签到
 *
 *  @param userID     用户ID
 *  @param completion
 *
 *  @return
 */
-(HHNetWorkOperation *)signUpWithUserID:(NSString *)userID
                    onCompletionHandler:(HHResponseResultSucceedBlock)completion;
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
                                         month:(NSString *)month onCompletionHandler:(HHResponseResultSucceedBlock)completion;
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
                          onCompletionHandler:(HHResponseResultSucceedBlock)completion;
@end
