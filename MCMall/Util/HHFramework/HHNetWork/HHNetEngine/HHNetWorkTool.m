    //
    //  HHNetWorkTool.m
    //  HHFrameWorkKit
    //
    //  Created by Luigi on 14-9-25.
    //  Copyright (c) 2014年 luigi. All rights reserved.
    //

#import "HHNetWorkTool.h"
#import "HHNetWorkTool.h"
#import "NSString+NetWork.h"
#import "JSONKit.h"
#import "Base64Tool.h"
#import "NSMutableDictionary+HHFrameWorkKit.h"

#import "MKNetworkOperation.h"

#import "HHResponseResult.h"
#import "HHFrameWorkKitMacro.h"
#import "NSString+Addition.h"
#import "HHFrameWorkSetting.h"
@implementation HHNetWorkTool

+(NSMutableDictionary *)convertToJsonPostDicWithParaDic:(NSMutableDictionary *)postDic{
    NSString *jsonStr=[postDic JSONString];
    if (!jsonStr.length) {
        jsonStr=@"";
    }
    jsonStr=[jsonStr hhsoftEncryptString];
    if (!jsonStr) {
        jsonStr=@"";
    }
    NSMutableDictionary *jsonPostDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:jsonStr,@"para", nil];
    if ([HHFrameWorkSetting enableDebugLog]) {
        NSLog(@"===接口参数\n%@",jsonPostDic);
    }
    return jsonPostDic;
}
+(HHResponseResult *)parseHHNetWorkResponseCompetion:(MKNetworkOperation *)completionOpetion error:(NSError *)error{
    HHResponseResult *responseResult=[[HHResponseResult alloc] init];
    if (error) {
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
        NSString *valueStr=[completionOpetion responseString];
        if ([HHFrameWorkSetting enableDebugLog]) {
            NSLog(@"===网络请求原始数据:\n%@",valueStr);
        }
        valueStr=[valueStr hhsoftDecryptString];
        if ([HHFrameWorkSetting enableDebugLog]) {
            NSLog(@"===解析后数据:\n%@",valueStr);
        }
        NSError *errorJson=nil;
        NSMutableDictionary *resultDic=[valueStr objectFromJSONStringWithParseOptions:JKParseOptionStrict error:&(errorJson)];
        if (nil==resultDic&&errorJson) {
            if ([HHFrameWorkSetting enableDebugLog]) {
                NSLog(@"接口返回json格式错误");
            }
            responseResult.responseData=resultDic;
            responseResult.responseMessage=@"json格式错误";
            responseResult.responseCode=100002;//json 格式错误
        }else{
            responseResult.responseData=resultDic;
        }
    }
    return responseResult;
}
@end
