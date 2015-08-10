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
           //  @"userAmount":@"money",
             @"userID":@"userId",
             @"userHeadUrl":@"img",
             @"shopName":@"shopName"};
}

-(void)setNilValueForKey:(NSString *)key{
    [self setValue:@"" forKey:key];
}
-(void)setUserHeadUrl:(NSString *)userHeadUrl{
    _userHeadUrl=userHeadUrl;
    if (_userHeadUrl&&(![_userHeadUrl hasPrefix:@"http://"])) {
        _userHeadUrl=[HHGlobalVarTool fullImagePath:_userHeadUrl];
    }
}
/*
+(UserModel *)userModelWithResponseDic:(NSDictionary *)dic shouldSynchronize:(BOOL)synchroniz{
    UserModel *userModel    =[[UserModel alloc]  init];
    userModel.userName      =[dic objectForKey:@"userName"];
    userModel.userTel       =[dic objectForKey:@"phone"];
    userModel.userAmount    =[[dic objectForKey:@"money"] floatValue];
    userModel.userID        =[dic objectForKey:@"userId"];
    userModel.userHeadUrl   =[HHGlobalVarTool fullImagePath:[dic objectForKey:@"img"]];
    userModel.shopName      =[dic objectForKey:@"shopName"];
    userModel.gender        =[dic objectForKey:@"sex"];
    
    if (synchroniz) {
        [UserModel storeUserModel:userModel];
    }
    return userModel;
}
*/
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
