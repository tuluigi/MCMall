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
@interface VoteActivityViewController ()

@end

@implementation VoteActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"投票活动";
    [self getVoteAcitivityWithActivityID:self.activityID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getVoteAcitivityWithActivityID:(NSString *)activityID{
    [[HHNetWorkEngine sharedHHNetWorkEngine]  getActivityDetailWithActivityID:activityID activityType:ActivityTypeVote userID:[UserModel userID] onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCode100) {
            
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
