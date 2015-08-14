//
//  UserModel.m
//  MCMall
//
//  Created by Luigi on 15/5/20.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "UserModel.h"
@implementation UserModel

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"userName":@"userName",
             @"userTel":@"phone",
             @"userAmount":@"money",
             @"userID":@"userId",
             @"userHeadUrl":@"img",
             @"shopName":@"shopName",
              @"motherState":@"status",};
}

+(MTLValueTransformer *)userAmountJSONTransformer{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        if ([value isKindOfClass:[NSString class]]) {
            return [NSNumber numberWithFloat:[value floatValue]];
        }else{
            return value;
        }
    }];
}
-(void)setUserHeadUrl:(NSString *)userHeadUrl{
    _userHeadUrl=userHeadUrl;
    if (_userHeadUrl&&(![_userHeadUrl hasPrefix:@"http://"]&&![_userHeadUrl hasPrefix:NSHomeDirectory()])) {
        _userHeadUrl=[HHGlobalVarTool fullImagePath:_userHeadUrl];
    }
}
+(NSValueTransformer *)motherStateJSONTransformer{
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{
                                                                           @"0": @(MotherStateUnSelected),
                                                                           @"1": @(MotherStatePregnant),
                                                                           @"2":@(MotherStateAfterBirth)
                                                                           }];
}
@end

@implementation BabeModel
+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"smallNickName":@"child",
             @"bigNickName":@"full",
             @"birthday":@"birth",
             @"gender":@"sex"};
}
+(NSValueTransformer *)birthdayJSONTransformer{
    return [MTLValueTransformer  transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSDateFormatter *fromatter=[NSDateFormatter dateFormatterWithFormat:@"yyyy-MM-dd"];
        NSDate *aBirthday=  [fromatter  dateFromString:value];
        return aBirthday;
    }];
}

@end
