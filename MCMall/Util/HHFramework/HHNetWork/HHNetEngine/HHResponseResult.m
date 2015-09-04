//
//  HHResponseResult.m
//  PsHospital
//
//  Created by d gl on 13-11-11.
//  Copyright (c) 2013年 d gl. All rights reserved.
//

#import "HHResponseResult.h"
static NSString *OCNetWorkErrorMessage    =@"网络连接异常";
@implementation HHResponseResult
+(HHResponseResult *)responseResultWithResponseObject:(id)responseObject error:(NSError *)aError{
    HHResponseResult *responeResult=[[HHResponseResult alloc]  init];
    if (responseObject != nil && responseObject != [NSNull null]&&nil==aError ) {
        if ([responseObject isKindOfClass:[NSDictionary class]]){
            [HHResponseResult  parseOCResponesDic:responseObject withResponseResut:&responeResult];
        }else if([responseObject isKindOfClass:[NSData class]]){
            NSError *jsonError;
            NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&jsonError];
            if (dic&&nil==jsonError) {
                [HHResponseResult  parseOCResponesDic:dic withResponseResut:&responeResult];
            }else{
                responeResult.responseCode=HHResponseResultCodeSuccess;
                responeResult.responseMessage=OCNetWorkErrorMessage;
            }
        }else if ([responseObject isKindOfClass:[NSString class]]){
            NSData *aData=[responseObject dataUsingEncoding:4];
            NSError *jsonError;
            NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:aData options:NSJSONReadingMutableLeaves error:&jsonError];
            if (dic&&nil==jsonError) {
                [HHResponseResult  parseOCResponesDic:dic withResponseResut:&responeResult];
            }else{
                responeResult.responseCode=HHResponseResultCodeFailed;
                responeResult.responseMessage=OCNetWorkErrorMessage;
            }
        }else{
            responeResult.responseCode=HHResponseResultCodeFailed;
            responeResult.responseMessage=OCNetWorkErrorMessage;
        }
    }else{
        responeResult.responseCode=HHResponseResultCodeFailed;
        responeResult.responseMessage=OCNetWorkErrorMessage;
    }
    return responeResult;
}
+(void)parseOCResponesDic:(NSDictionary *)dic withResponseResut:(HHResponseResult **)aResponseResult{
    HHResponseResult *responeResult= *aResponseResult;
    responeResult.responseCode    =[[dic objectForKey:@"code"] integerValue];
    responeResult.responseMessage =[dic objectForKey:@"message"];
    responeResult.responseData    =[dic objectForKey:@"data"];
}
@end
