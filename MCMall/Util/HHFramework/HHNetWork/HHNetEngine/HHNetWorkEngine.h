    //
    //  HHNetWorkEngine.h
    //  PsHospital
    //
    //  Created by d gl on 13-12-3.
    //  Copyright (c) 2013年 d gl. All rights reserved.
    //

#define HHPOST          @"POST"
#define HHGET           @"GET"


#import "MKNetworkOperation.h"
#import "HHResponseResult.h"
#import "HHNetWorkOperation.h"
@interface HHNetWorkEngine : MKNetworkEngine
+(id)sharedHHNetWorkEngine;

-(void)cancleOperationsWithOperationUniqueIdentifers:(NSArray *)operationsIdenfiers;

/**
 *  网络请求
 *
 *  @param hh_path       接口地址
 *  @param hh_postDic    参数 NsMutableDictory,所有的value必须是string 类型。禁止用NSNumber 类型
 *  @param hh_method     访问方法 ：post  get
 *  @param hh_completion 结果
 *  @param hh_errorBlock 网络错误block
 *
 *  @return MKNetworkOperation
 */
-(HHNetWorkOperation *)requestWithUrlPath:(NSString *)hh_path
                          parmarDic:(NSDictionary *)hh_postDic
                             method:(NSString *)hh_method
                   onCompletionHandler:(HHResponseResultSucceedBlock)hh_completion;
/**
 *  上传图片（以路径形式上传）
 *
 *  @param hh_path       接口地址
 *  @param hh_filePath   图片地址
 *  @param hh_key        key
 *  @param hh_postDic    参数 NsMutableDictory,所有的value必须是string 类型。禁止用NSNumber 类型

 *  @param hh_completion 结果
 *  @param hh_errorBlock 网络错误（block）
 *
 *  @return MKNetworkOperation
*/

-(HHNetWorkOperation *)uploadFileWithPath:(NSString *)hh_path
                                 filePath:(NSString *)hh_filePath
                               parmarDic:(NSDictionary *)hh_postDic
                                     key:(NSString *)hh_key
                         onCompletionHandler:(HHResponseResultSucceedBlock)hh_completion;
-(HHNetWorkOperation *)uploadBatchFileWithPath:(NSString *)hh_path
                                 filePathArray:(NSMutableArray *)pathArray
                                parmarDic:(NSDictionary *)hh_postDic
                                      key:(NSString *)hh_key
                      onCompletionHandler:(HHResponseResultSucceedBlock)hh_completion;

/**
 *  上传图片（以data形式上传）
 *
 *  @param hh_path       接口地址
 *  @param hh_fileData   图片data
 *  @param hh_key        key
 *  @param hh_postDic   参数 NsMutableDictory,所有的value必须是string 类型。禁止用NSNumber 类型

 *  @param hh_completion 结果
 *  @param hh_errorBlock 网络错误（block）
 *
 *  @return MKNetworkOperation
 */
-(HHNetWorkOperation *)uploadFileWithUrlPath:(NSString *)hh_path
                                 fileData:(NSData *)hh_fileData
                                parmarDic:(NSDictionary *)hh_postDic
                                      key:(NSString *)hh_key
                         onCompletionHandler:(HHResponseResultSucceedBlock)hh_completion;
/**
 *  下载文件
 *
 *  @param hh_path       地址
 *  @param hh_postDic    参数
 *  @param hh_method     方法
 *  @param hh_completion
 *  @param hh_errorBlock
 *
 *  @return
 */
-(HHNetWorkOperation *)downLoadFileWithUrlPath:(NSString *)hh_path
                                   parmarDic:(NSDictionary *)hh_postDic
                                          method:(NSString *)hh_method
                         onCompletionHandler:(HHResponseResultSucceedBlock)hh_completion;

@end
