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
-(HHNetWorkOperation *)getOneMonthSignupListWithUserID:(NSString *)userID
                                                 atDay:(NSDate *)date
                                   onCompletionHandler:(HHResponseResultSucceedBlock)completion;
/**
 *  用户写日记 (如果diaryid 不为空，则为修改日记，否则为直接写日记)
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
                          onCompletionHandler:(HHResponseResultSucceedBlock)completion;
/**
 *  获取日记详情
 *
 *  @param userID
 *  @param date
 *  @param completion
 *
 *  @return <#return value description#>
 */
-(HHNetWorkOperation *)getDiaryDetailUserID:(NSString *)userID
                                       date:(NSString *)date
                          onCompletionHandler:(HHResponseResultSucceedBlock)completion;
@end
