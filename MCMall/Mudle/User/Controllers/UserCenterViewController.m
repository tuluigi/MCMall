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
#import "HHImagePickerHelper.h"
@interface UserCenterViewController ()
@property(nonatomic,strong)UIView *headerView,*loginFootView,*logoutFootView;
@property(nonatomic,strong)UIImageView *logoImgView;
@property(nonatomic,strong)HHImagePickerHelper *imagePickerHelper;
@end

@implementation UserCenterViewController
-(HHImagePickerHelper *)imagePickerHelper{
    if (nil==_imagePickerHelper) {
        _imagePickerHelper=[[HHImagePickerHelper alloc]  init];
    }
    return _imagePickerHelper;
}
-(UIView *)headerView{
    if (nil==_headerView) {
        _headerView=[[UIView alloc]  initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 160.0)];
        _logoImgView=[[UIImageView alloc]  initWithImage:[UIImage imageNamed:@"loading_Default"]];
        _logoImgView.userInteractionEnabled=YES;
        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]  initWithTarget:self action:@selector(didHeaderImageTouchedWithGesture:)];
        [_logoImgView addGestureRecognizer:tapGesture];
        [_headerView addSubview:_logoImgView];
        [_logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_headerView);
            make.size.mas_equalTo(CGSizeMake(100.0, 100.0));
        }];
    }
    return _headerView;
}
-(UIView *)loginFootView{
    if (nil==_loginFootView) {
       _loginFootView=[[UIView alloc]  initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)];
        
        UIButton *loginButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_loginFootView addSubview:loginButton];
        loginButton.backgroundColor=[UIColor red:255.0 green:92.0 blue:134.0 alpha:1];
        loginButton.layer.cornerRadius=5.0;
        loginButton.titleLabel.font=[UIFont boldSystemFontOfSize:20];
        loginButton.layer.masksToBounds=YES;
        [loginButton setTitle:@"登 录" forState:UIControlStateNormal];
        [loginButton addTarget:self action:@selector(didLoginButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(_loginFootView).with.offset(20.0);
            make.right.mas_equalTo(_loginFootView.right).with.offset(-20.0);
            make.height.equalTo(@40.0);
        }];
    
        
        UIButton *registerButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_loginFootView addSubview:registerButton];
        registerButton.backgroundColor=[UIColor red:255.0 green:92.0 blue:134.0 alpha:1];
        registerButton.layer.cornerRadius=5.0;
        registerButton.titleLabel.font=[UIFont boldSystemFontOfSize:20];
        registerButton.layer.masksToBounds=YES;
        [registerButton setTitle:@"注 册" forState:UIControlStateNormal];
        [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(loginButton.mas_bottom).with.offset(10);
            make.left.right.mas_equalTo(loginButton);
            make.height.equalTo(loginButton);
        }];
    }
    return _loginFootView;
}
-(UIView *)logoutFootView{
    if (nil==_logoutFootView) {
        _logoutFootView=[[UIView alloc]  initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)];
        UIButton *loginButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_logoutFootView addSubview:loginButton];
       
        loginButton.backgroundColor=[UIColor red:255.0 green:92.0 blue:134.0 alpha:1];
        loginButton.layer.cornerRadius=5.0;
        loginButton.titleLabel.font=[UIFont boldSystemFontOfSize:20];
        loginButton.layer.masksToBounds=YES;
        [loginButton setTitle:@"退出登录" forState:UIControlStateNormal];
        [loginButton addTarget:self action:@selector(didLogoutButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(_logoutFootView).with.offset(20.0);
            make.right.mas_equalTo(_logoutFootView.right).with.offset(-20.0);
            make.height.equalTo(@40.0);
        }];

    }
    return _logoutFootView;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self verfiyUserLogin];
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView=self.headerView;
    self.tableView.separatorColor=MCMallThemeColor;
    [self reloadUI];
    WEAKSELF
    [[NSNotificationCenter defaultCenter]  addObserverForName:UserLoginSucceedNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        [weakSelf reloadUI];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)reloadUI{
    if ([UserModel isLogin]) {
        self.tableView.tableFooterView=self.logoutFootView;
    }else{
         self.tableView.tableFooterView=self.loginFootView;
    }
    UserModel *userModel=[UserModel userModel];
    [_logoImgView sd_setImageWithURL:[NSURL URLWithString:userModel.userHeadUrl] placeholderImage:MCMallDefaultImg];
    [self.tableView reloadData];
}
-(void)didHeaderImageTouchedWithGesture:(UITapGestureRecognizer *)gesture{
    [self.imagePickerHelper showImagePickerWithType:HHImagePickTypeAll onCompletionHandler:^(UIImage *image, NSDictionary *editingInfo, NSString *imgPath) {
        
    }];
}
-(void)didLogoutButtonPressed{
    [UserModel logout];
    [self reloadUI];
    [self verfiyUserLogin];
}
-(void)didLoginButtonPressed{
    LoginViewController *loginController=[[LoginViewController alloc]  initWithStyle:UITableViewStylePlain];
    UINavigationController *navController=[[UINavigationController alloc]  initWithRootViewController:loginController];
    [self.navigationController presentViewController:navController animated:YES completion:^{
        
    }];
}
#pragma mark -UITableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return 5;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer=@"cellIdentifer";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
    if (nil==cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifer];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.detailTextLabel.textColor=MCMallThemeColor;
    }
    UserModel *userModel=[UserModel userModel ];
    switch (indexPath.row) {
        case 0:{
            cell.textLabel.text=@"欢迎您:";
            cell.detailTextLabel.text=userModel.userName;
        }break;
        case 1:{
            cell.textLabel.text=@"账户余额:";
            cell.detailTextLabel.text=[userModel.userAmount.stringValue stringByAppendingString:@"(去充值)"];
        }break;
        case 2:{
            cell.textLabel.text=@"所属门店:";
            cell.detailTextLabel.text=userModel.merchantName;
        }break;
        case 3:{
            cell.textLabel.text=@"手机号:";
            cell.detailTextLabel.text=userModel.userTel;
        }break;
            
        default:{
            cell.textLabel.text=@"";
            cell.detailTextLabel.text=@"";
        }
            break;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==5) {
        return CGFLOAT_MIN;
    }else{
        return 44.0;
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
