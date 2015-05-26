//
//  HHNetWorkTool.h
//  HHFrameWorkKit
//
//  Created by Luigi on 14-9-25.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HHResponseResult;
@class MKNetworkOperation;
@interface HHNetWorkTool : NSObject
    //将参数postDic 转化为json postDic
+(NSMutableDictionary *)convertToJsonPostDicWithParaDic:(NSMutableDictionary *)postDic;
    //解析返回数据

+(HHResponseResult *)parseHHNetWorkResponseCompetion:(MKNetworkOperation *)completionOpetion error:(NSError *)error;
@end
