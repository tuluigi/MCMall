//
//  OrderListViewController.m
//  MCMall
//
//  Created by Luigi on 15/9/23.
//  Copyright © 2015年 Luigi. All rights reserved.
//

#import "OrderListViewController.h"
#import "HHUserNetService.h"
#import "GoodsModel.h"
#import "OrderListCell.h"
#define  OrderListCellIdentifer @"OrderListCellIdentifer"
@interface OrderListViewController ()

@end

@implementation OrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[OrderListCell class] forCellReuseIdentifier:OrderListCellIdentifer];
    self.title=@"我的预定";
   
    WEAKSELF
    [self.tableView addPullToRefreshWithActionHandler:^{
        weakSelf.pageIndex=1;
         [weakSelf getOrderListWithUserID:[HHUserManager userID] pageID:weakSelf.pageIndex];
    }];
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        weakSelf.pageIndex++;
        [weakSelf getOrderListWithUserID:[HHUserManager userID] pageID:weakSelf.pageIndex];
    }];
    [weakSelf getOrderListWithUserID:[HHUserManager userID] pageID:weakSelf.pageIndex];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getOrderListWithUserID:(NSString *)userID pageID:(NSInteger)pageID{
    WEAKSELF
    if (pageID==1) {
        [self.view showPageLoadingView];
    }else{
        [self.view showLoadingState];
    }
    HHNetWorkOperation *op=[HHUserNetService getOrderListWithUserID:userID pageIndex:pageID pageSize:MCMallPageSize onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCodeSuccess) {
            [weakSelf.view dismissPageLoadView];
            [weakSelf.view dismissHUD];
            if (pageID==1) {
                [weakSelf.dataSourceArray removeAllObjects];
            }
            [weakSelf.dataSourceArray addObjectsFromArray:responseResult.responseData];
            [weakSelf.tableView reloadData];
        }else{
            if (pageID==1) {
                [weakSelf.view showPageLoadedMessage:responseResult.responseMessage delegate:nil];
            }else{
                [weakSelf.view showErrorMssage:responseResult.responseMessage];
            };
        }
        [weakSelf.tableView handlerInifitScrollingWithPageIndex:&_pageIndex pageSize:MCMallPageSize totalDataCount:weakSelf.dataSourceArray.count ];
    }];
    [self addOperationUniqueIdentifer:op.uniqueIdentifier];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderListCell *cell=(OrderListCell *)[tableView dequeueReusableCellWithIdentifier:@"" forIndexPath:indexPath];
    OrderModel *orderModel=[self.dataSourceArray objectAtIndex:indexPath.row];
    cell.orderModel=orderModel;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
