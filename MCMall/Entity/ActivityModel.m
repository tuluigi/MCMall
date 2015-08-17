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
-(NSString *)activityEndTime{
    return _activityEndTime.length>0?_activityEndTime:@"";
}
-(NSString *)activityDetail{
return _activityDetail.length>0?_activityDetail:@"";
}
-(NSString *)activityDetailHtmlString{
    NSString *htmlStr=[NSString activityHtmlStringWithImageUrL:nil content:self.activityDetail];
    return htmlStr;
}
+(id )activityModelWithResponseDic:(NSDictionary *)dic{
    if ([dic isKindOfClass:[NSDictionary class]]) {
        ActivityModel *activityModel =[[self alloc]  init];
        activityModel.activityID=[dic objectForKey:@"activeId"];
        activityModel.activityName=[dic objectForKey:@"activeName"];
        activityModel.activityType=[[dic objectForKey:@"type"] integerValue];
        activityModel.activityEndTime=[dic objectForKey:@"endDay"];
        activityModel.activityImageUrl=[HHGlobalVarTool fullImagePath:[dic objectForKey:@"image"]];
        activityModel.activityBigImageUrl=[HHGlobalVarTool fullImagePath:[dic objectForKey:@"bigImg"]];
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
        activityModel.activityBigImageUrl=[HHGlobalVarTool fullImagePath:[dic objectForKey:@"bigImg"]];
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
        activityModel.activityBigImageUrl=[HHGlobalVarTool fullImagePath:[dic objectForKey:@"bigImg"]];
        activityModel.activityDetail=[dic objectForKey:@"explain"];
        if ([[dic objectForKey:@"already"] isEqualToString:@"false"]) {
            activityModel.isVoted=NO;
        }else{
            activityModel.isVoted=YES;
        }
        NSInteger repeatValue=[[dic objectForKey:@"expType"] integerValue];
        if (repeatValue==1) {
            activityModel.enableRepeatVote=NO;
        }else if(repeatValue==2){
            activityModel.enableRepeatVote=YES;
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
            if (!activityModel.enableRepeatVote) {
                playerModel.isVoted=activityModel.isVoted;
            }
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
        activityModel.activityBigImageUrl=[HHGlobalVarTool fullImagePath:[dic objectForKey:@"bigImg"]];
        activityModel.activityDetail=[dic objectForKey:@"explain"];
        if ([[dic objectForKey:@"already"] isEqualToString:@"false"]) {
            activityModel.isFavored=NO;
        }else{
            activityModel.isFavored=YES;
        }
        NSMutableArray *array=[[NSMutableArray alloc]  init];
        for (NSDictionary *item in [dic objectForKey:@"photolist"]) {
            PhotoModel *photoModel=[[PhotoModel alloc]  init];
            NSString *photoUrl=[HHGlobalVarTool fullImagePath:[item objectForKey:@"photo"]];
            photoModel.photoUrl=photoUrl;
            photoModel.photoID=[item objectForKey:@"id"];
            [array addObject:photoModel];
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
@implementation PhotoModel


@end
@implementation PhotoCommentModel



@end