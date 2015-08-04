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
#import "QBImagePickerController.h"
#import "UserInfoViewController.h"
#import "HHItemModel.h"
@interface UserCenterViewController ()<QBImagePickerControllerDelegate>
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
        _logoutFootView=[[UIView alloc]  initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 80)];
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
    self.title=@"我";
    self.dataSourceArray=[HHItemModel userCenterItems];
    self.tableView.backgroundColor=[UIColor red:246 green:242 blue:241 alpha:1];
//    self.tableView.tableHeaderView=self.headerView;
   // self.tableView.separatorColor=MCMallThemeColor;
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
    [self imagePickerButtonPressed];
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
#pragma mark - select iamge
-(void)imagePickerButtonPressed{
    QBImagePickerController *imagePickerController = [QBImagePickerController new];
    imagePickerController.delegate = self;
    imagePickerController.allowsMultipleSelection = NO;
    imagePickerController.showsNumberOfSelectedAssets = NO;
    
    [self presentViewController:imagePickerController animated:YES completion:NULL];
}
#pragma mark - qbimagecontroller delegate
- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didSelectAsset:(ALAsset *)asset{
    [HHProgressHUD showLoadingState];
    WEAKSELF
    CGImageRef ciimage=[[asset defaultRepresentation] fullResolutionImage];
    NSString *loaclPath=[NSFileManager saveImage:[[UIImage alloc]  initWithCGImage:ciimage] presentation:0.5];
    HHNetWorkOperation *operation=[[HHNetWorkEngine sharedHHNetWorkEngine] uploadUserImageWithUserID:[UserModel userID] imagePath:loaclPath  onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCode100) {
            if ([responseResult.responseData isKindOfClass:[NSString class]]) {
                [weakSelf.logoImgView sd_setImageWithURL:[NSURL URLWithString:responseResult.responseData] placeholderImage:MCMallDefaultImg];
            }
            [HHProgressHUD dismiss];
        }else{
            [HHProgressHUD showErrorMssage:@"上传失败"];
        }
    }];
    [self addOperationUniqueIdentifer:operation.uniqueIdentifier];
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark -UITableView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSourceArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger row=0;
    if ([UserModel isLogin]) {
        NSArray *arry= [self.dataSourceArray objectAtIndex:section];
        row=arry.count;
    }else{
        row=0;
    }
    return row;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer=@"cellIdentifer";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
    if (nil==cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.detailTextLabel.textColor=MCMallThemeColor;
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    UserModel *userModel=[UserModel userModel ];
    HHItemModel *itemModel=[[self.dataSourceArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.imageView.image=itemModel.itemImage;
    cell.textLabel.text=itemModel.itemName;
    cell.backgroundColor=[UIColor whiteColor];
    switch (itemModel.itemType) {
        case  HHUserCenterItemTypeUserInfo:{
            cell.detailTextLabel.text=userModel.userName;
        }break;
        case HHUserCenterItemTypePoint:{
            cell.detailTextLabel.text=[userModel.userAmount.stringValue stringByAppendingString:@"(去充值)"];
        }break;
        case HHUserCenterItemTypeConsume:{
            cell.detailTextLabel.text=userModel.shopName;
        }break;
        case HHUserCenterItemTypeShop:{
            cell.detailTextLabel.text=userModel.shopName;
        }break;
        case HHUserCenterItemTypeTel:{
            cell.detailTextLabel.text=userModel.userTel;
        }break;
        case HHUserCenterItemTypeBabyInfo:{
            cell.detailTextLabel.text=@"";
        }break;
        case HHUserCenterItemTypeMyActivity:{
            cell.detailTextLabel.text=@"";
        }break;
        case HHUserCenterItemTypeSetting:{
            cell.detailTextLabel.text=@"";
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
    CGFloat height=0;
    HHItemModel *itemModel=[[[self dataSourceArray]  objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if (itemModel.itemType==HHUserCenterItemTypeUserInfo) {
        height=60;
    }else{
        height=44.0;
    }
    return height;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HHItemModel *itemModel=[[[self dataSourceArray]  objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    switch (itemModel.itemType) {
        case HHUserCenterItemTypeUserInfo:
        {
            UserInfoViewController *userInfoViewController=[[UserInfoViewController alloc]  init];
            userInfoViewController.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:userInfoViewController animated:YES];
        }break;
            
            
        default:
            break;
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
