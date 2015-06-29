//
//  VoteActivityViewController.m
//  MCMall
//
//  Created by Luigi on 15/6/9.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "VoteActivityViewController.h"
#import "HHNetWorkEngine+Activity.h"
#import "ActivityModel.h"
#import "PlayerCell.h"
@interface VoteActivityViewController ()<UIWebViewDelegate,PlayerCellDelegate>
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UIWebView *footWebView;
@property(nonatomic,strong)VoteActivityModel *activityModel;
@end

@implementation VoteActivityViewController

#pragma mark - getter setter
-(UIImageView *)headImageView{
    if (nil==_headImageView) {
        _headImageView=[[UIImageView alloc]  initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 150.0)];
    }
    return _headImageView;
}
-(UIWebView *)footWebView{
    if (nil==_footWebView) {
        _footWebView=[[UIWebView alloc]  initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 100)];
        _footWebView.delegate=self;
//        _footWebView.scrollView.showsHorizontalScrollIndicator=NO;
//        _footWebView.scrollView.showsVerticalScrollIndicator=NO;
    }
    return _footWebView;
}
-(void)setActivityModel:(VoteActivityModel *)activityModel{
    _activityModel=activityModel;
    [self.tableView reloadData];

   // [self.headImageView sd_setImageWithURL:[NSURL URLWithString:_activityModel.activityImageUrl] placeholderImage:MCMallDefaultImg];
    [self.footWebView loadHTMLString:[_activityModel activityDetailHtmlString] baseURL:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"投票活动";
  //  self.tableView.tableHeaderView=self.headImageView;
    self.tableView.tableFooterView=self.footWebView;
    [self getVoteAcitivityWithActivityID:self.activityID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getVoteAcitivityWithActivityID:(NSString *)activityID{
    WEAKSELF
    [self.tableView showPageLoadingView];
    [[HHNetWorkEngine sharedHHNetWorkEngine]  getActivityDetailWithActivityID:activityID activityType:ActivityTypeVote userID:[UserModel userID] onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCode100) {
            weakSelf.activityModel=responseResult.responseData;
        }
        [weakSelf.tableView dismissPageLoadView];
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.activityModel.playersArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifer=@"identifer";

    PlayerCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
    if (nil==cell) {
        cell=[[PlayerCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.delegate=self;
    }
    PlayerModel *model=[self.activityModel.playersArray objectAtIndex:indexPath.row];
    cell.playerModel=model;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PlayerCell playerCellHeight];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    CGFloat  sizeHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] floatValue];
    CGRect frame=webView.frame;
    frame.size.height=sizeHeight;
    webView.frame=frame;
    self.tableView.tableFooterView=webView;
    //webView.scrollView.scrollEnabled=NO;
    [self.tableView dismissPageLoadView];
}

#pragma mark playercelldelegate
-(void)playerCellDidVoteButtonPressedWithPlayer:(PlayerModel *)playerModel{
    [HHProgressHUD showLoadingMessage:@"正在投票"];
    [[HHNetWorkEngine sharedHHNetWorkEngine]  voteActivityWithUserID:[UserModel userID] ActivityID:self.activityID voteNum:1 onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCode100) {
              [HHProgressHUD showSuccessMessage:responseResult.responseMessage];
        }else{
          [HHProgressHUD showErrorMssage:responseResult.responseMessage];
        }
       
    }];
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
