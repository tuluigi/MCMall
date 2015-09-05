//
//  UserInfoViewController.m
//  MCMall
//
//  Created by Luigi on 15/7/16.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "UserInfoViewController.h"
#import "HHNetWorkEngine+UserCenter.h"
#import "HHItemModel.h"
#import "HHImagePickerHelper.h"
#import "EditPasswordViewController.h"
@interface UserInfoViewController ()<UIAlertViewDelegate,UIActionSheetDelegate>
@property(nonatomic,strong)HHImagePickerHelper *imagePickerHelper;

@end

@implementation UserInfoViewController
-(HHImagePickerHelper *)imagePickerHelper{
    if (nil==_imagePickerHelper) {
        _imagePickerHelper=[[HHImagePickerHelper alloc]  init];
    }
    return _imagePickerHelper;
}
-(void)rightBarButtonPressed:(UIBarButtonItem *)sender{
    
}
-(void)cancelButtonPressed:(UIBarButtonItem *)sender{
    
    
}

-(void)handleTapGesture:(UITapGestureRecognizer *)gesture{
    UserModel *userModel=[HHUserManager userModel];
    [[HHPhotoBroswer sharedPhotoBroswer]  showBrowserWithImages:@[userModel.userHeadUrl] atIndex:0];
   
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title=@"个人信息";
//    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]  initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonPressed:)];
    self.dataSourceArray=[NSMutableArray arrayWithArray:[HHItemModel userInfoItemsArray]];
}
#pragma mark- getuserinfo
-(void)uploadHeaderImageWithImagePath:(NSString *)loaclPath{
    WEAKSELF
    //[weakSelf.view showLoadingMessage:@"正在上传..."];
    HHNetWorkOperation *operation=[[HHNetWorkEngine sharedHHNetWorkEngine] uploadUserImageWithUserID:[HHUserManager userID] imagePath:loaclPath  onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCodeSuccess) {
            [HHUserManager setUserHeaderImageUrl:responseResult.responseData];
            [weakSelf.tableView reloadRowsAtIndexPaths:@[([NSIndexPath indexPathForRow:0 inSection:0])] withRowAnimation:UITableViewRowAnimationAutomatic];
            
            [weakSelf.view dismiss];
        }else{
            [weakSelf.view showErrorMssage:@"上传失败"];
        }
    }];
   
    [self addOperationUniqueIdentifer:operation.uniqueIdentifier];
}

-(void)editMotherState:(NSInteger)state{
    WEAKSELF
    [weakSelf.view showLoadingState];
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine] userChoseWithUserID:[HHUserManager userID] statu:state onCompletionHandler:^(HHResponseResult *responseResult) {
        [weakSelf.view dismiss];
        if (responseResult.responseCode==HHResponseResultCodeSuccess) {
            
            [HHUserManager setMotherState:state];
            [weakSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationFade];
        }else{
            [weakSelf.view makeToast:responseResult.responseMessage];
        }
    }];
    [self addOperationUniqueIdentifer:op.uniqueIdentifier];
}

