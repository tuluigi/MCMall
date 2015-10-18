//
//  MotherAidNetService.h
//  MCMall
//
//  Created by Luigi on 15/9/30.
//  Copyright © 2015年 Luigi. All rights reserved.
//

#import "HHBaseNetService.h"

@interface MotherAidNetService : HHBaseNetService
/**
 *  获取宝宝相册
 *
 *  @param userID          用户ID
 *  @param date
 *  @param completionBlcok
 *
 *  @return
 */
+(HHNetWorkOperation *)getBabyPhotoListUserID:(NSString *)userID
                                         date:(NSDate *)date
                          onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok;

/**
 *  上传babay照片
 *
 *  @param userID
 *  @param noteID
 *  @param photoPath
 *  @param completionBlcok
 *
 *  @return
 */
+(HHNetWorkOperation *)uploadBabayPhotoWithUserID:(NSString *)userID
                                           noteID:(NSString *)noteID
                                         phtoPath:(NSString *)photoPath
                                   uploadProgress:(void(^)(CGFloat progress))progresBlock
                              onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok;

/**
 * 删除babay照片
 *
 *  @param userID
 *  @param noteID
 *  @param lineID
 *  @param completionBlcok
 *
 *  @return
 */
+(HHNetWorkOperation *)deleteBabayPhotoWithUserID:(NSString *)userID
                                           noteID:(NSString *)noteID
                                           lineID:(NSString *)lineID
                              onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok;

/**
 *  修改babay照片
 *
 *  @param userID
 *  @param noteID
 *  @param photoPath
 *  @param content
 *  @param completionBlcok
 *
 *  @return
 */
+(HHNetWorkOperation *)editBabayPhotoWithUserID:(NSString *)userID
                                         noteID:(NSString *)noteID
                                       lineID:(NSString *)lineID
                                        content:(NSString *)content
                            onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok;
@end
