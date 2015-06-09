//
//  ActivityListCell.h
//  MCMall
//
//  Created by Luigi on 15/6/9.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ActivityModel ;
@interface ActivityListCell : UITableViewCell
@property(nonatomic,strong)ActivityModel *activityModel;
+(CGFloat)activityCellHeight;
@end
