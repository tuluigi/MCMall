//
//  LoginViewController.h
//  MCMall
//
//  Created by Luigi on 15/5/26.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "BaseTableViewController.h"

@interface LoginViewController : BaseTableViewController
@property(nonatomic,copy)DidUserLoginCompletionBlock userLoginCompletionBlock;
@end
