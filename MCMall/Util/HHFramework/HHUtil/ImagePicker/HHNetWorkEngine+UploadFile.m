//
//  HHNetWorkEngine+UploadFile.m
//  MCMall
//
//  Created by Luigi on 15/6/5.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "HHNetWorkEngine+UploadFile.h"

@implementation HHNetWorkEngine (UploadFile)
-(HHNetWorkOperation *)uploadFileWithFilePath:(NSString *)filePath
                                         mark:(HHFileModule)mark
                                     fileType:(HHFileType)type
                          OnCompletionHandler:(HHResponseResultSucceedBlock)completionResult
                               onErrorHandler:(HHResponseResultErrorBlock)errorBlock{
    NSString *apiPath=@"";
    NSDictionary *dic=@{};
    HHNetWorkOperation *op= [[HHNetWorkEngine sharedHHNetWorkEngine]  uploadFileWithPath:apiPath filePath:filePath parmarDic:dic key:@"" onCompletionHandler:^(HHResponseResult *responseResult) {
     
    }];
    return op;
}

-(HHNetWorkOperation *)uploadImageWithFileData:(NSData *)fileData
                                          mark:(HHFileModule)mark
                                      fileType:(HHFileType)type
                           OnCompletionHandler:(HHResponseResultSucceedBlock)completionResult
                                onErrorHandler:(HHResponseResultErrorBlock)errorBlock{
    NSString *apiPath=@"";
    NSDictionary *dic=@{};
   
    return nil;

}
@end
