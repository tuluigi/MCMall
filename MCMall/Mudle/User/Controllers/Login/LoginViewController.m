//
//  LoginViewController.m
//  MCMall
//
//  Created by Luigi on 15/5/26.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "LoginViewController.h"
#import "HHNetWorkEngine+UserCenter.h"
#import "RegisterViewController.h"
@interface LoginViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UIView *headerView,*footView;
@property(nonatomic,strong)NSString *userName,*userPwd;
@end

@implementation LoginViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self onInitData];
}
-(void)onInitData{
    self.title=@"知婴知孕";
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]  initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(leftNavigationItemClicked)];
    self.tableView.backgroundColor=[UIColor red:240.0 green:241.0 blue:246.0 alpha:1];
    self.tableView.tableHeaderView=self.headerView;
    self.tableView.tableFooterView=self.footView;
    [self.tableView reloadData];
}
-(UIView *)headerView{
    if (nil==_headerView) {
        _headerView=[[UIView alloc]  initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 160)];
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
        
        NSInteger tag=2000;
        for (NSInteger i=0; i<3; i++) {
            UIButton *actionButton=[UIButton buttonWithType:UIButtonTypeCustom];
            [_footView addSubview:actionButton];
            actionButton.backgroundColor=[UIColor red:255.0 green:92.0 blue:134.0 alpha:1];
            actionButton.tag=tag+i;
            actionButton.layer.cornerRadius=5.0;
            actionButton.titleLabel.font=[UIFont boldSystemFontOfSize:20];
            actionButton.layer.masksToBounds=YES;
            [actionButton addTarget:self action:@selector(didActionButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            if (i==0) {
                [actionButton setTitle:@"登 录" forState:UIControlStateNormal];
                
                [actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.top.mas_equalTo(_footView).with.offset(20.0);
                    make.right.mas_equalTo(_footView.right).with.offset(-20.0);
                    make.height.equalTo(@40.0);
                }];
            }else if(i==1){
                [actionButton setTitle:@"忘记密码" forState:UIControlStateNormal];
                UIButton *preButton=(UIButton *)[_footView viewWithTag:(actionButton.tag-1)];
                [actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(preButton.mas_bottom).with.offset(10.0);
                    make.left.right.mas_equalTo(preButton);
                    make.height.equalTo(preButton);
                }];
            }else if(i==2){
                [actionButton setTitle:@"新用户注册" forState:UIControlStateNormal];
                UIButton *preButton=(UIButton *)[_footView viewWithTag:(actionButton.tag-1)];
                [actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(preButton.mas_bottom).with.offset(10.0);
                    make.left.right.mas_equalTo(preButton);
                    make.height.equalTo(preButton);
                }];
            }
            
        }
    }
    return _footView;
}
-(void)didActionButtonPressed:(UIButton *)sender{
    switch (sender.tag) {
        case 2000:{//登录
            [self userLogin];
        }break;
        case 2001:{//忘记密码
            
        }break;
        case 2002:{//新用户注册
            RegisterViewController *registerController=[[RegisterViewController alloc]  initWithStyle:UITableViewStylePlain];
            [self.navigationController pushViewController:registerController animated:YES];
        }break;
            
        default:
            break;
    }
}
#pragma mark - 登录
-(void)userLogin{
    for (UITableViewCell *cell in [self.tableView visibleCells]) {
        UITextField *textField=(UITextField *)[cell viewWithTag:1000];
        NSIndexPath *indexPath=[self.tableView indexPathForCell:cell];
        if (indexPath.row==0) {
            self.userName=textField.text;
        }else if (indexPath.row==1){
            self.userPwd=textField.text;
        }
    }
    if ([NSString IsNullOrEmptyString:self.userName]) {
        [HHProgressHUD showErrorMssage:@"请输入用户名"];
    }else if([NSString IsNullOrEmptyString:self.userPwd]){
        [HHProgressHUD showErrorMssage:@"请输入密码"];
    }else{
        [[HHNetWorkEngine sharedHHNetWorkEngine] userLoginWithUserName:self.userName pwd:self.userPwd onCompletionHandler:^(HHResponseResult *responseResult) {
            if (responseResult.responseCode ==HHResponseResultCode100) {
                [[NSNotificationCenter defaultCenter]  postNotificationName:UserLoginSucceedNotification object:nil];
                [self.navigationController dismissViewControllerAnimated:YES completion:^{
                    
                }];
            }else{
                [HHProgressHUD showErrorMssage:responseResult.responseMessage];
            }
        }];
    }
}
#pragma mark -button
-(void)leftNavigationItemClicked{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -UITableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer=@"cellIdentifer";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
    if (nil==cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifer];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        UITextField *textField=[[UITextField alloc]  initWithFrame:CGRectMake(100.0, 5.0, 200.0, 35.0)];
        textField.delegate=self;
        textField.textAlignment=NSTextAlignmentLeft;
        textField.tag=1000;
        [cell.contentView addSubview:textField];
    }
    UITextField *textField=(UITextField *)[cell viewWithTag:1000];
    switch (indexPath.row) {
        case 0:{
            cell.textLabel.text=@"用户名:";
            textField.placeholder=@"请输入用户账号";
        }break;
        case 1:{
            cell.textLabel.text=@"密码:";
            textField.placeholder=@"请输入登录密码";
            textField.secureTextEntry=YES;
        }break;
            
        default:
            break;
    }
    return cell;
}
#pragma mark -UITextFieldDelegate
-(BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
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
