//
//  SalesViewController.h
//  MCMall
//
//  Created by Luigi on 15/9/23.
//  Copyright © 2015年 Luigi. All rights reserved.
//

#import "BaseTableViewController.h"

@protocol SalesViewControllerDelegate <NSObject>

-(void)didSelectSalesWithSlaerID:(NSString *)salerID salerName:(NSString *)salerName;

@end

@interface SalesViewController : BaseTableViewController
@property(nonatomic,weak)id<SalesViewControllerDelegate>delegate;
@end
