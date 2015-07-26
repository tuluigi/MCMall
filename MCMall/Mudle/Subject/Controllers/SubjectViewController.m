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
   HHNetWorkOperation *op= [[HHNetWorkEngine sharedHHNetWorkEngine] getSubjectListWithPageIndex:_pageIndex pageSize:MCMallPageSize onCompletionHandler:^(HHResponseResult *responseResult) {
       if (responseResult.responseCode==HHResponseResultCode100) {
           if (_pageIndex) {
               [self.dataSourceArray removeAllObjects];
               [self.tableView dismissPageLoadView];
           }
           [self.dataSourceArray addObjectsFromArray:responseResult.responseData];
           [self.tableView reloadData];
       }
       [self.tableView handlerInifitScrollingWithPageIndex:&_pageIndex pageSize:MCMallPageSize totalDataCount:self.dataSourceArray.count];
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
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
@end
