//
//  UserCenterViewController.m
//  MCMall
//
//  Created by Luigi on 15/5/23.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "UserCenterViewController.h"
#import "UIViewController+MCMall.h"
#import "HHNetWorkEngine+UserCenter.h"
@interface UserCenterViewController ()

@end

@implementation UserCenterViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self verfiyUserLogin];
    [[HHNetWorkEngine sharedHHNetWorkEngine] userLoginWithUserName:@"admin" pwd:@"admin" onCompletionHandler:^(HHResponseResult *responseResult) {
        
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
