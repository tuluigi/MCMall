//
//  HHNetWorkEngine.m
//  PsHospital
//
//  Created by d gl on 13-12-3.
//  Copyright (c) 2013年 d gl. All rights reserved.
//
#import "HHNetWorkEngine.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "HHFrameWorkKitMacro.h"
#import "MCMallAPI.h"
NSString *const OCNetGET=@"GET";
NSString *const OCNetPOST=@"POST";
@interface HHNetWorkEngine ()
@property(nonatomic,copy)NSString *shopID;
@end

static HHNetWorkEngine *sharedNtWorkManager;
@implementation HHNetWorkEngine
+(id)sharedHHNetWorkEngine
{
    @synchronized(self){
        if (nil==sharedNtWorkManager) {
            sharedNtWorkManager=[[HHNetWorkEngine alloc] init];
            sharedNtWorkManager.responseSerializer=[AFHTTPResponseSerializer serializer];
             [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES] ;
//            sharedNtWorkManager.completionQueue= dispatch_queue_create("com.netease.opencourse", NULL);
//            sharedNtWorkManager.completionGroup=dispatch_group_create();
        }
    }
    return sharedNtWorkManager;
}
-(void)cancleOperationsWithOperationUniqueIdentifers:(NSArray *)operationsIdenfiers{
    if (operationsIdenfiers) {
        for (AFHTTPRequestOperation *operation in [[[HHNetWorkEngine sharedHHNetWorkEngine] operationQueue] operations]) {
            for (id item in operationsIdenfiers) {
                if ([item isKindOfClass:[NSString class]]) {
                    if ([((NSString *)item) isEqualToString:operation.uniqueIdentifier]) {
                        [operation cancel];
                        break ;
                    }
                }else if ([item isKindOfClass:[AFHTTPRequestOperation class]]&&(operation==item)){
                    [operation cancel];
                    break;
                }
            }
        }

    }
}
/**
 *  开始检测网络连接
 */
+(void)startMonitoring{
    [AFNetworkReachabilityManager managerForDomain:@"www.baidu.com"];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}
/**
 *  停止检测网络连接
 */
+(void)stopMonitoring{
    [[AFNetworkReachabilityManager sharedManager]stopMonitoring];
}
#pragma mark- 网络请求
-(HHNetWorkOperation *)requestWithUrlPath:(NSString *)hh_path
                                parmarDic:(NSDictionary *)hh_postDic
                                   method:(NSString *)hh_method
                      onCompletionHandler:(HHResponseResultSucceedBlock)hh_completion{
    if (nil==hh_path) {
        return nil;
    }
    NSAssert(hh_path, @"net work resquest url is nil");

    hh_postDic=[self convertPostDic:hh_postDic];
    HHNetWorkOperation *operation=nil;
    __weak HHNetWorkEngine *weakSelf=self;
    if ([hh_method isEqualToString:HHGET]) {
        operation= (HHNetWorkOperation *)[sharedNtWorkManager GET:hh_path parameters:hh_postDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            HHResponseResult *responseResult = [weakSelf handleRequestOperation:operation  error:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                 hh_completion(responseResult);
            });
           
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            HHResponseResult *responseResult = [weakSelf handleRequestOperation:operation  error:error];
            dispatch_async(dispatch_get_main_queue(), ^{
                hh_completion(responseResult);
            });
        }];
    }else if ([hh_method isEqualToString:HHPOST]){
        operation= (HHNetWorkOperation *)[sharedNtWorkManager POST:hh_path parameters:hh_postDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            HHResponseResult *responseResult = [weakSelf handleRequestOperation:operation  error:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                hh_completion(responseResult);
            });
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            HHResponseResult *responseResult = [weakSelf handleRequestOperation:operation  error:error];
            dispatch_async(dispatch_get_main_queue(), ^{
                hh_completion(responseResult);
            });
        }];
    }
    return operation;
}
-(NSDictionary *)convertPostDic:(NSDictionary *)postDic{
    NSMutableDictionary *newPostDic=[NSMutableDictionary dictionaryWithDictionary:postDic];
    if (!newPostDic){
        newPostDic=[NSMutableDictionary new];
    }
    NSString *shopID=self.shopID;
    if (nil==shopID||[shopID isEqualToString:@""]) {
        shopID=[HHGlobalVarTool shopID];
        self.shopID=shopID;
    }
    [newPostDic setObject:shopID forKey:@"shopid"];
    return newPostDic;
}

