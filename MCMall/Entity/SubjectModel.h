//
//  SubjectModel.h
//  MCMall
//
//  Created by Luigi on 15/7/26.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "BaseModel.h"
typedef NS_ENUM(NSInteger, SubjectModelState) {
    SubjectModelStateUnStart        =1,
    SubjectModelStateProcessing     =0,
    SubjectModelStateFinsihed       =-1,
};

@interface SubjectModel : BaseModel
@property(nonatomic,copy) NSString *subjectID;
@property(nonatomic,copy) NSString *subjectTitle;
@property(nonatomic,copy) NSString    *subjectTime;
@property(nonatomic,copy) NSString *doctorName;
@property(nonatomic,copy) NSString *doctorLogo;
@property(nonatomic,copy) NSString *doctorDesc;
@property(nonatomic,copy) NSString *doctorJob;
@property(nonatomic,assign)SubjectModelState subjectState;
@end

@interface SubjectCommentModel :BaseModel
@property(nonatomic,copy)NSString *commentUserID;
@property(nonatomic,copy)NSString *commentUserName;
@property(nonatomic,copy)NSString *commentUserImageUrl;
@property(nonatomic,strong)NSDate *commentTime;
@property(nonatomic,copy)NSString *commentComment;
@end