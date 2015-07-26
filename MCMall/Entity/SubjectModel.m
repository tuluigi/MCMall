//
//  SubjectModel.m
//  MCMall
//
//  Created by Luigi on 15/7/26.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "SubjectModel.h"

@implementation SubjectModel
+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"doctorLogo":@"img",
             @"doctorName":@"name",
             @"subjectState":@"stauts",
             @"subjectID":@"id",
             @"subjectTime":@"time",
             @"subjectTitle":@"title",
             @"doctorDesc":@"exp"};
}
+(NSValueTransformer *)subjectStateJSONTransformer{
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{
                                                                           @"-1": @(SubjectModelStateUnStart),
                                                                           @"0": @(SubjectModelStateProcessing),
                                                                           @"1":@(SubjectModelStateFinsihed)
                                                                           }];
}

+(SubjectModel *)subjectModelWithResponseDic:(NSDictionary *)dic{

    return nil;
}
@end
