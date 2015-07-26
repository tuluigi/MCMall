//
//  HHNetWorkEngine+Subtitle.h
//  MCMall
//
//  Created by Luigi on 15/7/26.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "HHNetWorkEngine.h"

@interface HHNetWorkEngine (Subtitle)
/**
 *  获取主题列表
 *
 *  @param pageIndex  =
 *  @param pageSize
 *  @param completion
 *
 *  @return
 */
-(HHNetWorkOperation *)getSubjectListWithPageIndex:(NSInteger)pageIndex
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
-(HHNetWorkOperation *)getSubjectDetailWithSubjectID:(NSString *)subjectID
                                           pageIndex:(NSInteger)pageIndex
                                           pageSize:(NSInteger )pageSize
                                onCompletionHandler:(HHResponseResultSucceedBlock)completion;

@end
