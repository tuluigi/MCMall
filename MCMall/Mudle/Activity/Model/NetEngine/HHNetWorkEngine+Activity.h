//
//  HHNetWorkEngine+Activity.h
//  MCMall
//
//  Created by Luigi on 15/5/26.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "HHNetWorkEngine.h"
@class ActivityModel;
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
-(MKNetworkOperation *)getActivityListWithUserID:(NSString *)userID
                                         pageNum:(NSInteger)pageNum
                                        pageSize:(NSInteger)pageSize
                             onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok;



/**
 *  获取活动详情
 *
 *  @param activityID      活动ID
 *  @param type            活动类型
 *  @param completionBlcok
 *
 *  @return
 */
-(MKNetworkOperation *)getActivityDetailWithActivityID:(NSString *)activityID
                                          activityType:(NSInteger)type
                                                userID:(NSString *)userID
                                   onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok;


/**
 *  活动投票的接口
 *
 *  @param userID          用户ID
 *  @param activityID      活动ID
 *  @param num             投票选项
 *  @param completionBlcok
 *
 *  @return
 */
-(MKNetworkOperation *)voteActivityWithUserID:(NSString*)userID
                                   ActivityID:(NSString *)activityID
                                      voteNum:(NSInteger)num
                          onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok;

/**
 *  报名活动
 *
 *  @param userID          用户ID
 *  @param activityID      活动ID
 *  @param completionBlcok
 *
 *  @return
 */
-(MKNetworkOperation *)applyActivityWithUserID:(NSString*)userID
                                    ActivityID:(NSString *)activityID
                           onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok;

-(MKNetworkOperation *)publishActivityCommentWithUserID:(NSString*)userID
                                             ActivityID:(NSString *)activityID
                                                photoID:(NSString *)photoID
                                               comments:(NSString *)contents
                                    onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok;
/**
 *  获取评论列表
 *
 *  @param activityID      活动
 *  @param photoID
 *  @param pageIndex
 *  @param pageSize
 *  @param completionBlcok
 *
 *  @return
 */
-(MKNetworkOperation *)getPhotoCommontsWithActivityID:(NSString*)activityID
                                                photoID:(NSString *)photoID
                                               userID:(NSString *)userID
                                            pageIndex:(NSInteger)pageIndex
                                             pageSize:(NSInteger)pageSize
                                    onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok;

-(MKNetworkOperation *)uploadActivityPhotoWithActivityID:(NSString*)activityID
                                              photoPath:(NSString *)photoPath
                                               userID:(NSString *)userID
                                  onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok;


@end
