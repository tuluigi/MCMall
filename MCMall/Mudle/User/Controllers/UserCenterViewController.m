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
#import "BabeInfoViewController.h"
#import "HHItemModel.h"
#import "HHKeyValueContainerView.h"
#import "SettingViewController.h"
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
        _loginFootView=[[UIView alloc]  initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 100)];
        
        UIButton *loginButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_loginFootView addSubview:loginButton];
        loginButton.backgroundColor=[UIColor red:255.0 green:92.0 blue:134.0 alpha:1];
        loginButton.layer.cornerRadius=5.0;
        loginButton.titleLabel.font=[UIFont boldSystemFontOfSize:20];
        loginButton.layer.masksToBounds=YES;
        [loginButton setTitle:@"登 录/注册" forState:UIControlStateNormal];
        [loginButton addTarget:self action:@selector(didLoginButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(_loginFootView).offset(20.0);
            make.right.mas_equalTo(_loginFootView.mas_right).offset(-20.0);
            make.height.equalTo(@40.0);
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
            make.left.top.mas_equalTo(_logoutFootView).offset(20.0);
            make.right.mas_equalTo(_logoutFootView).offset(-20.0);
            make.height.equalTo(@40.0);
        }];
        
    }
    return _logoutFootView;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    [self updateUserPoint];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我";
    self.tableView.backgroundColor=[UIColor red:246 green:242 blue:241 alpha:1];
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
-(void)updateUserPoint{
    if ([HHUserManager isLogin]) {
        WEAKSELF
        HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine]  getUserPointWithUserID:[HHUserManager userID] onCompletionHandler:^(HHResponseResult *responseResult) {
            if (responseResult.responseCode==HHResponseResultCode100) {
                [HHUserManager setUserPoint:responseResult.responseData];
                /*
                UITableViewCell *cell=[weakSelf tableView:weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
                HHKeyValueContainerView *containerView=(HHKeyValueContainerView *)[cell viewWithTag:1000];
                [containerView updateValue:responseResult.responseData withKeyValueType:HHUserCenterKeyValueViewTypePoint];
                 */
                [weakSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];

            }
        }];
        [self addOperationUniqueIdentifer:op.uniqueIdentifier];
    }
}
-(void)reloadUI{
    
    self.dataSourceArray=[NSMutableArray arrayWithArray:[HHItemModel userCenterItems]];
    if ([HHUserManager isLogin]) {
        self.tableView.tableHeaderView=nil;
        self.tableView.tableFooterView=self.logoutFootView;
    }else{
        self.tableView.tableHeaderView=self.headerView;
        self.tableView.tableFooterView=self.loginFootView;
    }
    UserModel *userModel=[HHUserManager userModel];
    [_logoImgView sd_setImageWithURL:[NSURL URLWithString:userModel.userHeadUrl] placeholderImage:MCMallDefaultImg];
    [self.tableView reloadData];
}

-(void)didLogoutButtonPressed{
    [HHUserManager logout];
    [self reloadUI];
    [[NSNotificationCenter defaultCenter] postNotificationName:UserLogoutSucceedNotification object:nil];
   // [self verfiyUserLogin];
}
-(void)didLoginButtonPressed{
    LoginViewController *loginController=[[LoginViewController alloc]  initWithStyle:UITableViewStylePlain];
    UINavigationController *navController=[[UINavigationController alloc]  initWithRootViewController:loginController];
    [self.navigationController presentViewController:navController animated:YES completion:^{
        
    }];
}

