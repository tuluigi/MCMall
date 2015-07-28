//
//  PhotoActivityViewController.m
//  MCMall
//
//  Created by Luigi on 15/6/28.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "PhotoActivityViewController.h"
#import "HHNetWorkEngine+Activity.h"
#import "ActivityModel.h"
#import "PhotoCommontCell.h"
#import "UIScrollView+HHKeyboardControl.h"
#import "UITableView+FDTemplateLayoutCell.h"
@interface PhotoActivityViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *commentTextField;
@property(nonatomic,strong)UIView *bottomView,*favorBgView;
@property(nonatomic,copy)NSString *activityID;
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UIButton *publishButton,*favorButton;
@property(nonatomic,strong)UILabel *favorCountLable;
@property(nonatomic,strong)PhotoModel *photoModle;
@end

@implementation PhotoActivityViewController
-(void)dealloc{
    [self.tableView disSetupPanGestureControlKeyboardHide:YES];
}
-(id)initWithActivityID:(NSString *)activityID PhotoID:(NSString *)photoID photoUrl:(NSString *)url{
    if (self=[super init]) {
        _photoModle=[[PhotoModel alloc]  init];
        _photoModle.photoID=photoID;
        _photoModle.photoUrl=url;
        _activityID=activityID;
    }
    return self;
}
-(UIView *)bottomView{
    if (nil==_bottomView) {
        _bottomView=[[UIView alloc]  init];
        _bottomView.backgroundColor=[UIColor red:240 green:240 blue:240 alpha:1];
        [_bottomView addSubview:self.commentTextField];
    }
    return _bottomView;
}
-(UIView *)favorBgView{
    if (nil==_favorBgView) {
        _favorBgView=[[UIView alloc]  init];
        _favorBgView.backgroundColor=[UIColor colorWithWhite:0.4 alpha:0.6];
    }
    return _favorBgView;
}
-(UIImageView *)headImageView{
    if (nil==_headImageView) {
        _headImageView=[[UIImageView alloc]  initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)];
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:_photoModle.photoUrl] placeholderImage:MCMallDefaultImg];
        [_headImageView addSubview:self.favorBgView];
    
        [_favorBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-10));
            make.bottom.mas_equalTo(-10);
           // make.size.mas_equalTo(CGSizeMake(100, 30));
        }];
        _favorButton=[UIButton buttonWithType:UIButtonTypeCustom];
        
        [_favorButton addTarget:self action:@selector(favorButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        _headImageView.userInteractionEnabled=YES;
        _favorBgView.userInteractionEnabled=YES;
        _favorButton.userInteractionEnabled=YES;
        
        [_favorButton setBackgroundImage:[UIImage imageNamed:@"favorButton"] forState:UIControlStateNormal];
        [_favorButton setBackgroundImage:[UIImage imageNamed:@"favorButton_HL"] forState:UIControlStateSelected];
        [self.favorBgView addSubview:_favorButton];
        [_favorButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@8);
            make.top.equalTo(@5);
            make.bottom.mas_equalTo(@(-5));
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
        _favorCountLable=[[UILabel alloc]  init];
        _favorCountLable.backgroundColor=[UIColor clearColor];
        _favorCountLable.textColor=MCMallThemeColor;
        _favorCountLable.font=[UIFont systemFontOfSize:13];
        [self.favorBgView addSubview:_favorCountLable];
        [_favorCountLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_favorButton.mas_right).offset(10);
            make.top.mas_equalTo(_favorButton);
            make.size.mas_equalTo(CGSizeMake(30, 20));
            make.right.mas_equalTo(-8);
            make.bottom.mas_equalTo(_favorButton.mas_bottom);
        }];
    }
    return _headImageView;
}
-(UITextField *)commentTextField{
    if (nil==_commentTextField) {
        _commentTextField=[[UITextField alloc]  init];
        _commentTextField.borderStyle=UITextBorderStyleRoundedRect;
        _commentTextField.placeholder=@"输入评论内容...";
        _commentTextField.delegate=self;
        [_commentTextField addTarget:self action:@selector(textFieldValueDidChange:) forControlEvents:UIControlEventEditingChanged];
        _publishButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        _publishButton.frame=CGRectMake(0, 5, 60, 40);
        //[publishButton setBackgroundColor:[UIColor redColor]];
        [_publishButton setTitle:@"发送" forState:UIControlStateNormal];
        _publishButton.enabled=NO;
        [_publishButton setTitleColor:MCMallThemeColor forState:UIControlStateNormal];
        _publishButton.titleLabel.font=[UIFont systemFontOfSize:16];
        [_publishButton addTarget:self action:@selector(didPublishCommentButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        _commentTextField.rightView=_publishButton;
        _commentTextField.rightViewMode=UITextFieldViewModeAlways;
       // _commentTextField.backgroundColor=[UIColor redColor];
       
    }
    return _commentTextField;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"图片详情";
    [self.view addSubview:self.bottomView];
    WEAKSELF
   
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf.view);
        make.height.mas_equalTo(50.0);
    }];
    [self.commentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(weakSelf.bottomView).offset(5.0);
        make.right.bottom.mas_equalTo(weakSelf.bottomView).offset(-5.0);
    }];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
       make.bottom.equalTo(@(-(weakSelf.bottomView.height)));
    }];
  

    self.tableView.tableHeaderView=self.headImageView;

    [self.tableView registerClass:[PhotoCommontCell class] forCellReuseIdentifier:@"photoIdentifer"];
    [self getPhotoCommontsWithActivityID:self.activityID photoID:self.photoModle.photoID];
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf getPhotoCommontsWithActivityID:weakSelf.activityID photoID:weakSelf.photoModle.photoID];
    }];
    [self.tableView addPullToRefreshWithActionHandler:^{
        _pageIndex=1;
        [weakSelf getPhotoCommontsWithActivityID:weakSelf.activityID photoID:weakSelf.photoModle.photoID];
    }];
    // Do any additional setup after loading the view.
    [self.tableView  setupPanGestureControlKeyboardHide:YES];
    self.tableView.keyboardWillChange=^(CGRect keyboardRect, UIViewAnimationOptions options, double duration, BOOL showKeyborad){
        [weakSelf.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
            if (showKeyborad) {
                make.bottom.equalTo(@(-(keyboardRect.size.height)));
            }else{
                make.bottom.equalTo(weakSelf.view);
            }
            
        }];
        [weakSelf.bottomView layoutIfNeeded];
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getPhotoCommontsWithActivityID:(NSString *)activityID photoID:(NSString *)photoID{
    if (self.photoModle.commentArray.count==0) {
         [HHProgressHUD showLoadingState];
    }
    WEAKSELF
    [[HHNetWorkEngine sharedHHNetWorkEngine]  getPhotoCommontsWithActivityID:activityID photoID:photoID userID:[UserModel userID]  pageIndex:self.pageIndex pageSize:MCMallPageSize onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCode100) {
            PhotoModel *model=responseResult.responseData;
            if (_pageIndex==1) {
                weakSelf.photoModle.isFavor=model.isFavor;
                weakSelf.photoModle.favorCount=model.favorCount;
                _favorCountLable.text=[NSString stringWithFormat:@"%ld 赞",weakSelf.photoModle.favorCount];
                if (weakSelf.photoModle.isFavor) {
                    _favorButton.selected=YES;
                }
            }
           
            if (nil==weakSelf.photoModle.commentArray) {
                weakSelf.photoModle.commentArray=[NSMutableArray new];
            }
            [weakSelf.photoModle.commentArray addObjectsFromArray:model.commentArray];
            [weakSelf.tableView reloadData];
            [HHProgressHUD dismiss];
        }else{
            [HHProgressHUD showErrorMssage:responseResult.responseMessage];
        }
        [self.tableView handlerInifitScrollingWithPageIndex:(&_pageIndex) pageSize:MCMallPageSize totalDataCount:self.photoModle.commentArray.count];
    }];
}
-(void)favorButtonPressed:(UIButton *)sender{
    if (!sender.isSelected) {
        WEAKSELF
        [HHProgressHUD showLoadingState];
        [[HHNetWorkEngine sharedHHNetWorkEngine] favorPhotoActivitWithUserID:[UserModel userID] activityID:self.activityID photoID:self.photoModle.photoID onCompletionHandler:^(HHResponseResult *responseResult) {
            if (responseResult.responseCode==HHResponseResultCode100) {
                weakSelf.photoModle.isFavor=YES;
                weakSelf.photoModle.favorCount++;
                 _favorCountLable.text=[NSString stringWithFormat:@"%ld 赞",weakSelf.photoModle.favorCount];
                [sender setSelected:YES];
            }else{
                [HHProgressHUD showErrorMssage:responseResult.responseMessage];
            }
        }];
    }
}
#pragma mark publishComment
-(void)didPublishCommentButtonPressed{
    if (self.commentTextField.text.length) {
        WEAKSELF
        [HHProgressHUD showLoadingState];
        [[HHNetWorkEngine sharedHHNetWorkEngine]  publishActivityCommentWithUserID:[UserModel userID] ActivityID:self.activityID photoID:self.photoModle.photoID comments:self.commentTextField.text onCompletionHandler:^(HHResponseResult *responseResult) {
            if (responseResult.responseCode==HHResponseResultCode100) {
                PhotoCommentModel *model=[[PhotoCommentModel alloc]  init];
                UserModel *userModel=[UserModel userModel];
                model.userName=userModel.userName;
                model.userImage=userModel.userHeadUrl;
                model.commentContents=weakSelf.commentTextField.text;
                NSString *timeStr=[[NSDate date] convertDateToStringWithFormat:@"yyyy-MM-dd HH:mm"];
                weakSelf.commentTextField.text=@"";
                model.commentTime=timeStr;
                [self.photoModle.commentArray insertObject:model atIndex:0];
                [weakSelf.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
                
                [weakSelf.commentTextField resignFirstResponder];
                [HHProgressHUD dismiss];
            }else{
                [HHProgressHUD showErrorMssage:responseResult.responseMessage];
            }
        }];
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.self.photoModle.commentArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *Identifer=@"photoIdentifer";
    PhotoCommontCell *cell=[tableView dequeueReusableCellWithIdentifier:Identifer];
    if (nil==cell) {
        cell=[[PhotoCommontCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifer];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    PhotoCommentModel *commentModel=[self.photoModle.commentArray objectAtIndex:indexPath.row];
    cell.commentModel=commentModel;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PhotoCommentModel *commentModel=[self.photoModle.commentArray objectAtIndex:indexPath.row];

    return [tableView fd_heightForCellWithIdentifier:@"photoIdentifer" cacheByIndexPath:indexPath configuration:^(id cell) {
        ((PhotoCommontCell *)cell).commentModel=commentModel;
    }];
}
#pragma mark -textFiled delegate
- (void)textFieldValueDidChange:(UITextField *)textField
{
    if (textField == self.commentTextField) {
        self.publishButton.enabled=textField.text.length;
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self didPublishCommentButtonPressed];
    return YES;
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
