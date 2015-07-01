//
//  VoteActivityViewController.h
//  MCMall
//
//  Created by Luigi on 15/6/9.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "BaseTableViewController.h"
#import "ActivityModel.h"
@interface VoteActivityViewController : BaseTableViewController
@property(nonatomic,copy)NSString *activityID;
-(id)initWithActivityID:(NSString *)activityID type:(ActivityType )actType;
@end
