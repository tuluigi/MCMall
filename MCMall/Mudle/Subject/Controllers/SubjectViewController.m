//
//  SubjectViewController.m
//  MCMall
//
//  Created by Luigi on 15/7/26.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "SubjectViewController.h"
#import "SubjectListCell.h"
#import "HHNetWorkEngine+Subtitle.h"
#import "SubjectModel.h"
#import "SubtitleExpertAnswerController.h"
@interface SubjectViewController ()

@end

@implementation SubjectViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title=@"专家问答";
    WEAKSELF
    [self.tableView addPullToRefreshWithActionHandler:^{
        [weakSelf getSubjectList];
    }];
    [self.tableView addPullToRefreshWithActionHandler:^{
        [weakSelf getSubjectList];
    }];
    [self getSubjectList];
}

-(void)getSubjectList{
    if (self.dataSourceArray.count==0) {
        [self.tableView showPageLoadingView];
    }
    WEAKSELF
   HHNetWorkOperation *op= [[HHNetWorkEngine sharedHHNetWorkEngine] getSubjectListWithPageIndex:_pageIndex pageSize:MCMallPageSize onCompletionHandler:^(HHResponseResult *responseResult) {
       if (responseResult.responseCode==HHResponseResultCode100) {
           if (weakSelf.dataSourceArray.count==0) {
               [weakSelf.tableView dismissPageLoadView];
           }
           if (_pageIndex==1) {
               [weakSelf.dataSourceArray removeAllObjects];
           }
           [weakSelf.dataSourceArray addObjectsFromArray:responseResult.responseData];
           [weakSelf.tableView reloadData];
       }else{
           if (weakSelf.dataSourceArray.count==0) {
               [weakSelf.view showPageLoadViewWithMessage:responseResult.responseMessage];
           }else{
               [HHProgressHUD showErrorMssage:responseResult.responseMessage];
           }
       }
       [weakSelf.tableView handlerInifitScrollingWithPageIndex:&_pageIndex pageSize:MCMallPageSize totalDataCount:self.dataSourceArray.count];
    }];
    [self addOperationUniqueIdentifer:op.uniqueIdentifier];
}

#pragma mark -tableviewdelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifer=@"idenfier";
    SubjectListCell *cell=(SubjectListCell *)[tableView dequeueReusableCellWithIdentifier:identifer];
    if (nil==cell) {
        cell=[[SubjectListCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    SubjectModel *subjectModel=[self.dataSourceArray objectAtIndex:indexPath.row];
    cell.subjectModel=subjectModel;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SubjectModel *subjectModel=[self.dataSourceArray objectAtIndex:indexPath.row];
    SubtitleExpertAnswerController *expertViewController=[[SubtitleExpertAnswerController alloc] initWithSubjectID:subjectModel.subjectID title:subjectModel.subjectTitle];
    expertViewController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:expertViewController animated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
@end
