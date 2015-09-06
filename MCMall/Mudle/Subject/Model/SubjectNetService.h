//
//  SubjectNetService.h
//  MCMall
//
//  Created by Luigi on 15/9/4.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "HHBaseNetService.h"

@interface SubjectNetService : HHBaseNetService
/**
 *  获取主题列表
 *
 *  @param pageIndex  =
 *  @param pageSize
 *  @param completion
 *
 *  @return
 */
+(HHNetWorkOperation *)getSubjectListWithPageIndex:(NSInteger)pageIndex
                                          pageSize:(NSInteger )pageSize
                               onCompletionHandler:(HHResponseResultSucceedBlock)completion;
/**
 *  获取主题详情
 *
 *  @param subjectID  主题ID
 *  @param pageIndex  第几页
 *  @param pageSize
 *  @param completion
 *
 *  @return
 */
+(HHNetWorkOperation *)getSubjectDetailWithSubjectID:(NSString *)subjectID
                                              userID:(NSString *)userID
                                           pageIndex:(NSInteger)pageIndex
                                            pageSize:(NSInteger )pageSize
                                 onCompletionHandler:(HHResponseResultSucceedBlock)completion;
//提问问题
+(HHNetWorkOperation *)askSubjectQuestionWithSubjectID:(NSString *)subjectID
                                                userID:(NSString *)userID
                                       questionContent:(NSString *)question
                                   onCompletionHandler:(HHResponseResultSucceedBlock)completion;
@end
