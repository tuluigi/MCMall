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
#import "UITableView+FDTemplateLayoutCell.h"
#import "UIScrollView+HHKeyboardControl.h"
@interface SubtitleExpertAnswerController ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *commentTextField;
@property(nonatomic,copy)NSString *subjectID,*subjectTitle;
@property(nonatomic,assign)SubjectModelState subjectState;
@end

@implementation SubtitleExpertAnswerController
-(void)dealloc{
    [self.tableView disSetupPanGestureControlKeyboardHide:YES];
}
-(UITextField *)commentTextField{
    if (nil==_commentTextField) {
        _commentTextField=[[UITextField alloc]  init];
        _commentTextField.borderStyle=UITextBorderStyleRoundedRect;
        _commentTextField.placeholder=@"输入问题...";
        _commentTextField.delegate=self;
        [_commentTextField addTarget:self action:@selector(textFieldValueDidChange:) forControlEvents:UIControlEventEditingChanged];
        _commentTextField.returnKeyType=UIReturnKeyDone;
        //  _commentTextField.backgroundColor=[UIColor redColor];
        
    }
    return _commentTextField;
}
-(id)initWithSubjectID:(NSString *)subjectID title:(NSString *)title state:(SubjectModelState)state{
    self=[super init];
    if (self) {
        _subjectID=subjectID;
        _subjectTitle=title;
        _subjectState=state;
    }
    return self;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    
    WEAKSELF
    if (self.subjectState==SubjectModelStateProcessing) {
        [self.view addSubview:self.commentTextField];
        [self.commentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(weakSelf.view);
            make.height.mas_equalTo(50.0);
        }];
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.commentTextField.mas_top).priorityHigh();
        }];
    }
    
    [self.tableView  setupPanGestureControlKeyboardHide:YES];
    self.tableView.keyboardWillChange=^(CGRect keyboardRect, UIViewAnimationOptions options, double duration, BOOL showKeyborad){
        [weakSelf.commentTextField mas_updateConstraints:^(MASConstraintMaker *make) {
            if (showKeyborad) {
                make.bottom.equalTo(@(-(keyboardRect.size.height)));
            }else{
                make.bottom.equalTo(weakSelf.view);
            }
            
        }];
        [weakSelf.commentTextField layoutIfNeeded];
    };
    
    self.title=_subjectTitle;
    
    [self.tableView registerClass:[SubjectAnswerCell class] forCellReuseIdentifier:@"cellidentifer"];
    
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        weakSelf.pageIndex++;
        [weakSelf getSubjectAnswerWithSubjectID:weakSelf.subjectID];
    }];
    [self.tableView addPullToRefreshWithActionHandler:^{
        weakSelf.pageIndex=1;
        [weakSelf getSubjectAnswerWithSubjectID:weakSelf.subjectID];
    }];
    [self getSubjectAnswerWithSubjectID:self.subjectID];
}

-(void)getSubjectAnswerWithSubjectID:(NSString *)subjectID{
    if (self.dataSourceArray.count==0) {
        [self.view showPageLoadingView];
    }
    WEAKSELF
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine]  getSubjectDetailWithSubjectID:subjectID userID:[HHUserManager userID]  pageIndex:_pageIndex pageSize:MCMallPageSize onCompletionHandler:^(HHResponseResult *responseResult) {
        [weakSelf.view dismissPageLoadView];
        if (responseResult.responseCode==HHResponseResultCode100) {
            if (_pageIndex==1) {
                [weakSelf.dataSourceArray removeAllObjects];
            }
            [weakSelf.dataSourceArray addObjectsFromArray:responseResult.responseData];
            [weakSelf.tableView reloadData];
            if (weakSelf.dataSourceArray.count==0) {
                if (_subjectState==SubjectModelStateProcessing) {
                     [HHProgressHUD makeToast:@"暂时还没有问题,赶紧来提问吧！"];
                }else{
                    [weakSelf.tableView showPageLoadViewWithMessage:@"暂时没有更多内容"];
                }
            }else{
                if (((NSArray *)responseResult.responseData).count==0) {
                    [HHProgressHUD makeToast:@"暂时没有更多内容"];
                }
            }
        }else{
            if (weakSelf.dataSourceArray.count==0) {
                [weakSelf.view showPageLoadViewWithMessage:responseResult.responseMessage];
            }else{
                [HHProgressHUD makeToast:responseResult.responseMessage];
            }
        }
        [weakSelf.tableView handlerInifitScrollingWithPageIndex:&_pageIndex pageSize:MCMallPageSize totalDataCount:weakSelf.dataSourceArray.count];
    }];
    [self addOperationUniqueIdentifer:op.uniqueIdentifier];
}
-(void)askQuestionWithSubjectID:(NSString *)subjectID question:(NSString *)question{
    WEAKSELF
    [HHProgressHUD showLoadingState];
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine]  askSubjectQuestionWithSubjectID:subjectID userID:[HHUserManager userID] questionContent:question onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCode100) {
            SubjectCommentModel *commentModel=[[SubjectCommentModel alloc]  init];
            commentModel.commentComment=question;
            UserModel *userModel=[HHUserManager userModel];
            commentModel.commentUserID=[HHUserManager userID];
            commentModel.commentUserImageUrl=userModel.userHeadUrl;
            commentModel.commentUserName=userModel.userName;
            commentModel.commentTime=[[NSDate date] convertDateToStringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
            [weakSelf.dataSourceArray addObject:commentModel];
            NSIndexPath *indexPath= [NSIndexPath indexPathForRow:(weakSelf.dataSourceArray.count-1) inSection:0];
            [weakSelf.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [weakSelf.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            [HHProgressHUD showSuccessMessage:responseResult.responseMessage];
            weakSelf.commentTextField.text=@"";
        }else{
            [HHProgressHUD showErrorMssage:responseResult.responseMessage];
        }
        
    }];
    [self addOperationUniqueIdentifer:op.uniqueIdentifier];
}
#pragma mark -tableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *idenfier=@"cellidentifer";
    SubjectAnswerCell *cell=[tableView dequeueReusableCellWithIdentifier:idenfier];
    if (nil==cell) {
        cell=[[SubjectAnswerCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenfier];
    }
    SubjectCommentModel *commentModel=[self.dataSourceArray objectAtIndex:indexPath.row];
    cell.subjectCommentModel=commentModel;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   __block SubjectCommentModel *commentModel=[self.dataSourceArray objectAtIndex:indexPath.row];
    return [tableView fd_heightForCellWithIdentifier:@"cellidentifer" cacheByIndexPath:indexPath configuration:^(id cell) {
        ((SubjectAnswerCell *)cell).subjectCommentModel=commentModel;
    }];
    
}
#pragma mark textField
#pragma mark -textFiled delegate
- (void)textFieldValueDidChange:(UITextField *)textField
{
    if (textField == self.commentTextField) {
        // self.publishButton.enabled=textField.text.length;
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.text.length) {
        [self askQuestionWithSubjectID:self.subjectID question:textField.text];
    }
    [textField resignFirstResponder];
    return YES;
}
@end
