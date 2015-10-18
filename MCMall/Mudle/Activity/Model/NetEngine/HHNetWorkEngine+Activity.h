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
-(HHNetWorkOperation *)getActivityListWithUserID:(NSString *)userID
                                         pageNum:(NSInteger)pageNum
                                        pageSize:(NSInteger)pageSize
                                          isSelf:(BOOL)isSelf
                             onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok;



/**
 *  获取活动详情
 *
 *  @param activityID      活动ID
 *  @param type            活动类型
 *  @param sortMethod       1 是按照时间，其他按照点赞
 *  @param completionBlcok
 *
 *  @return
 */
-(HHNetWorkOperation *)getActivityDetailWithActivityID:(NSString *)activityID
                                          activityType:(NSInteger)type
                                                userID:(NSString *)userID
                                            sortMethod:(NSString *)sort
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
-(HHNetWorkOperation *)voteActivityWithUserID:(NSString*)userID
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
-(HHNetWorkOperation *)applyActivityWithUserID:(NSString*)userID
                                    ActivityID:(NSString *)activityID
                                       remarks:(NSString *)remarks
                           onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok;

/**
 *  发表评论
 *
 *  @param userID          用户id
 *  @param activityID
 *  @param photoID
 *  @param contents
 *  @param completionBlcok
 *
 *  @return
 */
-(HHNetWorkOperation *)publishActivityCommentWithUserID:(NSString*)userID
                                             ActivityID:(NSString *)activityID
                                                photoID:(NSString *)photoID
                                               comments:(NSString *)contents
                                    onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok;
/**
 *  对图片点赞
 *
 *  @param userID
 *  @param activityID
 *  @param photoID
 *  @param completionBlcok
 *
 *  @return <#return value description#>
 */
-(HHNetWorkOperation  *)favorPhotoActivitWithUserID:(NSString *)userID
                                      activityID:(NSString *)activityID
                                         photoID:(NSString *)photoID
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
-(HHNetWorkOperation *)getPhotoCommontsWithActivityID:(NSString*)activityID
                                                photoID:(NSString *)photoID
                                               userID:(NSString *)userID
                                            pageIndex:(NSInteger)pageIndex
                                             pageSize:(NSInteger)pageSize
                                    onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok;

-(HHNetWorkOperation *)uploadActivityPhotoWithActivityID:(NSString*)activityID
                                              photo:(NSString *)photo
                                               userID:(NSString *)userID
                                          uploadProgress:(void(^)(CGFloat progress))progresBlock
                                  onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok;

@end
