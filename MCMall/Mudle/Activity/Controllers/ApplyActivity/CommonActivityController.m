//
//  CommonActivityController.m
//  MCMall
//
//  Created by Luigi on 15/6/29.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "CommonActivityController.h"
#import "ActivityModel.h"
#import "HHNetWorkEngine+Activity.h"
@interface CommonActivityController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *footWebView;
@property(nonatomic,strong)ActivityModel *activityModel;
@property(nonatomic,copy)NSString *activityID;
@end

@implementation CommonActivityController
-(id)initWithActivityID:(NSString *)activityID{
    self=[super init];
    if (self) {
        _activityID=activityID;
    }
    return self;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    [self.view addSubview:self.footWebView];
    [self getVoteAcitivityWithActivityID:self.activityID];
}
-(UIWebView *)footWebView{
    if (nil==_footWebView) {
        _footWebView=[[UIWebView alloc]  init];
        [self.view addSubview:_footWebView];
        [_footWebView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        _footWebView.delegate=self;
        //        _footWebView.scrollView.showsHorizontalScrollIndicator=NO;
        //        _footWebView.scrollView.showsVerticalScrollIndicator=NO;
    }
    return _footWebView;
}
-(void)setActivityModel:(ApplyActivityModel *)activityModel{
    _activityModel=activityModel;

    //  [self.headImageView sd_setImageWithURL:[NSURL URLWithString:_activityModel.activityImageUrl] placeholderImage:MCMallDefaultImg];
    [self.footWebView loadHTMLString:[_activityModel activityDetailHtmlString] baseURL:nil];
}
-(void)getVoteAcitivityWithActivityID:(NSString *)activityID{
    WEAKSELF
    [self.view showPageLoadingView];
    [[HHNetWorkEngine sharedHHNetWorkEngine]  getActivityDetailWithActivityID:activityID activityType:ActivityTypeCommon userID:[UserModel userID] sortMethod:@"0"  onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCode100) {
            weakSelf.activityModel=responseResult.responseData;
        }
        [weakSelf.view dismissPageLoadView];
    }];
}
@end