#pragma mark - 上传文件 以path 形式上传
-(HHNetWorkOperation *)uploadFileWithPath:(NSString *)hh_path
                                 filePath:(NSString *)hh_filePath
                                parmarDic:(NSDictionary *)hh_postDic
                                      key:(NSString *)hh_key
                      onCompletionHandler:(HHResponseResultSucceedBlock)hh_completion{
    if (nil==hh_path) {
        return nil;
    }
    NSAssert(hh_path, @"net work resquest url is nil");
    
    hh_postDic=[self convertPostDic:hh_postDic];
    HHNetWorkOperation *operation=nil;
    __weak HHNetWorkEngine *weakSelf=self;
    operation=(HHNetWorkOperation *)[[HHNetWorkEngine sharedHHNetWorkEngine] POST:hh_path parameters:hh_postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSError *error;
        BOOL isSuccess=[formData appendPartWithFileURL:[NSURL fileURLWithPath:hh_filePath] name:hh_key error:&error];
        if (isSuccess&&(nil==error)) {
           
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        HHResponseResult *responseResult=[weakSelf handleRequestOperation:operation error:nil];
        hh_completion(responseResult);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HHResponseResult *responseResult=[weakSelf handleRequestOperation:operation error:error];
        hh_completion(responseResult);
    }];
    return operation;
}



-(HHNetWorkOperation *)downLoadFileWithUrlPath:(NSString *)hh_path
                                     parmarDic:(NSDictionary *)hh_postDic
                                        method:(NSString *)hh_method
                           onCompletionHandler:(HHResponseResultSucceedBlock)hh_completion{

    return nil;
}

-(HHResponseResult *)handleRequestOperation:(AFHTTPRequestOperation *)operation  error:(NSError *)error{
     [self handleDebugMessageWithOperstion:operation error:error];
    if (operation.isCancelled) {
        return nil;
    }
    HHResponseResult *responseResult=[HHResponseResult responseResultWithResponseObject:operation.responseObject error:error];
    return responseResult;
}







#pragma mark -采用mantle之后的请求方式
-(HHNetWorkOperation *)startRequestWithUrl:(NSString *)url
                                   parmars:(NSDictionary *)parmar
                                    method:(NSString *)method
                        onCompletionHander:(HHResponseObjectBlock)completionBlock{
    if (nil==url) {
        return nil;
    }
    __weak HHNetWorkEngine *weakSelf=self;
    NSAssert(url, @"net work resquest url is nil");
    HHNetWorkOperation *operation=nil;
    parmar=[self convertPostDic:parmar];
    if ([method isEqualToString:OCNetGET]) {
        operation= (HHNetWorkOperation *)[sharedNtWorkManager GET:url parameters:parmar success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [weakSelf handleNewResponse:operation error:nil onCompletinBlock:completionBlock];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [weakSelf handleNewResponse:operation error:error onCompletinBlock:completionBlock];
        }];
    }else if ([method isEqualToString:OCNetPOST]){
        operation= (HHNetWorkOperation *)[sharedNtWorkManager POST:url parameters:parmar success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [weakSelf handleNewResponse:operation error:nil onCompletinBlock:completionBlock];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [weakSelf handleNewResponse:operation error:error onCompletinBlock:completionBlock];
        }];
    }
    return operation;
}
/**
 *  打印请求信息
 *
 *  @param operation
 *  @param error
 */
-(void)handleDebugMessageWithOperstion:(AFHTTPRequestOperation * )operation error:(NSError *)error{
#ifdef DEBUG
//    if (self.enableLog) {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if ([operation.request.HTTPMethod isEqualToString:@"POST"]) {
            NSLog(@"\n 网络请求接口地址:\n%@\n参数\n%@\n返回值\n%@",operation.response.URL,[[NSString alloc]  initWithData:operation.request.HTTPBody encoding:4],operation.responseString);
        }else{
            NSLog(@"\n网络请求接口地址:\n%@\n返回值\n%@",operation.response.URL,operation.responseString);
        }
    });
       //    }
#endif
}
-(void)handleNewResponse:(AFHTTPRequestOperation *)operation error:(NSError *)error onCompletinBlock:(HHResponseObjectBlock)completionBlock{
    [self handleDebugMessageWithOperstion:operation error:error];
    if (completionBlock) {
        completionBlock(operation.responseObject,error);
    }
}
@end
