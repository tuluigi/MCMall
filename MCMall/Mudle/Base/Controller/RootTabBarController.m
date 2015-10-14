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
#import "UserCenterViewController.h"
#import "SubjectViewController.h"
#import "GoodsListViewController.h"
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


@interface RootTabBarController ()<UITabBarControllerDelegate>

@end

@implementation RootTabBarController
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
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
    
     MCMallViewController *mcMallController=[[MCMallViewController alloc]  initWithStyle:UITableViewStyleGrouped];
     UINavigationController *mcNavController=[[UINavigationController alloc] initWithRootViewController:mcMallController];
    HHTabBarItem *mallTabbarItem=[[HHTabBarItem alloc]  initWithTitle:@" " image:[UIImage imageNamed:@"tabbar_home_HL"] selectedImage:[UIImage   imageNamed:@"tabbar_home_HL"]];
    mcNavController.tabBarItem=mallTabbarItem;

    
    SubjectViewController *subjectViewController=[[SubjectViewController alloc]  init];
    UINavigationController *subjectNavController=[[UINavigationController alloc]  initWithRootViewController:subjectViewController];
    
    HHTabBarItem *subjectTabbarItem=[[HHTabBarItem alloc]  initWithTitle:@"妈妈帮" image:[UIImage imageNamed:@"tabbar_assistnt"] selectedImage:[UIImage   imageNamed:@"tabbar_assistnt_HL"]];
    subjectNavController.tabBarItem=subjectTabbarItem;
    
    
    
    
    ActivityViewController *activityController=[[ActivityViewController alloc]  init];
    UINavigationController *activityNavController=[[UINavigationController alloc]  initWithRootViewController:activityController];
    HHTabBarItem *activityTabbarItem=[[HHTabBarItem alloc]  initWithTitle:@"亲子园" image:[UIImage imageNamed:@"tabbar_activity"] selectedImage:[UIImage   imageNamed:@"tabbar_activity_HL"]];
    activityNavController.tabBarItem=activityTabbarItem;
    
    UserCenterViewController *userCenterController=[[UserCenterViewController alloc]  initWithStyle:UITableViewStyleGrouped];
    UINavigationController *userNavController=[[UINavigationController alloc]  initWithRootViewController:userCenterController];
    HHTabBarItem *userTabbarItem=[[HHTabBarItem alloc]  initWithTitle:@"我" image:[UIImage imageNamed:@"tabbar_me"] selectedImage:[UIImage   imageNamed:@"tabbar_me_HL"]];
    userNavController.tabBarItem=userTabbarItem;
    
    GoodsListViewController *goodListController=[[GoodsListViewController alloc]  init];
    UINavigationController *vipNavController=[[UINavigationController alloc]  initWithRootViewController:goodListController];
    HHTabBarItem *goodsTabbarItem=[[HHTabBarItem alloc]  initWithTitle:@"专享汇" image:[UIImage imageNamed:@"tabbar_vip"] selectedImage:[UIImage   imageNamed:@"tabbar_vip_HL"]];
    vipNavController.tabBarItem=goodsTabbarItem;
    
    NSMutableArray *tabBarControllers=[[NSMutableArray alloc]  initWithObjects:activityNavController,subjectNavController,mcNavController,vipNavController,userNavController, nil];
    self.viewControllers=tabBarControllers;
    self.selectedViewController=mcNavController;
    self.delegate=self;
    
    WEAKSELF
    [[NSNotificationCenter defaultCenter]  addObserverForName:UserLogoutSucceedNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *  note) {
        weakSelf.selectedViewController=mcNavController;
    }];
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if ([HHUserManager isLogin]) {
        return YES;
    }else{
        UIViewController *selectController=[((UINavigationController *)viewController) topViewController];
        if ([selectController isKindOfClass:[UserCenterViewController class]]||[selectController isKindOfClass:[ActivityViewController class]]) {
            [HHUserManager shouldUserLoginOnCompletionBlock:^(BOOL isSucceed, NSString *userID) {
                if (isSucceed) {
                    tabBarController.selectedViewController=viewController;
                }
            }];
            return NO;
        }else{
            return YES;
        }
    }
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
