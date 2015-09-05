//
//  BaseTableViewController.h
//  MCMall
//
//  Created by Luigi on 15/5/27.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "HHTableView.h"
@interface BaseTableViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSUInteger _pageIndex;
}
@property(nonatomic,strong)NSMutableArray *dataSourceArray;
@property(nonatomic,strong)HHTableView *tableView;
@property(nonatomic,assign)NSUInteger pageIndex;
@property(nonatomic,assign)CGFloat cellHeight;

- (instancetype)initWithStyle:(UITableViewStyle)style;
@end
