//
//  RegisterViewController.m
//  MCMall
//
//  Created by Luigi on 15/6/1.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "RegisterViewController.h"
#import "HHNetWorkEngine+UserCenter.h"
@interface RegisterViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UIView *headerView,*footView;
@property(nonatomic,strong)NSString *userName,*userPwd,*repeatPwd,*telPhone,*verfiCodeStr;
@property(nonatomic,assign)BOOL enableUserAgrement,enableCookie;
@end

@implementation RegisterViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self onInitData];
}
-(void)onInitData{
    self.title=@"注册";
    self.tableView.backgroundColor=[UIColor red:240.0 green:241.0 blue:246.0 alpha:1];
  //  self.tableView.tableHeaderView=self.headerView;
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
        
        UIButton *checkLeftButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_footView addSubview:checkLeftButton];
        [checkLeftButton setBackgroundImage:[UIImage imageNamed:@"checkbox_normal"] forState:UIControlStateNormal];
        [checkLeftButton setBackgroundImage:[UIImage imageNamed:@"checkbox_Select"] forState:UIControlStateSelected];
        [checkLeftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_footView.top).offset(10.0);
            make.left.mas_equalTo(_footView.left).offset(30.0);
            make.size.mas_equalTo(CGSizeMake(20.0, 20.0));
        }];
        UILabel *agreementLable=[[UILabel alloc]  init];
        agreementLable.textAlignment=NSTextAlignmentLeft;
        agreementLable.text=@"《用户协议》";
        agreementLable.textColor=[UIColor lightGrayColor];
        agreementLable.font=[UIFont systemFontOfSize:15.0];
        [_footView addSubview:agreementLable];
        [agreementLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(checkLeftButton.mas_right).offset(2.0);
            make.top.equalTo(checkLeftButton);
            make.size.mas_equalTo(CGSizeMake(100.0, 20.0));
        }];
        
        UIButton *checkRightButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_footView addSubview:checkRightButton];
        [checkRightButton setBackgroundImage:[UIImage imageNamed:@"checkbox_normal"] forState:UIControlStateNormal];
        [checkRightButton setBackgroundImage:[UIImage imageNamed:@"checkbox_Select"] forState:UIControlStateSelected];
        [checkRightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_footView.top).offset(10.0);
            make.left.mas_equalTo(_footView.center.x);
            make.size.mas_equalTo(CGSizeMake(20.0, 20.0));
        }];
        UILabel *rightLable=[[UILabel alloc]  init];
        rightLable.textAlignment=NSTextAlignmentLeft;
        rightLable.text=@"是否下次直接登录";
        rightLable.textColor=[UIColor lightGrayColor];
        rightLable.font=[UIFont systemFontOfSize:15.0];
        [_footView addSubview:rightLable];
        [rightLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(checkRightButton.mas_right).offset(2.0);
            make.top.equalTo(checkRightButton);
            make.size.mas_equalTo(CGSizeMake(120.0, 20.0));
        }];

        
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
                [actionButton setTitle:@"完成注册" forState:UIControlStateNormal];
                
                [actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(checkLeftButton.mas_bottom).offset(20.0);
                    make.left.mas_equalTo(_footView).with.offset(20.0);
                    make.right.mas_equalTo(_footView.right).with.offset(-20.0);
                    make.height.equalTo(@40.0);
                }];
            }else if(i==1){
                [actionButton setTitle:@"我是老用户" forState:UIControlStateNormal];
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
            [self userRegister];
        }break;
        case 2001:{//我是老用户
            [self.navigationController popViewControllerAnimated:YES];
        }break;
        default:
            break;
    }
}
-(void)userRegister{
    if (self.userName.length<6) {
        [HHProgressHUD showErrorMssage:@"登录名长度不能小于6位"];
    }else if (self.userPwd.length<6){
        [HHProgressHUD showErrorMssage:@"密码不能少于6位"];
    }else if (self.repeatPwd.length<6){
        [HHProgressHUD showErrorMssage:@"密码不能少于6位"];
    }else if (![self.telPhone isPhoneNumber]){
        [HHProgressHUD showErrorMssage:@"请输入正确号码"];
    }else if(![self.userPwd isEqualToString:self.repeatPwd]){
        [HHProgressHUD showErrorMssage:@"两次输入的密码不一样"];
    }else{
        [[HHNetWorkEngine sharedHHNetWorkEngine]   userRegisterWithUserName:self.userName pwd:self.userPwd phoneNum:self.telPhone onCompletionHandler:^(HHResponseResult *responseResult) {
            if (responseResult.responseCode==HHResponseResultCode100) {
                [[NSNotificationCenter defaultCenter]  postNotificationName:UserLoginSucceedNotification object:nil];
                [self.navigationController dismissViewControllerAnimated:YES completion:^{
                    
                }];
            }else{
                [HHProgressHUD showErrorMssage:responseResult.responseMessage];
            }
        }];
    }
}
#pragma mark 获取验证码
-(void)didVerifyCodeButtonPressed{

}

