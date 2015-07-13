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



#import "HHResponseResult.h"
#import "HHFrameWorkKitMacro.h"
#import "NSString+Addition.h"

@implementation HHNetWorkTool

+(NSDictionary *)convertPostDic:(NSDictionary *)postDic{
    NSMutableDictionary *newPostDic=[NSMutableDictionary dictionaryWithDictionary:postDic];
    if (!newPostDic){
        newPostDic=[NSMutableDictionary new];
    }
    [newPostDic setObject:[HHGlobalVarTool shopID] forKey:@"shopid"];
    return newPostDic;
}

@end
