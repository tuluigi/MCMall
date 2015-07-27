//
//  HHNetWorkEngine.m
//  PsHospital
//
//  Created by d gl on 13-12-3.
//  Copyright (c) 2013年 d gl. All rights reserved.
//
#import "HHNetWorkEngine.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "HHNetWorkTool.h"
#import "HHFrameWorkKitMacro.h"
#import "MCMallAPI.h"
NSString *const OCNetGET=@"OCNetWorkRequestMethodGet";
NSString *const OCNetPOST=@"OCNetWorkRequestMethodPost";
static HHNetWorkEngine *sharedNtWorkManager;
@implementation HHNetWorkEngine
+(id)sharedHHNetWorkEngine
{
    @synchronized(self){
        if (nil==sharedNtWorkManager) {
            sharedNtWorkManager=[[HHNetWorkEngine alloc] init];
            sharedNtWorkManager.responseSerializer=[AFHTTPResponseSerializer serializer];
             [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES] ;
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

#pragma mark- 网络请求
-(HHNetWorkOperation *)requestWithUrlPath:(NSString *)hh_path
                                parmarDic:(NSDictionary *)hh_postDic
                                   method:(NSString *)hh_method
                      onCompletionHandler:(HHResponseResultSucceedBlock)hh_completion{
    if (nil==hh_path) {
        return nil;
    }
    NSAssert(hh_path, @"net work resquest url is nil");

    hh_postDic=[HHNetWorkTool convertPostDic:hh_postDic];
#ifdef DEBUG
    NSLog(@"接口地址:\n%@",hh_path);
    NSLog(@"参数:\n%@",hh_postDic);
#endif
    HHNetWorkOperation *operation=nil;
    __weak HHNetWorkEngine *weakSelf=self;
    if ([hh_method isEqualToString:HHGET]) {
        operation= (HHNetWorkOperation *)[sharedNtWorkManager GET:hh_path parameters:hh_postDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            HHResponseResult *responseResult = [weakSelf handleRequestOperation:operation  error:nil];
            hh_completion(responseResult);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            HHResponseResult *responseResult = [weakSelf handleRequestOperation:operation  error:nil];
            hh_completion(responseResult);
        }];
    }else if ([hh_method isEqualToString:HHPOST]){
        operation= (HHNetWorkOperation *)[sharedNtWorkManager POST:hh_path parameters:hh_postDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            HHResponseResult *responseResult = [weakSelf handleRequestOperation:operation  error:nil];
            hh_completion(responseResult);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            HHResponseResult *responseResult = [weakSelf handleRequestOperation:operation  error:error];
            hh_completion(responseResult);
        }];
    }
    return operation;
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
    
    hh_postDic=[HHNetWorkTool convertPostDic:hh_postDic];
#ifdef DEBUG
    NSLog(@"接口地址:\n%@",hh_path);
    NSLog(@"参数:\n%@",hh_postDic);
#endif
    HHNetWorkOperation *operation=nil;
    __weak HHNetWorkEngine *weakSelf=self;
    operation=(HHNetWorkOperation *)[[HHNetWorkEngine sharedHHNetWorkEngine] POST:hh_path parameters:hh_postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSError *error;
        BOOL isSuccess=[formData appendPartWithFileURL:[NSURL fileURLWithPath:hh_filePath] name:@"photo" error:&error];
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
    if (error&&(!operation.responseString)) {
#ifdef DEBUG
        NSLog(@"\n 网络请求错误:\n%@",error.description);
#endif
        return nil;
    }else{
#ifdef DEBUG
        if ([operation.request.HTTPMethod isEqualToString:@"POST"]) {
            NSLog(@"\n 网络请求接口地址:\n%@\n参数\n%@\n返回值\n%@",operation.response.URL,[[NSString alloc]  initWithData:operation.request.HTTPBody encoding:4],operation.responseString);
        }else{
            NSLog(@"\n  网络请求接口地址:\n%@\n返回值\n%@",operation.response.URL,operation.responseString);
        }
#endif
        HHResponseResult *responseResult=[[HHResponseResult alloc] init];
        if (error||[operation responseData]==nil) {
            NSString *errorMsg=error.description;
            if (!errorMsg.length) {
                errorMsg=@"网络连接发生错误";
            }
            NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:@"200001",@"code",@"",@"result",errorMsg,@"message", nil];
            responseResult.responseCode=200001;
            responseResult.responseData=dic;
            responseResult.responseMessage=@"网络连接错误,请检查网络连接...";
        }else{
            //解密
            NSError *errorJson=nil;
            
            NSMutableDictionary *resultDic= [NSJSONSerialization JSONObjectWithData:[operation responseData] options:NSJSONReadingMutableContainers error:&errorJson];
            
            if (nil==resultDic&&errorJson) {
#ifdef DEBUG
                NSLog(@"接口返回json格式错误");
#endif
                responseResult.responseData=resultDic;
                responseResult.responseMessage=@"json格式错误";
                responseResult.responseCode=100002;//json 格式错误
            }else{
                responseResult.responseData=[resultDic objectForKey:@"result"];
                responseResult.responseCode=[[resultDic objectForKey:@"code"] integerValue];
                responseResult.responseMessage=[resultDic objectForKey:@"message"];
            }
        }
        return responseResult;
    }
}

@end
