//
//  UIViewController+MCMall.m
//  MCMall
//
//  Created by Luigi on 15/5/27.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "UIViewController+MCMall.h"
#import "LoginViewController.h"

@implementation UIViewController (MCMall)

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];;
}
@end