#pragma mark -UITableView Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15.0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifer=@"identifer";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
    if (nil==cell) {
        cell=[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        UITextField *textField=[[UITextField alloc]  initWithFrame:CGRectMake(15.0, 0, CGRectGetWidth(tableView.bounds)-30.0, 44.0)];
        textField.delegate=self;
        textField.textAlignment=NSTextAlignmentLeft;
        textField.tag=1000;
        [cell.contentView addSubview:textField];
        
        UILabel *leftLable=[[UILabel alloc]  initWithFrame:CGRectMake(0, 0, 80.0, CGRectGetHeight(textField.bounds))];
        leftLable.textAlignment=NSTextAlignmentLeft;
        leftLable.font=[UIFont systemFontOfSize:16.0];
        leftLable.textColor=[UIColor blackColor];
        textField.leftView=leftLable;
        textField.leftViewMode=UITextFieldViewModeAlways;
        
        UIButton *actionButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        actionButton.frame=CGRectMake(0, 5.0, 80, 34.0);
        actionButton.layer.cornerRadius=5.0;
        actionButton.layer.masksToBounds=YES;
        [actionButton setTitle:@"发送验证码" forState:UIControlStateNormal];
        [actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [actionButton setBackgroundColor:[UIColor red:255.0 green:92.0 blue:134.0 alpha:1]];
        actionButton.titleLabel.font=[UIFont boldSystemFontOfSize:15.0];
        [actionButton addTarget:self action:@selector(didVerifyCodeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        textField.rightView=actionButton;
        [textField addTarget:self action:@selector(didTextFiledValueChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    UITextField *textField=(UITextField *)[cell viewWithTag:1000];
    
    UILabel *leftLable=(UILabel *)textField.leftView;
    textField.rightViewMode=UITextFieldViewModeNever;
    textField.secureTextEntry=NO;
    switch (indexPath.row) {
        case 0:{
            textField.placeholder=@"请输入登录名";
            leftLable.text=@"用户名";
        } break;
        case 1:{
            textField.secureTextEntry=YES;
            textField.placeholder=@"请输入至少6位密码";
            leftLable.text=@"密码";
        }break;
        case 2:{
            textField.secureTextEntry=YES;
            textField.placeholder=@"确认新密码";
            leftLable.text=@"确认密码";
        }break;

        case 3:{
            textField.placeholder=@"请输入您的手机号";
            leftLable.text=@"手机号";
        }break;
        case 4:{
            textField.rightViewMode=UITextFieldViewModeAlways;
            textField.placeholder=@"输入验证码";
            leftLable.text=@"验证码";
        }break;
            
        default:
            break;
    }
    return cell;
}
-(void)didTextFiledValueChanged:(UITextField *)textFiled{
    //get cell
    UITableViewCell *cell = (UITableViewCell *)[[textFiled superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    switch (indexPath.row) {
        case 0:{
            self.userName=textFiled.text;
        }break;
        case 1:{
            self.userPwd=textFiled.text;
        }break;
        case 2:{
            self.repeatPwd=textFiled.text;
        }break;
        case 3:{
            self.telPhone=textFiled.text;
        }break;
        case 4:{
            self.verfiCodeStr=textFiled.text;
        }break;
        default:
            break;
    }
}

@end
