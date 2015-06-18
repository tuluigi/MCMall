//
//  ActivityModel.m
//  MCMall
//
//  Created by Luigi on 15/5/26.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "ActivityModel.h"
@class VoteActivityModel;
@implementation ActivityModel
+(id )activityModelWithResponseDic:(NSDictionary *)dic{
    if ([dic isKindOfClass:[NSDictionary class]]) {
        NSInteger type=[[dic objectForKey:@"type"] integerValue];
        ActivityModel *  activityModel;
        if (type==ActivityTypeCommon) {
           activityModel =[[ActivityModel alloc]  init];
        }else if (type==ActivityTypeVote){
            activityModel =[[VoteActivityModel alloc]  init];

        }else if(type==ActivityTypeApply){
            activityModel =[[ApplyActivityModel alloc]  init];

        }
        
        activityModel.activityID=[dic objectForKey:@"activeId"];
        activityModel.activityName=[dic objectForKey:@"activeName"];
        activityModel.activityType=[[dic objectForKey:@"type"] integerValue];
        activityModel.activityEndTime=[dic objectForKey:@"endDay"];
        activityModel.activityImageUrl=[HHGlobalVarTool fullImagePath:[dic objectForKey:@"image"]];
        activityModel.activityDetail=[dic objectForKey:@"explain"];
        return activityModel;
    }else{
        return nil;
    }
}
@end

@implementation VoteActivityModel

+(VoteActivityModel *)activityModelWithResponseDic:(NSDictionary *)dic{
    VoteActivityModel *mode=(VoteActivityModel *)[super activityModelWithResponseDic:dic];
    mode.activityType=ActivityTypeVote;
    if ([[dic objectForKey:@"already"] isEqualToString:@"false"]) {
        mode.isVoted=NO;
    }else{
        mode.isVoted=YES;
    }
    mode.totalVotedNum=[[dic objectForKey:@"enrollment"] integerValue];
    return mode;
}

@end
@implementation ApplyActivityModel

+(ApplyActivityModel *)activityModelWithResponseDic:(NSDictionary *)dic{
    ApplyActivityModel *model=(ApplyActivityModel *)[super activityModelWithResponseDic:dic];
    model.activityType=ActivityTypeApply;
    if ([[dic objectForKey:@"already"] isEqualToString:@"false"]) {
        model.isApplied =NO;
    }else{
        model.isApplied=YES;
    }
    return model;
}

@end