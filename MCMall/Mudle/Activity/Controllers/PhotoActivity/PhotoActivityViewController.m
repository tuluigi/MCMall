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
@property(nonatomic,copy)NSString *activityID;
@property(nonatomic,strong)ActivityModel *activityModel;
@end

@implementation PhotoActivityViewController
-(id)initWithActivityID:(NSString *)activityID{
    if (self=[super init]) {
        _activityID=activityID;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getPhotoAcitivityWithActivityID:self.activityID];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getPhotoAcitivityWithActivityID:(NSString *)activityID{
    WEAKSELF
    [self.tableView showPageLoadingView];
    [[HHNetWorkEngine sharedHHNetWorkEngine]  getActivityDetailWithActivityID:activityID activityType:ActivityTypePicture userID:[UserModel userID] onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCode100) {
            weakSelf.activityModel=responseResult.responseData;
        }
        [weakSelf.tableView dismissPageLoadView];
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
