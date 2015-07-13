//
//  HHNetWorkTool.h
//  HHFrameWorkKit
//
//  Created by Luigi on 14-9-25.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HHResponseResult;
@class HHNetWorkOperation;
@interface HHNetWorkTool : NSObject
    //将参数postDic 转化为json postDic
+(NSDictionary *)convertPostDic:(NSDictionary *)postDic;
    //解析返回数据

@end
