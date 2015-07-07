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
@interface PhotoActivityViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *commentTextField;
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,copy)NSString *photoID,*photoUrl,*activityID;
@property(nonatomic,strong)UIImageView *headImageView;
@end

@implementation PhotoActivityViewController
-(void)dealloc{
    [self.tableView disSetupPanGestureControlKeyboardHide:YES];
}
-(id)initWithActivityID:(NSString *)activityID PhotoID:(NSString *)photoID photoUrl:(NSString *)url{
    if (self=[super init]) {
        _activityID=activityID;
        _photoID=photoID;
        _photoUrl=url;
    }
    return self;
}
-(UIView *)bottomView{
    if (nil==_bottomView) {
        _bottomView=[[UIView alloc]  init];
        [_bottomView addSubview:self.commentTextField];
    }
    return _bottomView;
}
-(UIImageView *)headImageView{
    if (nil==_headImageView) {
        _headImageView=[[UIImageView alloc]  initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)];
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:_photoUrl] placeholderImage:MCMallDefaultImg];
    }
    return _headImageView;
}
-(UITextField *)commentTextField{
    if (nil==_commentTextField) {
        _commentTextField=[[UITextField alloc]  init];
        _commentTextField.borderStyle=UITextBorderStyleRoundedRect;
        _commentTextField.placeholder=@"输入评论内容...";
        _commentTextField.delegate=self;
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
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.view).offset(-(weakSelf.commentTextField.bounds.size.height));
    }];
    UIButton *publishButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    publishButton.frame=CGRectMake(0, 0, 70, 50);
    //[publishButton setBackgroundColor:[UIColor redColor]];
    [publishButton setTitle:@"发送" forState:UIControlStateNormal];
    [publishButton setTitleColor:MCMallThemeColor forState:UIControlStateNormal];
    publishButton.titleLabel.font=[UIFont systemFontOfSize:16];
    [publishButton addTarget:self action:@selector(didPublishCommentButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    _commentTextField.rightView=publishButton;
    _commentTextField.rightViewMode=UITextFieldViewModeAlways;

    self.tableView.tableHeaderView=self.headImageView;
    [self getPhotoCommontsWithActivityID:self.activityID photoID:self.photoID];
    // Do any additional setup after loading the view.
    [self.tableView  setupPanGestureControlKeyboardHide:YES];
    self.tableView.keyboardWillChange=^(CGRect keyboardRect, UIViewAnimationOptions options, double duration, BOOL showKeyborad){
        [UIView animateWithDuration:duration animations:^{
            [weakSelf.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.removeExisting=YES;
                make.left.right.mas_equalTo(weakSelf.view);
                make.bottom.mas_equalTo(keyboardRect.size.height);
                make.top.mas_equalTo(keyboardRect.origin.y);
            }];
        }];

    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getPhotoCommontsWithActivityID:(NSString *)activityID photoID:(NSString *)photoID{
    if (self.dataSourceArray.count==0) {
         [HHProgressHUD showLoadingState];
    }
    WEAKSELF
    [[HHNetWorkEngine sharedHHNetWorkEngine]  getPhotoCommontsWithActivityID:activityID photoID:photoID userID:[UserModel userID]  pageIndex:1 pageSize:MCMallPageSize onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCode100) {
            [self.dataSourceArray addObjectsFromArray:responseResult.responseData];
            [weakSelf.tableView reloadData];
            [HHProgressHUD dismiss];
        }else{
            [HHProgressHUD showErrorMssage:responseResult.responseMessage];
        }
    }];
    
}
-(void)publistPhotoCommontsWithContent:(NSString *)content{
    [[HHNetWorkEngine sharedHHNetWorkEngine]  publishActivityCommentWithUserID:[UserModel userID] ActivityID:self.activityID photoID:self.photoUrl comments:@"ios发表一个评论，哈哈哈哈 " onCompletionHandler:^(HHResponseResult *responseResult) {
        [HHProgressHUD showErrorMssage:responseResult.responseMessage];
    }];

}
#pragma mark publishComment
-(void)didPublishCommentButtonPressed{

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *Identifer=@"photoIdentifer";
    PhotoCommontCell *cell=[tableView dequeueReusableCellWithIdentifier:Identifer];
    if (nil==cell) {
        cell=[[PhotoCommontCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifer];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    PhotoCommentModel *commentModel=[self.dataSourceArray objectAtIndex:indexPath.row];
    cell.commentModel=commentModel;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
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
