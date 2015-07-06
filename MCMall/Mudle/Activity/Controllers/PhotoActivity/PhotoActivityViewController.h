//
//  PhotoActivityViewController.h
//  MCMall
//
//  Created by Luigi on 15/6/28.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "BaseTableViewController.h"

@interface PhotoActivityViewController : BaseTableViewController
-(id)initWithActivityID:(NSString *)activityID PhotoID:(NSString *)photoID photoUrl:(NSString *)url;
@end
