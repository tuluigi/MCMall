//
//  HHNetWorkEngine.m
//  PsHospital
//
//  Created by d gl on 13-12-3.
//  Copyright (c) 2013年 d gl. All rights reserved.
//
#import "HHNetWorkEngine.h"
#import "HHNetWorkTool.h"
#import "HHFrameWorkKitMacro.h"
#import "MCMallAPI.h"
static HHNetWorkEngine *hh_NetWorkEngine;
@implementation HHNetWorkEngine
+(id)sharedHHNetWorkEngine
{
    @synchronized(self){
        if (nil==hh_NetWorkEngine) {
            hh_NetWorkEngine=[[HHNetWorkEngine alloc] initWithHostName:[MCMallAPI domainPath ]];
        }
    }
    return hh_NetWorkEngine;
}

#pragma mark- 网络请求
-(MKNetworkOperation *)requestWithUrlPath:(NSString *)hh_path
                                parmarDic:(NSDictionary *)hh_postDic
                                   method:(NSString *)hh_method
                      onCompletionHandler:(HHResponseResultSucceedBlock)hh_completion{
    hh_postDic=[HHNetWorkTool convertPostDic:hh_postDic];
#ifdef DEBUG
    NSLog(@"接口地址:\n%@",hh_path);
    NSLog(@"参数:\n%@",hh_postDic);
#endif
    MKNetworkOperation *hhop=[[HHNetWorkEngine sharedHHNetWorkEngine] operationWithPath:hh_path params:hh_postDic httpMethod:hh_method];
    [hhop addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        HHResponseResult *responseResult=[HHNetWorkTool parseHHNetWorkResponseCompetion:completedOperation error:nil];
        hh_completion(responseResult);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        HHResponseResult *responseResult=[HHNetWorkTool parseHHNetWorkResponseCompetion:completedOperation error:error];
        hh_completion(responseResult);
    }];
    [[HHNetWorkEngine sharedHHNetWorkEngine] enqueueOperation:hhop];
    return hhop;
}
#pragma mark - 上传文件 以path 形式上传
-(MKNetworkOperation *)uploadFileWithPath:(NSString *)hh_path
                                 filePath:(NSString *)hh_filePath
                                parmarDic:(NSDictionary *)hh_postDic
                                      key:(NSString *)hh_key
                      onCompletionHandler:(HHResponseResultSucceedBlock)hh_completion{
    hh_postDic=[HHNetWorkTool convertPostDic:hh_postDic];
#ifdef DEBUG
    NSLog(@"接口地址:\n%@",hh_path);
    NSLog(@"参数:\n%@",hh_postDic);
#endif
    MKNetworkOperation *hhop=[[HHNetWorkEngine sharedHHNetWorkEngine] operationWithPath:hh_path params:hh_postDic httpMethod:@"POST"];
    [hhop addFile:hh_filePath forKey:hh_key];
    [hhop addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        HHResponseResult *responseResult=[HHNetWorkTool parseHHNetWorkResponseCompetion:completedOperation error:nil];
        hh_completion(responseResult);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        HHResponseResult *responseResult=[HHNetWorkTool parseHHNetWorkResponseCompetion:completedOperation error:error];
        hh_completion(responseResult);
    }];
    [[HHNetWorkEngine sharedHHNetWorkEngine] enqueueOperation:hhop];
    return hhop;
}
-(MKNetworkOperation *)uploadBatchFileWithPath:(NSString *)hh_path
                                 filePathArray:(NSMutableArray *)pathArray
                                     parmarDic:(NSDictionary *)hh_postDic
                                           key:(NSString *)hh_key
                           onCompletionHandler:(HHResponseResultSucceedBlock)hh_completion{

    hh_postDic=[HHNetWorkTool convertPostDic:hh_postDic];
#ifdef DEBUG
    NSLog(@"接口地址:\n%@",hh_path);
    NSLog(@"参数:\n%@",hh_postDic);
#endif
    MKNetworkOperation *hhop=[[HHNetWorkEngine sharedHHNetWorkEngine] operationWithPath:hh_path params:hh_postDic httpMethod:@"POST"];
    for (NSString *hh_filePath in pathArray) {
        [hhop addFile:hh_filePath forKey:hh_key];
    }
    [hhop addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        HHResponseResult *responseResult=[HHNetWorkTool parseHHNetWorkResponseCompetion:completedOperation error:nil];
        hh_completion(responseResult);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        HHResponseResult *responseResult=[HHNetWorkTool parseHHNetWorkResponseCompetion:completedOperation error:error];
        hh_completion(responseResult);
    }];
    [[HHNetWorkEngine sharedHHNetWorkEngine] enqueueOperation:hhop];
    return hhop;
    
}
#pragma mark - 上传文件 以文件data 形式上传
-(MKNetworkOperation *)uploadFileWithUrlPath:(NSString *)hh_path
                                    fileData:(NSData *)hh_fileData
                                   parmarDic:(NSDictionary *)hh_postDic
                                         key:(NSString *)hh_key
                         onCompletionHandler:(HHResponseResultSucceedBlock)hh_completion{
    hh_postDic=[HHNetWorkTool convertPostDic:hh_postDic];
#ifdef DEBUG
    NSLog(@"接口地址:\n%@",hh_path);
    NSLog(@"参数:\n%@",hh_postDic);
#endif
    MKNetworkOperation *hhop=[[HHNetWorkEngine sharedHHNetWorkEngine] operationWithPath:hh_path params:hh_postDic httpMethod:@"POST"];
    [hhop addData:hh_fileData forKey:hh_key];
    [hhop addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        HHResponseResult *responseResult=[HHNetWorkTool parseHHNetWorkResponseCompetion:completedOperation error:nil];
        hh_completion(responseResult);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        HHResponseResult *responseResult=[HHNetWorkTool parseHHNetWorkResponseCompetion:completedOperation error:error];
        hh_completion(responseResult);
    }];
    [[HHNetWorkEngine sharedHHNetWorkEngine] enqueueOperation:hhop];
    return hhop;
}

-(MKNetworkOperation *)downLoadFileWithUrlPath:(NSString *)hh_path
                                     parmarDic:(NSDictionary *)hh_postDic
                                        method:(NSString *)hh_method
                           onCompletionHandler:(HHResponseResultSucceedBlock)hh_completion{

    hh_postDic=[HHNetWorkTool convertPostDic:hh_postDic];
#ifdef DEBUG
    NSLog(@"接口地址:\n%@",hh_path);
    NSLog(@"参数:\n%@",hh_postDic);
#endif
    MKNetworkOperation *hhop=[[HHNetWorkEngine sharedHHNetWorkEngine] operationWithPath:hh_path params:hh_postDic httpMethod:hh_method];
    [hhop addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        HHResponseResult *responseResult=[[HHResponseResult alloc]  init];
        responseResult.responseData=[completedOperation responseData];
        hh_completion(responseResult);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        HHResponseResult *responseResult=[HHNetWorkTool parseHHNetWorkResponseCompetion:completedOperation error:error];
        hh_completion(responseResult);
    }];
    [[HHNetWorkEngine sharedHHNetWorkEngine] enqueueOperation:hhop];
    return hhop;
    
}
@end