#pragma mark -tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSourceArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.dataSourceArray objectAtIndex:section] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HHItemModel *itemModel=[[self.dataSourceArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    UITableViewCell *cell;
    if (itemModel.itemType==HHUserInfoItemTypeHeaderImage) {
        NSString *idenfier=@"userHeaderidentifer";
        cell=[tableView dequeueReusableCellWithIdentifier:idenfier];
        if (nil==cell) {
            cell=[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenfier];
            cell.textLabel.font=[UIFont boldSystemFontOfSize:16];
            cell.textLabel.textColor=[UIColor blackColor];
            cell.detailTextLabel.font=[UIFont systemFontOfSize:14];
            cell.detailTextLabel.textColor=[UIColor darkGrayColor];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.contentView.userInteractionEnabled=YES;
            UIImageView *headImageView=[[UIImageView alloc]  init];
            headImageView.userInteractionEnabled=YES;
            headImageView.tag=1000;
            headImageView.layer.cornerRadius=4.0;
            headImageView.layer.masksToBounds=YES;
            UITapGestureRecognizer * tapGesture=[[UITapGestureRecognizer alloc]  initWithTarget:self action:@selector(handleTapGesture:)];
            [headImageView addGestureRecognizer:tapGesture];
            [cell.contentView addSubview:headImageView];
            __weak UITableViewCell *weakCell=cell;
            [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(weakCell.contentView);
                make.right.mas_equalTo(weakCell.contentView.mas_right).offset(-10);
                make.size.mas_equalTo(CGSizeMake(50, 50));
            }];
        }

    }else{
        NSString *idenfier=@"identifer";
        cell=[tableView dequeueReusableCellWithIdentifier:idenfier];
        if (nil==cell) {
            cell=[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:idenfier];
            cell.textLabel.font=[UIFont boldSystemFontOfSize:14];
            cell.textLabel.textColor=[UIColor blackColor];
            cell.detailTextLabel.font=[UIFont systemFontOfSize:14];
            cell.detailTextLabel.textColor=[UIColor darkGrayColor];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    UserModel *userModel=[HHUserManager userModel];
    cell.textLabel.text=itemModel.itemName;
    switch (itemModel.itemType) {
        case HHUserInfoItemTypeHeaderImage:
        {
            UIImageView *headImageView=(UIImageView *)[cell.contentView viewWithTag:1000];
            [headImageView sd_setImageWithURL:[NSURL URLWithString:userModel.userHeadUrl] placeholderImage:MCMallDefaultImg];

        }break;
        case HHUserInfoItemTypeMotherState:{
            if (userModel.motherState==MotherStatePregnant) {
                cell.detailTextLabel.text=@"备孕中";
            }else if(userModel.motherState==MotherStateAfterBirth){
                cell.detailTextLabel.text=@"产后";
            }
        }break;
        case HHUserInfoItemTypeEditPwd:{
            cell.textLabel.text=@"修改密码";
            cell.detailTextLabel.text=@"";
        }break;
        default:
            break;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height=0;
    HHItemModel *itemModel=[[self.dataSourceArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if (itemModel.itemType==HHUserInfoItemTypeHeaderImage) {
        height=60;
    }else{
        height=44.0;
    }
    return height;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HHItemModel *itemModel=[[self.dataSourceArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if (itemModel.itemType==HHUserInfoItemTypeHeaderImage) {
        WEAKSELF
        [self.imagePickerHelper  showImagePickerWithType:HHImagePickTypeAll onCompletionHandler:^(NSString *imgPath) {
            [weakSelf uploadHeaderImageWithImagePath:imgPath];
        }];
    }else if (itemModel.itemType==HHUserInfoItemTypeMotherState){
        UIActionSheet *actionSheet=[[UIActionSheet alloc]  initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"备孕中",@"产后", nil];
        actionSheet.tag=100;
        [actionSheet showInView:self.view];
    }else if(itemModel.itemType==HHUserInfoItemTypeEditPwd){
        EditPasswordViewController *editUserPwdController=[[EditPasswordViewController alloc]  init];
        [self.navigationController pushViewController:editUserPwdController animated:YES];
    }
   

    /*
    NSString *titleStr=@"";
    NSString *messageStr=@"";
    
    UIAlertView *alerView=[[UIAlertView alloc]  initWithTitle:titleStr message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alerView.alertViewStyle=UIAlertViewStylePlainTextInput;
    UITextField *textFiled=[alerView textFieldAtIndex:0];
    textFiled.text=messageStr;
    alerView.tag=indexPath.row;
    [alerView show];
     */
}

#pragma mark alertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    UITextField *textFiled=[alertView textFieldAtIndex:0];
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self editMotherState:(buttonIndex+1)];
}
@end
