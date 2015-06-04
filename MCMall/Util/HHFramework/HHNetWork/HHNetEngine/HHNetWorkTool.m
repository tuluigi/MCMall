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
#import "Base64Tool.h"
#import "NSMutableDictionary+HHFrameWorkKit.h"

#import "MKNetworkOperation.h"

#import "HHResponseResult.h"
#import "HHFrameWorkKitMacro.h"
#import "NSString+Addition.h"

@implementation HHNetWorkTool

+(NSDictionary *)convertPostDic:(NSDictionary *)postDic{
    NSMutableDictionary *newPostDic=[NSMutableDictionary dictionaryWithDictionary:postDic];
    if (!newPostDic){
        newPostDic=[NSMutableDictionary new];
    }
    [newPostDic setObject:@"SYSSHOP" forKey:@"shopid"];
    return newPostDic;
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
#ifdef DEBUG
        NSLog(@"===网络请求原始数据:\n%@",[completionOpetion responseString ]);
#endif
        NSError *errorJson=nil;
       NSMutableDictionary *resultDic= [NSJSONSerialization JSONObjectWithData:[completionOpetion responseData] options:NSJSONReadingMutableContainers error:&errorJson];
        
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
@end
