//
//  BradnListViewController.m
//  MCMall
//
//  Created by Luigi on 15/11/15.
//  Copyright © 2015年 Luigi. All rights reserved.
//

#import "BradnListViewController.h"
#import "GoodsNetService.h"
#import "BrandListCell.h"
#import "GoodsListViewController.h"
#import "BrandModel.h"
 static NSString *brandListCellIdentifer = @"brandListCellIdentifer";

@interface BradnListViewController ()
@property(nonatomic,assign)NSInteger brandType;
@end

@implementation BradnListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"享约汇";
    WEAKSELF
    [self.tableView addPullToRefreshWithActionHandler:^{
        [weakSelf getBradnList];
    }];
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf getBradnList];
    }];
    [self.tableView registerClass:[BrandListCell class] forCellReuseIdentifier:brandListCellIdentifer];
    [self getBradnList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getBradnList{
    WEAKSELF
    if (self.dataSourceArray.count==0) {
        [self.tableView showPageLoadingView];
    }
   HHNetWorkOperation *op=[GoodsNetService getBrandListWithPageIndex:self.pageIndex pageSize:MCMallPageSize group:self.goodsItemTag onCompletionHandler:^(HHResponseResult *responseResult) {
       [self.tableView dismissPageLoadView];
        if (responseResult.responseCode==HHResponseResultCodeSuccess) {
            if (weakSelf.pageIndex==1) {
                [weakSelf.dataSourceArray removeAllObjects];
            }
            [weakSelf.dataSourceArray addObjectsFromArray:responseResult.responseData];
            [weakSelf.tableView reloadData];
            [weakSelf.view dismissHUD];
        }else{
            if (weakSelf.pageIndex==1) {
                [weakSelf.view showPageLoadedMessage:responseResult.responseMessage delegate:nil];
            }else{
                [weakSelf.view showErrorMssage:responseResult.responseMessage];
            }
        }
       [weakSelf.tableView handlerInifitScrollingWithPageIndex:&_pageIndex pageSize:MCMallPageSize totalDataCount:weakSelf.dataSourceArray.count];
    }];
    [self addOperationUniqueIdentifer:op.uniqueIdentifier];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BrandListCell *cell=[tableView dequeueReusableCellWithIdentifier:brandListCellIdentifer forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.brandModel=[self.dataSourceArray objectAtIndex:indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    __block BrandModel *brandModel=[self.dataSourceArray objectAtIndex:indexPath.row];
    CGFloat height=[tableView fd_heightForCellWithIdentifier:brandListCellIdentifer configuration:^(id cell) {
        [(BrandListCell *)cell setBrandModel: brandModel];
    }];
    return height;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
     BrandModel *brandModel=[self.dataSourceArray objectAtIndex:indexPath.row];
    GoodsListViewController *goodsListController=[[GoodsListViewController alloc]  init];
    goodsListController.brandID=brandModel.brandID;
    goodsListController.vipGoodsItemTag=self.goodsItemTag;
    goodsListController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:goodsListController animated:YES];
}
@end
