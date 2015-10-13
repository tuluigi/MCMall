//
//  AppDelegate.m
//  MCMall
//
//  Created by Luigi on 15/5/20.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "AppDelegate.h"
#import "RootTabBarController.h"
#import "BPush.h"
#import "UserStateSelectController.h"
#import "HHShaeTool.h"
#import "GoodsDetailViewController.h"
#import "VoteActivityViewController.h"
static const NSInteger kAlertCheckVersionUpdate = 100;
@interface AppDelegate ()<UIAlertViewDelegate>
@property(nonatomic,copy)NSString *downLoadStr;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UserModel *userModel=[HHUserManager userModel];
    if (userModel.motherState==MotherStateUnSelected) {
        [HHUserManager logout];
    }
    // Override point for customization after application launch.
    self.window=[[UIWindow alloc]  initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor whiteColor];
    RootTabBarController *rootTabbarController=[[RootTabBarController alloc]  init];
    self.window.rootViewController=rootTabbarController;
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationBg"] forBarMetrics:UIBarMetricsDefault];
    NSDictionary *attrDic=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:20.0],NSFontAttributeName, nil];
    [[UINavigationBar appearance] setTitleTextAttributes:attrDic];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [self.window makeKeyAndVisible];
    NSTimer * _timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handTimerTask:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]  addTimer:_timer forMode:NSRunLoopCommonModes];
    
    // 在 App 启动时注册百度云推送服务，需要提供 Apikey DF0eNG6TNUqEvrVyQhIRU0Ea IcDl7Kx2H3DYzb2TQOqMkohZ
    [BPush registerChannel:launchOptions apiKey:[HHGlobalVarTool shareBDPushKey] pushMode:BPushModeProduction withFirstAction:nil withSecondAction:nil withCategory:nil isDebug:NO];
    // App 是用户点击推送消息启动
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
        NSLog(@"从消息启动:%@",userInfo);
        [BPush handleNotification:userInfo];
        [self handleAPNSPushNotification:userInfo];
    }
    
    // [SVProgressHUD setBackgroundColor:[UIColor colorWithWhite:0.6 alpha:0.4]];
    //角标清0
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
   
    [HHShaeTool setSharePlatform];
    [self registerAPNSNotification];
    
    [HHAppInfo checkVersionUpdateOnCompletionBlock:^(BOOL isNeddUpdate, NSString *downUrl) {
        if (isNeddUpdate&&downUrl) {
            UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"版本更新" message:@"发现新版本,是否更新？" delegate:self cancelButtonTitle:@"稍后再说" otherButtonTitles:@"立即更新", nil];
            alert.tag=kAlertCheckVersionUpdate;
            [alert show];
        }
    }];
    return YES;
}

-(void)registerAPNSNotification{
    // iOS8 下需要使用新的 API
    NSString *tokenStr= [HHGlobalVarTool deviceToken];
    if ([NSString IsNullOrEmptyString:tokenStr]) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            UIUserNotificationType myTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
            
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        }else {
            UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
        }
    }
}
-(void)handTimerTask:(NSTimer *)timer{
    [[NSNotificationCenter defaultCenter ] postNotificationName:MCMallTimerTaskNotification object:nil userInfo:nil];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [HHShaeTool applicationDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return YES;
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    BOOL canOpen=[HHShaeTool application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    return canOpen;
}
#pragma mark -PushNotification
#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}
#endif
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSString* tokenStr = [NSString stringWithFormat:@"%@",deviceToken];
    [HHGlobalVarTool setDeviceToken:tokenStr];
    [BPush registerDeviceToken:deviceToken];
    [BPush bindChannelWithCompleteHandler:^(id result, NSError *error) {
        NSLog(@"RESLUT%@",result);
    }];
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    [BPush handleNotification:userInfo];
    [self handleAPNSPushNotification:userInfo];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [BPush handleNotification:userInfo];
    [self handleAPNSPushNotification:userInfo];
}
-(void)handleAPNSPushNotification:(NSDictionary *)userInfo{
    NSInteger noteType=[[userInfo objectForKey:@"type"] integerValue];
    RootTabBarController *rootTabbarController= (RootTabBarController *)[[[UIApplication sharedApplication] keyWindow] rootViewController];
    UINavigationController *navController=(UINavigationController *)[rootTabbarController.viewControllers objectAtIndex:rootTabbarController.selectedIndex];
    
    NSString *valueStr=[userInfo objectForKey:@"id"];
    switch (noteType) {
        case MCMallNotificationTypeGoods:{
            GoodsDetailViewController *goodDetailController=[[GoodsDetailViewController alloc]  init];
            goodDetailController.hidesBottomBarWhenPushed=YES;
            goodDetailController.goodsID=valueStr;
            [navController pushViewController:goodDetailController animated:YES];
        }break;
        case MCMallNotificationTypeActivityCommon:
        case MCMallNotificationTypeActivityApply:
        case MCMallNotificationTypeActivityPicture:
        case MCMallNotificationTypeActivityVote:{
            VoteActivityViewController *voteController=[[VoteActivityViewController alloc]  initWithActivityID:valueStr type:noteType];
            voteController.hidesBottomBarWhenPushed=YES;
            [navController pushViewController:voteController animated:YES];
        }break;
        default:
            break;
    }
}
-(UINavigationController *)currentSelectedNavigationController{
    RootTabBarController *rootTabbarController= (RootTabBarController *)[[[UIApplication sharedApplication] keyWindow] rootViewController];
    UINavigationController *navController=(UINavigationController *)[rootTabbarController.viewControllers objectAtIndex:rootTabbarController.selectedIndex];
    return navController;
}

#pragma mark -AlertViewController
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==kAlertCheckVersionUpdate) {
        if (alertView.cancelButtonIndex==buttonIndex) {
            
        }else{
            if (self.downLoadStr&&self.downLoadStr.length) {
                BOOL canOpen= [[UIApplication sharedApplication]  canOpenURL:[NSURL URLWithString:self.downLoadStr]];
                if (canOpen) {
                    [[UIApplication sharedApplication]  openURL:[NSURL URLWithString:self.downLoadStr]];
                }
            }
        }
    }
}
@end
