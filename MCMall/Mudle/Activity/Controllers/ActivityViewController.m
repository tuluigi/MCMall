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
#import "PhotoActivityViewController.h"
#import "CommonActivityController.h"
#import "HHNetWorkEngine+Activity.h"
#import "UITableView+FDTemplateLayoutCell.h"
@interface ActivityViewController ()

@end

@implementation ActivityViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.dataSourceArray.count==0) {
         [self getActivityListWithPageNum:self.pageIndex pageSize:MCMallPageSize];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"活动";
    WEAKSELF
    NSString *commonIdenfierStr=[ActivityListCell activityListCellIdentiferWithActType:ActivityTypeCommon];
    NSString *photoIdenfierStr=[ActivityListCell activityListCellIdentiferWithActType:ActivityTypePicture];
    [self.tableView registerClass:[ActivityListCell class] forCellReuseIdentifier:commonIdenfierStr];
    [self.tableView registerClass:[ActivityListCell class] forCellReuseIdentifier:photoIdenfierStr];
    [self.tableView addPullToRefreshWithActionHandler:^{
        weakSelf.pageIndex=1;
        [weakSelf getActivityListWithPageNum:weakSelf.pageIndex pageSize:MCMallPageSize];
    }];
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf getActivityListWithPageNum:weakSelf.pageIndex pageSize:MCMallPageSize];
    }];
    
    // Do any additional setup after loading the view.
//    [self getActivityListWithPageNum:self.pageIndex pageSize:MCMallPageSize];
    
    [[NSNotificationCenter defaultCenter]  addObserverForName:UserLoginSucceedNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        [weakSelf getActivityListWithPageNum:weakSelf.pageIndex pageSize:MCMallPageSize];
    }];
    [[NSNotificationCenter defaultCenter]  addObserverForName:UserLogoutSucceedNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        weakSelf.pageIndex=1;
        [weakSelf.dataSourceArray removeAllObjects];
        [weakSelf.tableView reloadData];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getActivityListWithPageNum:(NSUInteger)num pageSize:(NSInteger)size{
    WEAKSELF
    if (self.dataSourceArray.count==0) {
        [self.view showPageLoadingView];
    }
   HHNetWorkOperation *operation=[[HHNetWorkEngine sharedHHNetWorkEngine]  getActivityListWithUserID:[HHUserManager userID]  pageNum:num pageSize:size onCompletionHandler:^(HHResponseResult *responseResult) {
        [weakSelf.view dismissPageLoadView];
        if (responseResult.responseCode==HHResponseResultCodeSuccess) {
            if (num==1) {
                [weakSelf.dataSourceArray removeAllObjects];
                [weakSelf.dataSourceArray addObjectsFromArray:responseResult.responseData];
            }else{
                [weakSelf.dataSourceArray addObjectsFromArray:responseResult.responseData];
            }
            [weakSelf.tableView reloadData];
        }else{
            [weakSelf.view showPageLoadedMessage:responseResult.responseMessage delegate:nil];
        }
         [weakSelf.tableView handlerInifitScrollingWithPageIndex:(&_pageIndex) pageSize:MCMallPageSize totalDataCount:weakSelf.dataSourceArray.count];
    }];
    [self addOperationUniqueIdentifer:operation.uniqueIdentifier];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ActivityModel *model=[self.dataSourceArray objectAtIndex:indexPath.row ];
    NSString *idenfierStr=[ActivityListCell activityListCellIdentiferWithActType:model.activityType];
    ActivityListCell *cell=(ActivityListCell *)[tableView dequeueReusableCellWithIdentifier:idenfierStr forIndexPath:indexPath];
    cell.activityModel=model;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ActivityModel *model=[self.dataSourceArray objectAtIndex:indexPath.row];
    CGFloat height=0;
     NSString *idenfierStr=[ActivityListCell activityListCellIdentiferWithActType:model.activityType];
    height=[tableView fd_heightForCellWithIdentifier:idenfierStr  configuration:^(id cell) {
        ((ActivityListCell *)cell).activityModel=model;
    }];
    return height;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    ActivityModel *model=[self.dataSourceArray objectAtIndex:indexPath.row];
    VoteActivityViewController *voteController=[[VoteActivityViewController alloc]  initWithActivityID:model.activityID type:model.activityType];
    voteController.activityID=model.activityID;
    voteController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:voteController animated:YES];
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
