//
//  MotherAidNetService.m
//  MCMall
//
//  Created by Luigi on 15/9/30.
//  Copyright © 2015年 Luigi. All rights reserved.
//

#import "MotherAidNetService.h"
#import "MCMallAPI.h"
#import "NoteModel.h"
@implementation MotherAidNetService
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
                          onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok{
    userID=[NSString stringByReplaceNullString:userID];
    if (nil==date) {
        return nil;
    }
    NSString *apiPath=[MCMallAPI getBabyPothoListAPI];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]  init];
    formatter.dateFormat=@"yyyy-MM-dd";
    NSString *dateStr=[formatter stringFromDate:date];
    NSDictionary *postDic=@{@"userid":userID,@"date":dateStr};
    
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine]  startRequestWithUrl:apiPath parmars:postDic method:HHGET onCompletionHander:^(id responseData, NSError *error) {
        [HHBaseNetService parseMcMallResponseObject:responseData modelClass:[BabyPhotoModel class] error:error onCompletionBlock:^(HHResponseResult *responseResult) {
            if (completionBlcok) {
                NoteModel *noteModel=[[NoteModel alloc]  init];
                noteModel.date=date;
                if (responseResult.responseCode==HHResponseResultCodeSuccess) {
                    noteModel.photoArrays=responseResult.responseData;
                }

                responseResult.responseData=noteModel;
                completionBlcok(responseResult);
            }
        }];
    }];
    return op;
}

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
                              onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok{
    NSString *apiPath=[MCMallAPI uploadBabyPhotoAPI];
    NSDictionary *postDic;
    
    if (noteID&&noteID.length) {
        postDic=@{@"userid":userID,@"photo":photoPath,@"memoid":noteID};
    }else{
        postDic=@{@"userid":userID,@"photo":photoPath,};
    }
    
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine]  uploadFileWithPath:apiPath filePath:photoPath parmarDic:postDic key:@"photo" uploadProgress:^(CGFloat progress) {
        if (progresBlock) {
            progresBlock(progress);
        }
    } onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCodeSuccess) {
            NSString *photoID=[responseResult.responseData objectForKey:@"memoId"];
            responseResult.responseData=photoID;
        }
        if (completionBlcok) {
            completionBlcok(responseResult);
        }
    }];
    return op;
}

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
                              onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok{
    NSString *apiPath=[MCMallAPI deleteBabyPhotoDiaryAPI];
    NSDictionary *postDic=@{@"userid":userID,@"memoid":noteID,@"lineno":lineID};
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine]  startRequestWithUrl:apiPath parmars:postDic method:HHGET onCompletionHander:^(id responseData, NSError *error) {
        [HHBaseNetService parseMcMallResponseObject:responseData modelClass:nil error:error onCompletionBlock:^(HHResponseResult *responseResult) {
            if (completionBlcok) {
                completionBlcok(responseResult);
            }
        }];
    }];
    return op;

}

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
                            onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok{
    NSString *apiPath=[MCMallAPI editBabyPhotoAPI];
    content=[NSString stringByReplaceNullString:content];
    NSDictionary *postDic=@{@"userid":userID,@"memoid":noteID,@"lineno":lineID,@"text":content};
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine]  startRequestWithUrl:apiPath parmars:postDic method:HHGET onCompletionHander:^(id responseData, NSError *error) {
        [HHBaseNetService parseMcMallResponseObject:responseData modelClass:nil error:error onCompletionBlock:^(HHResponseResult *responseResult) {
            if (completionBlcok) {
                completionBlcok(responseResult);
            }
        }];
    }];
    return op;
}
@end
