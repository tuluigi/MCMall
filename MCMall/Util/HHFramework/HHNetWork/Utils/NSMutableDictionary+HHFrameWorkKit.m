//
//  NSMutableDictionary+HHFrameWorkKit.m
//  HHFrameWorkKit
//
//  Created by Luigi on 14-9-25.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import "NSMutableDictionary+HHFrameWorkKit.h"
#import "Base64Tool.h"
@implementation NSMutableDictionary (HHFrameWorkKit)
-(NSMutableDictionary *)hhsoft_EncryPostDic{
    NSMutableDictionary *postDic=self;
    NSArray *keyArry=[postDic allKeys];
    for (id keyStr in keyArry) {
        id valueStr=[postDic objectForKey:keyStr];
        if ([valueStr isKindOfClass:[NSNumber class]]) {
            valueStr=[NSString stringWithFormat:@"%@",valueStr];
        }
        NSString *  newvalueStr=[valueStr base64EncodedString];
        if (![newvalueStr length]) {
            newvalueStr=@"";
        }
        [postDic setObject:newvalueStr forKey:keyStr];
    }
    return postDic;
}
@end
