//
//  ActivityModel.h
//  MCMall
//
//  Created by Luigi on 15/5/26.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ActivityType) {
    ActivityTypeCommon  =1,//普通
    ActivityTypeVote     =3 ,//投票
    ActivityTypeApply     =2,//报名
};


@class OperationModel;
@interface ActivityModel : NSObject
@property(nonatomic,copy)NSString *activityID;
@property(nonatomic,copy)NSString *activityName;
@property(nonatomic,copy)NSString *activityImageUrl;
@property(nonatomic,copy)NSString *activityBrief;
@property(nonatomic,copy)NSString *activityDetail;
@property(nonatomic,copy)NSString *activityEndTime;
@property(nonatomic,assign)ActivityType activityType;

+(id )activityModelWithResponseDic:(NSDictionary *)dic;

@end

@interface VoteActivityModel : ActivityModel
@property(nonatomic,assign)BOOL isVoted;
@property(nonatomic,assign)NSInteger totalVotedNum;
+(VoteActivityModel *)activityModelWithResponseDic:(NSDictionary *)dic;

@end

@interface ApplyActivityModel : ActivityModel
@property(nonatomic,assign)BOOL isApplied;
+(ApplyActivityModel *)activityModelWithResponseDic:(NSDictionary *)dic;
@end

@interface OperationModel : NSObject
@property(nonatomic,copy)NSString *operationID;
@property(nonatomic,copy)NSString *operationName;
@end