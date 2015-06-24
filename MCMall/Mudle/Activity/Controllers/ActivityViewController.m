//
//  ActivityViewController.m
//  MCMall
//
//  Created by Luigi on 15/5/23.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "ActivityViewController.h"
#import "HHNetWorkEngine+Activity.h"
#import "ActivityListCell.h"
#import "ActivityModel.h"
#import "VoteActivityViewController.h"
#import "ApplyActivityViewController.h"
@interface ActivityViewController ()

@end

@implementation ActivityViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   }
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"活动";
    WEAKSELF
    [self.tableView addPullToRefreshWithActionHandler:^{
        weakSelf.pageIndex=1;
        [weakSelf getActivityListWithPageNum:weakSelf.pageIndex pageSize:MCMallPageSize];
    }];
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        weakSelf.pageIndex++;
        [weakSelf getActivityListWithPageNum:weakSelf.pageIndex pageSize:MCMallPageSize];
    }];
    
    // Do any additional setup after loading the view.
    [self getActivityListWithPageNum:self.pageIndex pageSize:MCMallPageSize];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getActivityListWithPageNum:(NSUInteger)num pageSize:(NSInteger)size{
    WEAKSELF
    if (self.dataSourceArray.count==0) {
        [self.tableView showPageLoadingView];
    }
    [[HHNetWorkEngine sharedHHNetWorkEngine]  getActivityListWithUserID:[UserModel userID]  pageNum:num pageSize:size onCompletionHandler:^(HHResponseResult *responseResult) {
        [self.tableView dismissPageLoadView];
        if (responseResult.responseCode==HHResponseResultCode100) {
            if (num==1) {
                [weakSelf.dataSourceArray removeAllObjects];
                [weakSelf.dataSourceArray addObjectsFromArray:responseResult.responseData];
            }else{
                [weakSelf.dataSourceArray addObjectsFromArray:responseResult.responseData];
            }
            [weakSelf.tableView reloadData];
        }else{
            [weakSelf.tableView showPageLoadViewWithMessage:responseResult.responseMessage];
        }
         [weakSelf.tableView handlerInifitScrollingWithPageIndex:(&_pageIndex) pageSize:MCMallPageSize totalDataCount:weakSelf.dataSourceArray.count];
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *idenfierStr=@"idenfierStr";
    ActivityListCell *cell=(ActivityListCell *)[tableView dequeueReusableCellWithIdentifier:idenfierStr];
    if (nil==cell) {
        cell=[[ActivityListCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenfierStr];
    }
    ActivityModel *model=[self.dataSourceArray objectAtIndex:indexPath.row];
    cell.activityModel=model;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ActivityListCell activityCellHeight];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ActivityModel *model=[self.dataSourceArray objectAtIndex:indexPath.row];
    switch (model.activityType) {
        case ActivityTypeVote:{
            VoteActivityViewController *voteController=[[VoteActivityViewController alloc]  init];
            voteController.activityID=model.activityID;
            voteController.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:voteController animated:YES];
        }break;
        case ActivityTypeApply:
        case ActivityTypeCommon:{
            ApplyActivityViewController *applyActivityController=[[ApplyActivityViewController alloc]  initWithActivityID:model.activityID type:model.activityType];
            applyActivityController.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:applyActivityController animated:YES];
          }break;
            
        default:
            break;
    }
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
