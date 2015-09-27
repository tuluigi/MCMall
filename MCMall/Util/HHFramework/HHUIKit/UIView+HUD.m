//
//  UIView+HUD.m
//  MCMall
//
//  Created by Luigi on 15/9/4.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "UIView+HUD.h"
#import "MBProgressHUD.h"
@implementation UIView (HUD)
-(MBProgressHUD *)hudView{
    MBProgressHUD *hudView=[MBProgressHUD HUDForView:self];
    if (nil==hudView) {
        hudView=[[MBProgressHUD alloc]  initWithView:self];
        hudView.removeFromSuperViewOnHide=YES;
        [self addSubview:hudView];
        [hudView show:YES];
    }else{
        hudView.alpha=1;
        hudView.hidden=NO;
    }
    return hudView;
}
-(void)showLoadingState{
    
    [self showLoadingMessage:@"请稍后..."];
}
-(void)showLoadingMessage:(NSString *)msg{
    NSString *hubMsg=msg;
    if (nil==hubMsg) {
        hubMsg=@"请稍后";
    }
    MBProgressHUD *hubView = [self hudView];
    hubView.labelText =hubMsg;
}
-(void)showSuccessMessage:(NSString *)msg{
     MBProgressHUD *HUD  = [self hudView];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = msg;
    [HUD hide:YES afterDelay:1.2];
}
-(void)showErrorMssage:(NSString *)msg{
    MBProgressHUD *HUD  =[self hudView];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = msg;
    [HUD hide:YES afterDelay:1.2];
}
-(void)showProgressWithMessage:(NSString *)msg{
    
}
-(void)showProgress:(CGFloat)progress{
    MBProgressHUD *hudView=[self hudView];
        hudView.progress=progress;
    hudView.square=YES;
}

-(void)dismissHUD{
    [MBProgressHUD hideAllHUDsForView:self animated:NO];
}

-(void)makeToast:(NSString *)aMessage{
    MBProgressHUD *hud = [self hudView];
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = aMessage;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.2];
}
-(void)hideToast{

}
@end
