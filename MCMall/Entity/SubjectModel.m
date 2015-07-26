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
-(void)setDoctorLogo:(NSString *)doctorLogo{
    _doctorLogo=doctorLogo;
    if (_doctorLogo&&_doctorLogo.length) {
        _doctorLogo=[HHGlobalVarTool fullImagePath:_doctorLogo];
    }
}
@end

@implementation SubjectCommentModel
+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             //@"commentUserID":@"",
             @"commentUserName":@"userName",
//             @"commentTitle":@"title",
             @"commentUserImageUrl":@"img",
             @"commentTime":@"asktime",
             @"commentComment":@"data"};
}


@end