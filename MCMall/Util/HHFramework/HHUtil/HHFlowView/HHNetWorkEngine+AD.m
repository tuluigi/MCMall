//
//  HHNetWorkEngine+AD.m
//  MCMall
//
//  Created by Luigi on 15/8/14.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "HHNetWorkEngine+AD.h"
#import "MCMallAPI.h"
#import "HHFlowModel.h"
@implementation HHNetWorkEngine (AD)
-(HHNetWorkOperation *)getAdvertisementListOnCompletionHandler:(HHResponseResultSucceedBlock)completion{
    WEAKSELF
    NSString *apiPath=[MCMallAPI getADListAPI];
    NSDictionary *postDic=nil;
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine]  requestWithUrlPath:apiPath parmarDic:postDic method:HHGET onCompletionHandler:^(HHResponseResult *responseResult) {
        [weakSelf parseFllowWithResponseResult:&responseResult];
        completion(responseResult);
    }];
    return op;
}
-(void )parseFllowWithResponseResult:(HHResponseResult **)aResponseResult{
    HHResponseResult *responseResult=*aResponseResult;
    if (responseResult.responseCode==HHResponseResultCodeSuccess) {
        NSMutableArray *responseArray=[NSMutableArray new];
        NSArray *resultDataArray=responseResult.responseData;
        for (NSDictionary *dic in resultDataArray  ) {
            NSError *error;
            HHFlowModel *fllowModel=[MTLJSONAdapter modelOfClass:[HHFlowModel class] fromJSONDictionary:dic error:&error];
            if (fllowModel) {
                [responseArray addObject:fllowModel];
            }
        }
        responseResult.responseData=responseArray;
    }
}
@end
