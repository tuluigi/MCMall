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
#import "QBImagePickerController.h"
#import "HHNetWorkEngine+Activity.h"
@interface ActivityViewController ()<QBImagePickerControllerDelegate>

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
   HHNetWorkOperation *operation=[[HHNetWorkEngine sharedHHNetWorkEngine]  getActivityListWithUserID:[HHUserManager userID]  pageNum:num pageSize:size onCompletionHandler:^(HHResponseResult *responseResult) {
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
    [self addOperationUniqueIdentifer:operation.uniqueIdentifier];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ActivityModel *model=[self.dataSourceArray objectAtIndex:indexPath.row];
    NSString *idenfierStr=[ActivityListCell activityListCellIdentiferWithActType:model.activityType];
    ActivityListCell *cell=(ActivityListCell *)[tableView dequeueReusableCellWithIdentifier:idenfierStr];
    if (nil==cell) {
        cell=[[ActivityListCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenfierStr activityType:model.activityType];
    }
    cell.activityModel=model;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ActivityModel *model=[self.dataSourceArray objectAtIndex:indexPath.row];
    return [ActivityListCell activityCellHeightWithActType:model.activityType];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    ActivityModel *model=[self.dataSourceArray objectAtIndex:indexPath.row];
    VoteActivityViewController *voteController=[[VoteActivityViewController alloc]  initWithActivityID:model.activityID type:model.activityType];
    voteController.activityID=model.activityID;
    voteController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:voteController animated:YES];
    
/*
    switch (model.activityType) {
        case ActivityTypeVote:{
            VoteActivityViewController *voteController=[[VoteActivityViewController alloc]  initWithActivityID:model.activityID type:model.activityType];
            voteController.activityID=model.activityID;
            voteController.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:voteController animated:YES];
        }break;
        case ActivityTypeApply:{
            ApplyActivityViewController *applyActivityController=[[ApplyActivityViewController alloc]  initWithActivityID:model.activityID type:model.activityType];
            applyActivityController.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:applyActivityController animated:YES];
        }break;
        case ActivityTypeCommon:{
            CommonActivityController *commonActivityController=[[CommonActivityController alloc]  initWithActivityID:model.activityID];
            commonActivityController.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:commonActivityController animated:YES];
          }break;
        case ActivityTypePicture:{
            PhotoActivityViewController *photoActivitController=[[PhotoActivityViewController alloc]  initWithActivityID:model.activityID];
            photoActivitController.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:photoActivitController animated:YES];
        }break;
        default:
            break;
    }
 */
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
