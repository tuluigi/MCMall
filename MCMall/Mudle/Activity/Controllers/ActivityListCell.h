//
//  ActivityListCell.h
//  MCMall
//
//  Created by Luigi on 15/6/9.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityModel.h"
@interface ActivityListCell : UITableViewCell
@property(nonatomic,strong)ActivityModel *activityModel;
+(NSString *)activityListCellIdentiferWithActType:(ActivityType)actType;

@end
