//
//  ActivityModel.m
//  MCMall
//
//  Created by Luigi on 15/5/26.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "ActivityModel.h"

@implementation ActivityModel
+(ActivityModel *)activityModelWithResponseDic:(NSDictionary *)dic{
    if ([dic isKindOfClass:[NSDictionary class]]) {
        ActivityModel *activityModel=[[ActivityModel alloc]  init];
        activityModel.activityID=[dic objectForKey:@"activeId"];
        activityModel.activityName=[dic objectForKey:@"activeName"];
        activityModel.activityType=[[dic objectForKey:@"type"] integerValue];
        activityModel.activityEndTime=[dic objectForKey:@"endDay"];
        activityModel.activityImageUrl=[HHGlobalVarTool fullImagePath:[dic objectForKey:@"image"]];
        return activityModel;
    }else{
        return nil;
    }
}
@end
