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
        ActivityModel *activityModel =[[ActivityModel alloc]  init];
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

@implementation ApplyActivityModel

+(ApplyActivityModel *)activityModelWithResponseDic:(NSDictionary *)dic{
    if ([dic isKindOfClass:[NSDictionary class]]) {
        ApplyActivityModel *activityModel =[[ApplyActivityModel alloc]  init];
        activityModel.activityID=[dic objectForKey:@"activeId"];
        activityModel.activityName=[dic objectForKey:@"activeName"];
        activityModel.activityType=[[dic objectForKey:@"type"] integerValue];
        activityModel.activityEndTime=[dic objectForKey:@"endDay"];
        activityModel.activityImageUrl=[HHGlobalVarTool fullImagePath:[dic objectForKey:@"image"]];
        activityModel.activityDetail=[dic objectForKey:@"explain"];
        if ([[dic objectForKey:@"already"] isEqualToString:@"false"]) {
            activityModel.isApplied=NO;
        }else{
            activityModel.isApplied=YES;
        }
        activityModel.totalApplyNum=[[dic objectForKey:@"enrollment"] integerValue];
        return activityModel;
    }else{
        return nil;
    }
}
@end

@implementation VoteActivityModel

+(VoteActivityModel *)activityModelWithResponseDic:(NSDictionary *)dic{
    if ([dic isKindOfClass:[NSDictionary class]]) {
        VoteActivityModel *activityModel =[[VoteActivityModel alloc]  init];
        activityModel.activityID=[dic objectForKey:@"activeId"];
        activityModel.activityName=[dic objectForKey:@"activeName"];
        activityModel.activityType=[[dic objectForKey:@"type"] integerValue];
        activityModel.activityEndTime=[dic objectForKey:@"endDay"];
        activityModel.activityImageUrl=[HHGlobalVarTool fullImagePath:[dic objectForKey:@"image"]];
        activityModel.activityDetail=[dic objectForKey:@"explain"];
        if ([[dic objectForKey:@"already"] isEqualToString:@"false"]) {
            activityModel.isVoted=NO;
        }else{
            activityModel.isVoted=YES;
        }
        NSMutableArray *array;
        for (NSDictionary *item in [dic objectForKey:@"list"]) {
            PlayerModel *playerModel=[[PlayerModel alloc]  init];
            playerModel.playerID=[item objectForKey:@"no"];
            playerModel.playerName=[item objectForKey:@""];
            playerModel.playerImageUrl=[HHGlobalVarTool fullImagePath:[item objectForKey:@"img"]];
            playerModel.playerName=[item objectForKey:@"text"];
            playerModel.playerDetail=[item objectForKey:@"exp"];
            playerModel.totalVotedNum=[[item objectForKey:@"voters"] integerValue];
            if (nil==array) {
                array=[[NSMutableArray alloc]  init];
            }
            [array addObject:playerModel];
        }
        activityModel.playersArray=array;
        return activityModel;
    }else{
        return nil;
    }
}
@end

@implementation PhotoAcitvityModel
+(PhotoAcitvityModel *)activityModelWithResponseDic:(NSDictionary *)dic{
    if ([dic isKindOfClass:[NSDictionary class]]) {
        PhotoAcitvityModel *activityModel =[[PhotoAcitvityModel alloc]  init];
        activityModel.activityID=[dic objectForKey:@"activeId"];
        activityModel.activityName=[dic objectForKey:@"activeName"];
        activityModel.activityType=[[dic objectForKey:@"type"] integerValue];
        activityModel.activityEndTime=[dic objectForKey:@"endDay"];
        activityModel.activityImageUrl=[HHGlobalVarTool fullImagePath:[dic objectForKey:@"image"]];
        activityModel.activityDetail=[dic objectForKey:@"explain"];
        if ([[dic objectForKey:@"already"] isEqualToString:@"false"]) {
            activityModel.isFavored=NO;
        }else{
            activityModel.isFavored=YES;
        }
        NSMutableArray *array;
        for (NSDictionary *item in [dic objectForKey:@"photolist"]) {
            NSString *photoUrl=[HHGlobalVarTool fullImagePath:[item objectForKey:@"photo"]];
            [array addObject:photoUrl];
        }
        activityModel.photoListArray=array;
        return activityModel;
    }else{
        return nil;
    }
}


@end

@implementation PlayerModel

@end