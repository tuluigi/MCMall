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
@interface PhotoActivityViewController ()
@property(nonatomic,copy)NSString *photoID,*photoUrl,*activityID;
@property(nonatomic,strong)UIImageView *headImageView;
@end

@implementation PhotoActivityViewController
-(id)initWithActivityID:(NSString *)activityID PhotoID:(NSString *)photoID photoUrl:(NSString *)url{
    if (self=[super init]) {
        _activityID=activityID;
        _photoID=photoID;
        _photoUrl=url;
    }
    return self;
}
-(UIImageView *)headImageView{
    if (nil==_headImageView) {
        _headImageView=[[UIImageView alloc]  initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)];
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:_photoUrl] placeholderImage:MCMallDefaultImg];
    }
    return _headImageView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView=self.headImageView;
    [self getPhotoCommontsWithActivityID:self.activityID photoID:self.photoID];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getPhotoCommontsWithActivityID:(NSString *)activityID photoID:(NSString *)photoID{
    if (self.dataSourceArray.count==0) {
        [self.tableView showPageLoadingView];
    }
    WEAKSELF
    [[HHNetWorkEngine sharedHHNetWorkEngine]  getPhotoCommontsWithActivityID:activityID photoID:photoID userID:[UserModel userID]  pageIndex:1 pageSize:MCMallPageSize onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCode100) {
            
        }else{
        
        }
        [self.tableView dismissPageLoadView];
    }];
    
}
-(void)publistPhotoCommontsWithContent:(NSString *)content{
    [[HHNetWorkEngine sharedHHNetWorkEngine]  publishActivityCommentWithUserID:[UserModel userID] ActivityID:self.activityID photoID:self.photoUrl comments:@"ios发表一个评论，哈哈哈哈 " onCompletionHandler:^(HHResponseResult *responseResult) {
        [HHProgressHUD showErrorMssage:responseResult.responseMessage];
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
