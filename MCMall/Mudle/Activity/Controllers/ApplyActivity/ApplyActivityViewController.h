//
//  ApplyActivityViewController.h
//  MCMall
//
//  Created by Luigi on 15/6/18.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "BaseTableViewController.h"
#import "ActivityModel.h"
@interface ApplyActivityViewController : BaseTableViewController
-(id)initWithActivityID:(NSString *)activityID type:(ActivityType)type;
@end
