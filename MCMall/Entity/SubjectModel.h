//
//  SubjectModel.h
//  MCMall
//
//  Created by Luigi on 15/7/26.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "MTLModel.h"
typedef NS_ENUM(NSInteger, SubjectModelState) {
    SubjectModelStateUnStart        =-1,
    SubjectModelStateProcessing     =0,
    SubjectModelStateFinsihed       =1,
};

@interface SubjectModel : MTLModel<MTLJSONSerializing>
@property(nonatomic,copy) NSString *subjectID;
@property(nonatomic,copy) NSString *subjectTitle;
@property(nonatomic,copy) NSString    *subjectTime;
@property(nonatomic,copy) NSString *doctorName;
@property(nonatomic,copy) NSString *doctorLogo;
@property(nonatomic,copy) NSString *doctorDesc;
@property(nonatomic,copy) NSString *doctorJob;
@property(nonatomic,assign)SubjectModelState subjectState;
+(SubjectModel *)subjectModelWithResponseDic:(NSDictionary *)dic;
@end
