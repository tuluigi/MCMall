//
//  UserInfoViewController.m
//  MCMall
//
//  Created by Luigi on 15/7/16.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "UserInfoViewController.h"
#import "HHNetWorkEngine+UserCenter.h"
#import "QBImagePickerController.h"
#import "HHItemModel.h"
@interface UserInfoViewController ()<UIAlertViewDelegate,UIActionSheetDelegate,QBImagePickerControllerDelegate>
@property(nonatomic,strong)UITapGestureRecognizer *tapGesture;

@end

@implementation UserInfoViewController

-(void)doneButtonPressed:(UIBarButtonItem *)sender{
    
}
-(void)cancelButtonPressed:(UIBarButtonItem *)sender{
    
    
}

-(void)handleTapGesture:(UITapGestureRecognizer *)gesture{
    UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"查看大图",@"重新上传", nil];
    actionSheet.tag=2000;
    [actionSheet showInView:self.view];
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title=@"个人信息";
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]  initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonPressed)];
    self.dataSourceArray=[NSMutableArray arrayWithArray:[HHItemModel userInfoItemsArray]];
}
#pragma mark- getuserinfo
-(void)rightBarButtonPressed{
    
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
            [weakSelf.tableView reloadRowsAtIndexPaths:@[([NSIndexPath indexPathForRow:0 inSection:0])] withRowAnimation:UITableViewRowAnimationAutomatic];
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HHItemModel *itemModel=[[self.dataSourceArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    UITableViewCell *cell;
    if (itemModel.itemType==HHUserInfoItemTypeHeaderImage) {
        NSString *idenfier=@"userHeaderidentifer";
        cell=[tableView dequeueReusableCellWithIdentifier:idenfier];
        if (nil==cell) {
            cell=[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenfier];
            cell.textLabel.font=[UIFont boldSystemFontOfSize:14];
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
                make.top.mas_equalTo(weakCell.contentView.top).offset(5);
                make.bottom.mas_equalTo(weakCell.contentView.mas_bottom).offset(-5);
                make.right.mas_equalTo(weakCell.contentView.mas_right).offset(-10);
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
    UserModel *userModel=[UserModel userModel];
    cell.textLabel.text=itemModel.itemName;
    switch (itemModel.itemType) {
        case HHUserInfoItemTypeHeaderImage:
        {
            UIImageView *headImageView=(UIImageView *)[cell.contentView viewWithTag:1000];
            [headImageView sd_setImageWithURL:[NSURL URLWithString:userModel.userHeadUrl] placeholderImage:MCMallDefaultImg];

        }
            break;
            
        default:
            break;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
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
    if (actionSheet.tag==2000) {
        if (buttonIndex==0) {
            
        }else if (buttonIndex==1){
            UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照上传",@"相册上传", nil];
            actionSheet.tag=2001;
            [actionSheet showInView:self.view];
        }
    }else if(actionSheet.tag==2001){
        if (buttonIndex==0) {
            
        }else if (buttonIndex==1){
            [self imagePickerButtonPressed];
        }
    }
}
@end
