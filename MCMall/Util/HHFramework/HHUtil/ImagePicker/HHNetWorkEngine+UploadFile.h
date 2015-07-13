//
//  HHNetWorkEngine+UploadFile.h
//  MCMall
//
//  Created by Luigi on 15/6/5.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "HHNetWorkEngine.h"
#import "HHImagePickerHeader.h"
@interface HHNetWorkEngine (UploadFile)
/**
 * 上传图片
 *
 *  @param imgPath          图片路径
 *  @param mark             makr 表示
 *  @param completionResult
 *  @param errorBlock
 *
 *  @return
 */
-(HHNetWorkOperation *)uploadFileWithFilePath:(NSString *)filePath
                                         mark:(HHFileModule)mark
                                     fileType:(HHFileType)type
                          OnCompletionHandler:(HHResponseResultSucceedBlock)completionResult
                               onErrorHandler:(HHResponseResultErrorBlock)errorBlock;

-(HHNetWorkOperation *)uploadImageWithFileData:(NSData *)fileData
                                          mark:(HHFileModule)mark
                                      fileType:(HHFileType)type
                           OnCompletionHandler:(HHResponseResultSucceedBlock)completionResult
                                onErrorHandler:(HHResponseResultErrorBlock)errorBlock;
@end
