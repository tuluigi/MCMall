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
#import "SubjectViewController.h"
@interface HHTabBarItem  : UITabBarItem;
@end
@implementation HHTabBarItem
- (id)initWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage
{
    //   image=[UIImage scaleImage:image ToSize:CGSizeMake(28.0, 28.0)];
    //    selectedImage=[UIImage scaleImage:selectedImage ToSize:CGSizeMake(28.0, 28.0)];
    self = [super initWithTitle:title image:image selectedImage:selectedImage];
#ifdef __IPHONE_7_0
    [self setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self setSelectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
#else
    [self setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:image];
#endif
    if (self) {
        // Custom initializatio
        [self setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:13],NSFontAttributeName,[UIColor grayColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        [self setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:13],NSFontAttributeName,MCMallThemeColor,NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    }
    return self;
}
@end


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
     
    HealthViewController *healthController=[[HealthViewController alloc]  init];
    UINavigationController *healthNavController=[[UINavigationController alloc]  initWithRootViewController:healthController];
    
    HHTabBarItem *healthTabbarItem=[[HHTabBarItem alloc]  initWithTitle:@"健康安全" image:[UIImage imageNamed:@"tabbar_health"] selectedImage:[UIImage   imageNamed:@"tabbar_health_HL"]];
    healthNavController.tabBarItem=healthTabbarItem;
    */
    
    
    SubjectViewController *subjectViewController=[[SubjectViewController alloc]  init];
    UINavigationController *subjectNavController=[[UINavigationController alloc]  initWithRootViewController:subjectViewController];
    
    HHTabBarItem *subjectTabbarItem=[[HHTabBarItem alloc]  initWithTitle:@"专题" image:[UIImage imageNamed:@"tabbar_health"] selectedImage:[UIImage   imageNamed:@"tabbar_health_HL"]];
    subjectNavController.tabBarItem=subjectTabbarItem;
    
    
    
    
    ActivityViewController *activityController=[[ActivityViewController alloc]  init];
    UINavigationController *activityNavController=[[UINavigationController alloc]  initWithRootViewController:activityController];
    HHTabBarItem *activityTabbarItem=[[HHTabBarItem alloc]  initWithTitle:@"活动" image:[UIImage imageNamed:@"tabbar_health"] selectedImage:[UIImage   imageNamed:@"tabbar_health_HL"]];
    activityNavController.tabBarItem=activityTabbarItem;
    
    UserCenterViewController *userCenterController=[[UserCenterViewController alloc]  initWithStyle:UITableViewStyleGrouped];
    UINavigationController *userNavController=[[UINavigationController alloc]  initWithRootViewController:userCenterController];
    HHTabBarItem *userTabbarItem=[[HHTabBarItem alloc]  initWithTitle:@"我" image:[UIImage imageNamed:@"tabbar_me"] selectedImage:[UIImage   imageNamed:@"tabbar_me_HL"]];
    userNavController.tabBarItem=userTabbarItem;
    
    
    NSMutableArray *tabBarControllers=[[NSMutableArray alloc]  initWithObjects:subjectNavController,activityNavController,userNavController, nil];
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
