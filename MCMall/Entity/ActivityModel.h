//
//  ActivityModel.h
//  MCMall
//
//  Created by Luigi on 15/5/26.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+MCHtml.h"
typedef NS_ENUM(NSUInteger, ActivityType) {
    ActivityTypeCommon      =1,//普通
    ActivityTypeVote        =3 ,//投票
    ActivityTypeApply       =2,//报名
    ActivityTypePicture     =4,//图片活动
};
typedef NS_ENUM(NSInteger, ActivitySortType) {
    ActivitySortTypeHot     =0,//最热
    ActivitySortTypeLatest =1,//最细
};

@class OperationModel;
@interface ActivityModel : NSObject
@property(nonatomic,copy)NSString *activityID;
@property(nonatomic,copy)NSString *activityName;
@property(nonatomic,copy)NSString *activityImageUrl;
@property(nonatomic,copy)NSString *activityBigImageUrl;
@property(nonatomic,copy)NSString *activityDetail;
@property(nonatomic,copy)NSString *activityEndTime;
@property(nonatomic,assign)ActivityType activityType;


+(id )activityModelWithResponseDic:(NSDictionary *)dic;
-(NSString *)activityDetailHtmlString;
@end



@interface ApplyActivityModel : ActivityModel
@property(nonatomic,assign)BOOL isApplied;
@property(nonatomic,assign)NSInteger totalApplyNum;
+(ApplyActivityModel *)activityModelWithResponseDic:(NSDictionary *)dic;
@end


@interface VoteActivityModel : ActivityModel
@property(nonatomic,assign)BOOL enableRepeatVote;//是否允许重复投票
@property(nonatomic,assign)BOOL isVoted;
@property(nonatomic,strong)NSMutableArray *playersArray;
+(VoteActivityModel *)activityModelWithResponseDic:(NSDictionary *)dic;
@end

@interface PhotoAcitvityModel : ActivityModel
@property(nonatomic,assign)BOOL isFavored;
@property(nonatomic,strong)NSMutableArray *photoListArray;
@end

@interface PlayerModel: NSObject
@property(nonatomic,copy)NSString *playerID;
@property(nonatomic,copy)NSString *playerName;
@property(nonatomic,copy)NSString *playerImageUrl;
@property(nonatomic,assign)NSInteger totalVotedNum;//总的投票人数
@property(nonatomic,copy)NSString *playerBrief;
@property(nonatomic,copy)NSString *playerDetail;
@property(nonatomic,assign)CGFloat totalHeight;//高度
@property(nonatomic,assign)BOOL isVoted;//是否投过了
@end
@interface PhotoModel : NSObject
@property(nonatomic,copy)NSString *photoID;
@property(nonatomic,copy)NSString *photoUrl;
@property(nonatomic,assign)BOOL isFavor;
@property(nonatomic,assign)NSInteger favorCount;
@property(nonatomic,strong)NSMutableArray *commentArray;
@end

@interface PhotoCommentModel : NSObject
@property(nonatomic,copy)NSString *userName;
@property(nonatomic,copy)NSString *userImage;
@property(nonatomic,copy)NSString *commentTime;
@property(nonatomic,copy)NSString *commentContents;

@end