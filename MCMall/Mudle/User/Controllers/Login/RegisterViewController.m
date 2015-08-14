//
//  RegisterViewController.m
//  MCMall
//
//  Created by Luigi on 15/6/1.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "RegisterViewController.h"
#import "HHNetWorkEngine+UserCenter.h"
#import "UserStateSelectController.h"
#define TotalTimeDuration 10
@interface RegisterViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UIView *headerView,*footView;
@property(nonatomic,strong)NSString *userName,*userPwd,*repeatPwd,*telPhone,*verfiCodeStr,*severVerifyCodeStr;
@property(nonatomic,assign)BOOL enableUserAgrement,enableCookie;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)UIButton *actionButton;
@property(nonatomic,assign)NSInteger totalTime;
@end

@implementation RegisterViewController
-(NSTimer *)timer{
    if (nil==_timer) {
        _timer=[NSTimer timerWithTimeInterval:1 target:self selector:@selector(handlerTimer:) userInfo:nil repeats:YES];
        [_timer setFireDate:[NSDate distantFuture]];
        [[NSRunLoop currentRunLoop]  addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}
-(void)handlerTimer:(NSTimer *)aTimer{
    if (self.totalTime==0) {
        self.actionButton.enabled=YES;
        self.totalTime=TotalTimeDuration;
        [self.timer setFireDate:[NSDate distantFuture]];
        [_actionButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    }else{
        self.totalTime--;
        [_actionButton setTitle:[NSString stringWithFormat:@"%ld",self.totalTime] forState:UIControlStateNormal];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self onInitData];
}
-(void)onInitData{
    self.title=@"注册";
    self.totalTime=TotalTimeDuration;
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
        _footView.userInteractionEnabled=YES;
        UIButton *checkLeftButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_footView addSubview:checkLeftButton];
        checkLeftButton.tag=1000;
        checkLeftButton.userInteractionEnabled=YES;
        [checkLeftButton setBackgroundImage:[UIImage imageNamed:@"checkbox_normal"] forState:UIControlStateNormal];
        [checkLeftButton setBackgroundImage:[UIImage imageNamed:@"checkbox_Select"] forState:UIControlStateSelected];
        [checkLeftButton addTarget:self action:@selector(didActionButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
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
        checkRightButton.userInteractionEnabled=YES;
        checkRightButton.tag=1001;
        [_footView addSubview:checkRightButton];
         [checkRightButton addTarget:self action:@selector(didActionButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
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
        case 1000:{//用户协议
            sender.selected=!sender.selected;
        }break;
        case 1001:{//下次直接登录
          sender.selected=!sender.selected;
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
        [HHProgressHUD showErrorMssage:@"请输入正确手机号码"];
    }else if(![self.userPwd isEqualToString:self.repeatPwd]){
        [HHProgressHUD showErrorMssage:@"两次输入的密码不一样"];
    }
    //    else if (![self.verfiCodeStr isEqualToString:self.severVerifyCodeStr]){
    //        [HHProgressHUD showErrorMssage:@"请输入正确的验证码"];
    //    }
    else{
        [HHProgressHUD showLoadingState];
        WEAKSELF
        [[HHNetWorkEngine sharedHHNetWorkEngine]   userRegisterWithUserName:self.userName pwd:self.userPwd phoneNum:self.telPhone verfiyCode:self.verfiCodeStr  onCompletionHandler:^(HHResponseResult *responseResult) {
            if (responseResult.responseCode==HHResponseResultCode100) {
                [HHProgressHUD dismiss];
                [[NSNotificationCenter defaultCenter]  postNotificationName:UserLoginSucceedNotification object:nil];
                UserModel *userModel=[HHUserManager userModel];
                if (userModel.motherState==MotherStateUnSelected) {
                    UserStateSelectController *stateSelectController=[[UserStateSelectController alloc]  init];
                    stateSelectController.hidesBottomBarWhenPushed=YES;
                    [self.navigationController pushViewController:stateSelectController animated:YES];
                }else{
                [weakSelf.navigationController dismissViewControllerAnimated:YES completion:^{
                    if (weakSelf.userLoginCompletionBlock) {
                        weakSelf.userLoginCompletionBlock(YES,[HHUserManager userID]);
                    }
                }];
                }
            }else{
                if (weakSelf.userLoginCompletionBlock) {
                    weakSelf.userLoginCompletionBlock(NO,nil);
                }
                [HHProgressHUD showErrorMssage:responseResult.responseMessage];
            }
        }];
    }
}
#pragma mark 获取验证码
-(void)didVerifyCodeButtonPressed:(UIButton *)sender{
    WEAKSELF
    sender.enabled=NO;
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine] getVerifyPhoneCodeWithPhoneNumber:self.telPhone onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCode100) {
            [self.timer setFireDate:[NSDate date]];
        }else{
            sender.enabled=YES;
            weakSelf.totalTime=TotalTimeDuration;
            [weakSelf.timer setFireDate:[NSDate distantFuture]];
            [HHProgressHUD showErrorMssage:responseResult.responseMessage];
        }
    }];
    [self addOperationUniqueIdentifer:op.uniqueIdentifier];
    
}

#pragma mark -UITableView Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15.0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
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
        cell.contentView.userInteractionEnabled=YES;
        [cell.contentView addSubview:textField];
        
        UILabel *leftLable=[[UILabel alloc]  initWithFrame:CGRectMake(0, 0, 80.0, CGRectGetHeight(textField.bounds))];
        leftLable.textAlignment=NSTextAlignmentLeft;
        leftLable.font=[UIFont systemFontOfSize:16.0];
        leftLable.textColor=[UIColor blackColor];
        textField.leftView=leftLable;
        textField.leftViewMode=UITextFieldViewModeAlways;
        
        _actionButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        _actionButton.frame=CGRectMake(0, 5.0, 80, 34.0);
        _actionButton.layer.cornerRadius=5.0;
        _actionButton.layer.masksToBounds=YES;
        _actionButton.enabled=NO;
        [_actionButton setTitle:@"发送验证码" forState:UIControlStateNormal];
        [_actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_actionButton setBackgroundImage:nil forState:UIControlStateSelected|UIControlStateNormal];
        [_actionButton setBackgroundColor:[UIColor red:255.0 green:92.0 blue:134.0 alpha:1]];
        _actionButton.titleLabel.font=[UIFont boldSystemFontOfSize:15.0];
        [_actionButton addTarget:self action:@selector(didVerifyCodeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        textField.userInteractionEnabled=YES;
        _actionButton.userInteractionEnabled=YES;
        textField.rightView=_actionButton;
        [textField addTarget:self action:@selector(didTextFiledValueChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    UITextField *textField=(UITextField *)[cell viewWithTag:1000];
    
    UILabel *leftLable=(UILabel *)textField.leftView;
    textField.rightViewMode=UITextFieldViewModeNever;
    textField.secureTextEntry=NO;
    textField.keyboardType=UIKeyboardTypeDefault;
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
            textField.keyboardType=UIKeyboardTypeNamePhonePad;
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
            if ([self.telPhone isPhoneNumber]) {
                self.actionButton.enabled=YES;
            }else{
                self.actionButton.enabled=NO;
            }
        }break;
        case 4:{
            self.verfiCodeStr=textFiled.text;
            
        }break;
        default:
            break;
    }
}

@end
