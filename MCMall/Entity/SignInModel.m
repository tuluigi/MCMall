//
//  SignInModel.m
//  MCMall
//
//  Created by Luigi on 15/8/13.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "SignInModel.h"

@implementation SignInModel
+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"signinDate":@"date",
             @"isSigned":@"status"};
}
+(MTLValueTransformer *)signinDateJSONTransformer{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSDate *date=[NSDate convertStringToDate:value format:@"yyyy-MM-dd"];
        return date;
    }];
}
+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key {
    if ([key isEqualToString:@"isSigned"]) {
        return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
            if ([value isKindOfClass:[NSString class]]) {
                return [NSNumber numberWithFloat:[value floatValue]];
            }else{
                return value;
            }
        }];
    }
    return nil;
}
@end