#pragma mark -UITableView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSourceArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger row=0;
    NSArray *arry= [self.dataSourceArray objectAtIndex:section];
    row=arry.count;

    return row;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserModel *userModel=[HHUserManager userModel ];
    HHItemModel *itemModel=[[self.dataSourceArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    UITableViewCell *cell;
    if (itemModel.itemType==HHUserCenterItemTypeUserInfo) {
        static NSString *identifer=@"usercentercellIdentifer";
        cell =[tableView dequeueReusableCellWithIdentifier:identifer];
        if (nil==cell) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifer];
            cell.imageView.layer.cornerRadius=5;
            cell.imageView.layer.masksToBounds=YES;
            [cell.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(60, 60));
                make.left.mas_equalTo(15);
                make.centerY.mas_equalTo(cell.contentView.mas_centerY);
            }];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.detailTextLabel.textColor=[UIColor lightGrayColor];
            cell.detailTextLabel.font=[UIFont systemFontOfSize:13];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.separatorInset=UIEdgeInsetsZero;
    }else if (itemModel.itemType==HHUserCenterItemTypePoint){
        static NSString *identifer=@"userpointercellIdentifer";
        cell =[tableView dequeueReusableCellWithIdentifier:identifer];
        if (nil==cell) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.detailTextLabel.textColor=[UIColor lightGrayColor];
            cell.detailTextLabel.font=[UIFont systemFontOfSize:13];
            cell.accessoryType=UITableViewCellAccessoryNone;
            HHKeyValueContainerView *containerView=[[HHKeyValueContainerView alloc]  initContainerViewWithKeyValuViews:[HHKeyValueView userCenterKeyValueViews]];
            containerView.tag=1000;
            [cell.contentView addSubview:containerView];
            __weak UITableViewCell *weakSelf=cell;
            [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(weakSelf.contentView);
            }];
            containerView.didKeyValueTouchedBlock=^(HHKeyValueView *aKeyValuView,NSInteger index){
                if (aKeyValuView.type==HHUserCenterKeyValueViewTypePoint) {
                    
                }else if (aKeyValuView.type==HHUserCenterKeyValueViewTypeMoney){
                
                }else if (aKeyValuView.type==HHUserCenterKeyValueViewTypePushMsg){
                
                }
            };
        }
        HHKeyValueContainerView *containerView=(HHKeyValueContainerView *)[cell viewWithTag:1000];
        for (HHKeyValueView *aKeyValuView in containerView.keyValueViewArray) {
            if (aKeyValuView.type==HHUserCenterKeyValueViewTypePoint) {
                aKeyValuView.value=[NSString stringWithFormat:@"%.0f",userModel.userPoint];
            }else if (aKeyValuView.type==HHUserCenterKeyValueViewTypeMoney){
                aKeyValuView.value=[NSString stringWithFormat:@"%.2f元",userModel.userAmount];
            }else if (aKeyValuView.type==HHUserCenterKeyValueViewTypePushMsg){
                aKeyValuView.value=@"5条";
                aKeyValuView.badgeValue=5;
            }
        }
    }else{
        static NSString *identifer=@"cellIdentifer";
        cell =[tableView dequeueReusableCellWithIdentifier:identifer];
        if (nil==cell) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifer];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.detailTextLabel.textColor=[UIColor lightGrayColor];
            cell.detailTextLabel.font=[UIFont systemFontOfSize:13];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        
        cell.imageView.image=itemModel.itemImage;
        cell.textLabel.text=itemModel.itemName;
        cell.backgroundColor=[UIColor whiteColor];
    }
    switch (itemModel.itemType) {
        case  HHUserCenterItemTypeUserInfo:{
            cell.detailTextLabel.text=userModel.userName;
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:userModel.userHeadUrl] placeholderImage:MCMallDefaultImg];
            cell.textLabel.text=userModel.userName;
            if (userModel.motherState==MotherStatePregnant) {
                cell.detailTextLabel.text=@"备孕中";
            }else if (userModel.motherState==MotherStateAfterBirth){
                cell.detailTextLabel.text=@"产后";
            }
        }break;
        case HHUserCenterItemTypePoint:{
            //cell.detailTextLabel.text=[userModel.userAmount.stringValue stringByAppendingString:@"(去充值)"];
        }break;
        case HHUserCenterItemTypeConsume:{
            cell.detailTextLabel.text=@"5";
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
        height=80;
    }else if(itemModel.itemType==HHUserCenterItemTypePoint){
        height=50;
    }else{
        height=44.0;
    }
    return height;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HHItemModel *itemModel=[[[self dataSourceArray]  objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    switch (itemModel.itemType) {
        case HHUserCenterItemTypeUserInfo:{
            UserInfoViewController *userInfoViewController=[[UserInfoViewController alloc]  init];
            userInfoViewController.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:userInfoViewController animated:YES];

        }break;
        case HHUserCenterItemTypeBabyInfo:
        {
            BabeInfoViewController *babeInfoViewController=[[BabeInfoViewController alloc]  init];
            babeInfoViewController.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:babeInfoViewController animated:YES];
        }break;
        case HHUserCenterItemTypeSetting:{
            SettingViewController *settinControler=[[SettingViewController alloc]  initWithStyle:UITableViewStyleGrouped];
            settinControler.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:settinControler animated:YES];
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
