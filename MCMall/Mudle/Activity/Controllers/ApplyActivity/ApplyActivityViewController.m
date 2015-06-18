//
//  ApplyActivityViewController.m
//  MCMall
//
//  Created by Luigi on 15/6/18.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "ApplyActivityViewController.h"
#import "HHNetWorkEngine+Activity.h"
#import "ActivityModel.h"
@interface ApplyActivityViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UIWebView *footWebView;
@property(nonatomic,strong)ApplyActivityModel *activityModel;
@property(nonatomic,copy)NSString *activityID;
@property(nonatomic,assign)ActivityType actType;
@end

@implementation ApplyActivityViewController
-(id)initWithActivityID:(NSString *)activityID type:(ActivityType)type{
    if (self=[super init]) {
        self.activityID=activityID;
        _actType=type;
    }
    return self;
}
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
        _footWebView.scrollView.showsHorizontalScrollIndicator=NO;
        _footWebView.scrollView.showsVerticalScrollIndicator=NO;
    }
    return _footWebView;
}
-(void)setActivityModel:(ApplyActivityModel *)activityModel{
    _activityModel=activityModel;
    [self.tableView reloadData];
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:_activityModel.activityImageUrl] placeholderImage:MCMallDefaultImg];
    [self.footWebView loadHTMLString:_activityModel.activityDetail baseURL:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.actType==ActivityTypeApply) {
        self.title=@"报名活动";
    }else if (self.actType==ActivityTypeCommon){
    self.title=@"普通活动";
    }
    
    self.tableView.tableHeaderView=self.headImageView;
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
    [[HHNetWorkEngine sharedHHNetWorkEngine]  getActivityDetailWithActivityID:activityID activityType:self.actType userID:[UserModel userID] onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCode100) {
            weakSelf.activityModel=responseResult.responseData;
        }
        [weakSelf.tableView dismissPageLoadView];
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifer=@"identifer";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
    if (nil==cell) {
        cell=[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifer];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row==0) {
        
        cell.textLabel.textColor=MCMallThemeColor;
        cell.textLabel.font=[UIFont systemFontOfSize:16];
        cell.textLabel.text=self.activityModel.activityName;
        //cell.detailTextLabel.text=[NSString stringWithFormat:@"%ld报名",self.activityModel.totalVotedNum ];
        cell.detailTextLabel.textColor=[UIColor lightGrayColor];
        cell.detailTextLabel.font=[UIFont systemFontOfSize:14];
    }else if (indexPath.row==1){
        
    }
    return cell;
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    CGFloat  sizeHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] floatValue];
    CGRect frame=webView.frame;
    frame.size.height=sizeHeight;
    webView.frame=frame;
    webView.scrollView.scrollEnabled=NO;
    [self.tableView dismissPageLoadView];
}/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
