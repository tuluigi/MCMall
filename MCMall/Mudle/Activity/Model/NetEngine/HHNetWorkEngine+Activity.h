//
//  HHNetWorkEngine+Activity.h
//  MCMall
//
//  Created by Luigi on 15/5/26.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "HHNetWorkEngine.h"

@interface HHNetWorkEngine (Activity)
/**
 *  获取活动列表
 *
 *  @param merchangID      商家ID
 *  @param pageID          第几页
 *  @param completionBlcok
 *
 *  @return
 */
-(MKNetworkOperation *)getActivityListWithPageNum:(NSInteger)pageNum
                                         pageSize:(NSInteger)pageSize
                         onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok;

/**
 *  获取普通活动详情
 *
 *  @param activityID      活动ID
 *  @param completionBlcok
 *
 *  @return
 */
-(MKNetworkOperation *)getCommonActivityDetailWithActivityID:(NSString *)activityID
                                 onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok;

/**
 *  活动投票活动详情
 *
 *  @param activityID      活动ID
 *  @param completionBlcok
 *
 *  @return
 */
-(MKNetworkOperation *)getVoteActivityDetailWithActivityID:(NSString *)activityID
                                         onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok;
/**
 *  报名活动
 *
 *  @param activityID      活动ID
 *  @param userID          用户ID
 *  @param completionBlcok
 *
 *  @return
 */
-(MKNetworkOperation *)signUpActivityWithActivityID:(NSString *)activityID
                                           userID:(NSString *)userID
                                       onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok;

/**
 *  投票活动
 *
 *  @param activityID      活动ID
 *  @param userID          用户ID
 *  @param type            投票类型
 *  @param options         投票选项
 *  @param completionBlcok
 *
 *  @return 
 */
-(MKNetworkOperation *)voteActivityWithActivityID:(NSString *)activityID
                                           userID:(NSString *)userID
                                         voteType:(NSInteger)type
                                       voteOptions:(NSString *)options
                              onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok;
@end
