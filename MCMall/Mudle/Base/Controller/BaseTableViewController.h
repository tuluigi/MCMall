//
//  BaseTableViewController.h
//  MCMall
//
//  Created by Luigi on 15/5/27.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "TPKeyboardAvoidingTableView.h"
@interface BaseTableViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSUInteger _pageIndex;
}
@property(nonatomic,strong)__block NSMutableArray *dataSourceArray;
@property(nonatomic,strong)TPKeyboardAvoidingTableView *tableView;
@property(nonatomic,assign)NSUInteger pageIndex;

@property(nonatomic,assign)UITableViewStyle tableViewStyle;
- (instancetype)initWithStyle:(UITableViewStyle)style;
@end
