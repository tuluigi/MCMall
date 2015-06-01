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
#import "LoginViewController.h"
@interface UserCenterViewController ()
@property(nonatomic,strong)UIView *headerView,*footView;

@end

@implementation UserCenterViewController
-(UIView *)headerView{
    if (nil==_headerView) {
        _headerView=[[UIView alloc]  initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)];
        UIImageView *logoImgView=[[UIImageView alloc]  initWithImage:[UIImage imageNamed:@"loading_Default"]];
        [_headerView addSubview:logoImgView];
        [logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_headerView);
            make.size.mas_equalTo(CGSizeMake(100.0, 100.0));
        }];
    }
    return _headerView;
}
-(UIView *)footView{
    if (nil==_footView) {
       _footView=[[UIView alloc]  initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)];
        
        UIButton *loginButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_footView addSubview:loginButton];
        loginButton.backgroundColor=[UIColor red:255.0 green:92.0 blue:134.0 alpha:1];
        loginButton.layer.cornerRadius=5.0;
        loginButton.titleLabel.font=[UIFont boldSystemFontOfSize:20];
        loginButton.layer.masksToBounds=YES;
        [loginButton setTitle:@"登 录" forState:UIControlStateNormal];
        [loginButton addTarget:self action:@selector(didLoginButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(_footView).with.offset(20.0);
            make.right.mas_equalTo(_footView.right).with.offset(-20.0);
            make.height.equalTo(@40.0);
        }];
        
        /*
        UIButton *registerButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_footView addSubview:registerButton];
        registerButton.backgroundColor=[UIColor red:255.0 green:92.0 blue:134.0 alpha:1];
        registerButton.layer.cornerRadius=5.0;
        registerButton.titleLabel.font=[UIFont boldSystemFontOfSize:20];
        registerButton.layer.masksToBounds=YES;
        [registerButton setTitle:@"注 册" forState:UIControlStateNormal];
        [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(loginButton.bottom).with.offset(40);
            make.left.right.mas_equalTo(loginButton);
            //make.right.mas_equalTo(loginButton);
            make.height.equalTo(loginButton);
           // make.right.height.mas_equalTo(loginButton.right);
           // make.top.mas_equalTo(loginButton.bottom).with.offset(20.0);;
            
        }];
         */
    }
    return _footView;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self verfiyUserLogin];
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView=self.headerView;
    self.tableView.tableFooterView=self.footView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)didLoginButtonPressed{
    LoginViewController *loginController=[[LoginViewController alloc]  initWithStyle:UITableViewStylePlain];
    UINavigationController *navController=[[UINavigationController alloc]  initWithRootViewController:loginController];
    [self.navigationController presentViewController:navController animated:YES completion:^{
        
    }];
}
#pragma mark -UITableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer=@"cellIdentifer";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
    if (nil==cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifer];
    }
    switch (indexPath.row) {
        case 0:{
            cell.textLabel.text=@"欢迎您!";
            cell.detailTextLabel.text=@"xxxx";
        }break;
        case 1:{
            cell.textLabel.text=@"账户余额:";
            cell.detailTextLabel.text=@"xxxx";
        }break;
        case 2:{
            cell.textLabel.text=@"所属门店:";
            cell.detailTextLabel.text=@"xxxx";
        }break;
        case 3:{
            cell.textLabel.text=@"手机号:";
            cell.detailTextLabel.text=@"xxxx";
        }break;
            
        default:
            break;
    }
    return cell;
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
