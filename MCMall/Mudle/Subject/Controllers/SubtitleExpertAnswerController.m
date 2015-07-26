//
//  SubtitleExpertAnswerController.m
//  MCMall
//
//  Created by Luigi on 15/7/26.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "SubtitleExpertAnswerController.h"
#import "SubjectModel.h"
#import "HHNetWorkEngine+Subtitle.h"
#import "SubjectAnswerCell.h"
@interface SubtitleExpertAnswerController ()
@property(nonatomic,copy)NSString *subjectID,*subjectTitle;
@end

@implementation SubtitleExpertAnswerController
-(id)initWithSubjectID:(NSString *)subjectID title:(NSString *)title{
    self=[super init];
    if (self) {
        _subjectID=subjectID;
        _subjectTitle=title;
    }
    return self;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title=_subjectTitle;
    WEAKSELF
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf getSubjectAnswerWithSubjectID:weakSelf.subjectID];
    }];
    [self.tableView addPullToRefreshWithActionHandler:^{
        [weakSelf getSubjectAnswerWithSubjectID:weakSelf.subjectID];
    }];
    [self getSubjectAnswerWithSubjectID:self.subjectID];
}

-(void)getSubjectAnswerWithSubjectID:(NSString *)subjectID{
    if (self.dataSourceArray.count==0) {
        [self.view showPageLoadingView];
    }
    WEAKSELF
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine]  getSubjectDetailWithSubjectID:subjectID pageIndex:_pageIndex pageSize:MCMallPageSize onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCode100) {
            if (weakSelf.dataSourceArray.count==0) {
                [weakSelf.view dismissPageLoadView];
            }
            if (_pageIndex==1) {
                [weakSelf.dataSourceArray removeAllObjects];
            }
            [weakSelf.dataSourceArray addObjectsFromArray:responseResult.responseData];
            [weakSelf.tableView reloadData];
        }else{
            if (weakSelf.dataSourceArray==0) {
                [weakSelf.view showPageLoadViewWithMessage:responseResult.responseMessage];
            }else{
                [HHProgressHUD showErrorMssage:responseResult.responseMessage];
            }
        }
        [weakSelf.tableView handlerInifitScrollingWithPageIndex:&_pageIndex pageSize:MCMallPageSize totalDataCount:weakSelf.dataSourceArray.count];
    }];
    [self addOperationUniqueIdentifer:op.uniqueIdentifier];
}

#pragma mark -tableview
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *idenfier=@"cellidentifer";
    SubjectAnswerCell *cell=[tableView dequeueReusableCellWithIdentifier:idenfier];
    if (nil==cell) {
        cell=[[SubjectAnswerCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenfier];
    }
    
    return cell;
}


@end
