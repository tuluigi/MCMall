    //
    //  HHNetWorkEngine.h
    //  PsHospital
    //
    //  Created by d gl on 13-12-3.
    //  Copyright (c) 2013年 d gl. All rights reserved.
    //

#define HHPOST          @"POST"
#define HHGET           @"GET"


#import "AFHTTPRequestOperationManager.h"
#import "HHResponseResult.h"
#import "HHNetWorkOperation.h"
FOUNDATION_EXPORT NSString *const OCNetGET;
FOUNDATION_EXPORT NSString *const OCNetPOST;
@interface HHNetWorkEngine : AFHTTPRequestOperationManager
+(id)sharedHHNetWorkEngine;

-(void)cancleOperationsWithOperationUniqueIdentifers:(NSArray *)operationsIdenfiers;
/**
 *  开始检测网络连接
 */
+(void)startMonitoring;
/**
 *  停止检测网络连接
 */
+(void)stopMonitoring;
/**
 *  是否支持打印信息
 *  只有再DEBUG情况下才起作用
 */
@property(nonatomic,assign)BOOL enableLog;
/**
 *  网络请求
 *
 *  @param hh_path       接口地址
 *  @param hh_postDic    参数 NsMutableDictory,所有的value必须是string 类型。禁止用NSNumber 类型
 *  @param hh_method     访问方法 ：post  get
 *  @param hh_completion 结果
 *  @param hh_errorBlock 网络错误block
 *
 *  @return HHNetWorkOperation
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
 *  @return HHNetWorkOperation
*/

-(HHNetWorkOperation *)uploadFileWithPath:(NSString *)hh_path
                                 filePath:(NSString *)hh_filePath
                               parmarDic:(NSDictionary *)hh_postDic
                                     key:(NSString *)hh_key
                         uploadProgress:(void(^)(CGFloat progress))uploadProgresBlock
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

/**
 *  采用Mantel之后的请求方式
 *
 *  @param url             接口地址
 *  @param parmar          参数
 *  @param method          请求方式
 *  @param completionBlock
 *
 *  @return
 */
-(HHNetWorkOperation *)startRequestWithUrl:(NSString *)url
                                   parmars:(NSDictionary *)parmar
                                    method:(NSString *)method
                        onCompletionHander:(HHResponseObjectBlock)completionBlock;

@end
