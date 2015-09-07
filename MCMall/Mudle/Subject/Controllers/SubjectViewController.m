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
#import "SubjectNetService.h"
@interface SubjectViewController ()

@end

@implementation SubjectViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.dataSourceArray.count==0) {
        [self getSubjectList];
    }
}

-(void)viewDidLoad{
    [super viewDidLoad];
    WEAKSELF
    [self.tableView addPullToRefreshWithActionHandler:^{
        _pageIndex=1;
        [weakSelf getSubjectList];
    }];
    [self.tableView addPullToRefreshWithActionHandler:^{
        [weakSelf getSubjectList];
    }];
}

-(void)getSubjectList{
    if (self.dataSourceArray.count==0) {
        [self.tableView showPageLoadingView];
    }
    WEAKSELF
    HHNetWorkOperation *op= [SubjectNetService getSubjectListWithPageIndex:_pageIndex pageSize:MCMallPageSize onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCodeSuccess) {
            if (_pageIndex==1) {
                [weakSelf.dataSourceArray removeAllObjects];
            }
            for (NSInteger i=0; i<6; i++) {
                  [weakSelf.dataSourceArray addObjectsFromArray:responseResult.responseData];
            }
          
            [weakSelf.tableView reloadData];
            if (weakSelf.dataSourceArray.count==0) {
                [weakSelf.tableView showPageLoadedMessage:@"暂时没有更多内容" delegate:nil];
            }else{
                [weakSelf.tableView dismissPageLoadView];
                if (((NSArray *)responseResult.responseData).count==0) {
                    [weakSelf.view makeToast:@"没有更多内容"];
                }
            }
        }else{
            if (weakSelf.dataSourceArray.count==0) {
                [weakSelf.view showPageLoadedMessage:responseResult.responseMessage delegate:nil];
            }else{
                [weakSelf.view makeToast:responseResult.responseMessage];
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
    if ([HHUserManager isLogin]) {
        if (subjectModel.subjectState==SubjectModelStateProcessing||subjectModel.subjectState==SubjectModelStateFinsihed){
            SubtitleExpertAnswerController *expertViewController=[[SubtitleExpertAnswerController alloc] initWithSubjectID:subjectModel.subjectID title:subjectModel.subjectTitle state:subjectModel.subjectState];
            expertViewController.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:expertViewController animated:YES];
            
        }else if (subjectModel.subjectState==SubjectModelStateUnStart){
            [self.view makeToast:@"专题尚未开始"];
        }}else{
            WEAKSELF
            [HHUserManager shouldUserLoginOnCompletionBlock:^(BOOL isSucceed, NSString *userID){
                if (isSucceed) {
                    [weakSelf tableView:tableView didSelectRowAtIndexPath:indexPath ];
                }
            }];
        }
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
@end
