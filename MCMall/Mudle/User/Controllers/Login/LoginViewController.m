//
//  LoginViewController.m
//  MCMall
//
//  Created by Luigi on 15/5/26.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property(nonatomic,strong)UIView *headerView,*footView;
@end

@implementation LoginViewController
-(UIView *)headerView{
    if (nil==_headerView) {
        _headerView=[[UIView alloc]  init];
    }
    return _headerView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self onInitData];
}
-(void)onInitData{
    self.title=@"知婴知孕";
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
