//
//  RootTabBarController.m
//  MCMall
//
//  Created by Luigi on 15/5/23.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "RootTabBarController.h"
#import "MCMallViewController.h"
#import "ActivityViewController.h"
#import "HealthViewController.h"
#import "UserCenterViewController.h"
@interface RootTabBarController ()

@end

@implementation RootTabBarController
-(id)init{
    if (self=[super init]) {
        [self onInitTabrControllers];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)onInitTabrControllers{
   
   /*
    MCMallViewController *mcMallController=[[MCMallViewController alloc]  init];
    UINavigationController *mcNavController=[[UINavigationController alloc]  initWithRootViewController:mcMallController];
    mcNavController.tabBarItem.title=@"商城";
    */
    HealthViewController *healthController=[[HealthViewController alloc]  init];
    UINavigationController *healthNavController=[[UINavigationController alloc]  initWithRootViewController:healthController];
    healthNavController.tabBarItem.title=@"健康安全";
    
    
    ActivityViewController *activityController=[[ActivityViewController alloc]  init];
    UINavigationController *activityNavController=[[UINavigationController alloc]  initWithRootViewController:activityController];
activityNavController.tabBarItem.title=@"活动";
    
    UserCenterViewController *userCenterController=[[UserCenterViewController alloc]  init];
    UINavigationController *userNavController=[[UINavigationController alloc]  initWithRootViewController:userCenterController];
    userNavController.tabBarItem.title=@"个人中心";
    
    
    NSMutableArray *tabBarControllers=[[NSMutableArray alloc]  initWithObjects:healthNavController,activityNavController,userNavController, nil];
    self.viewControllers=tabBarControllers;
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
