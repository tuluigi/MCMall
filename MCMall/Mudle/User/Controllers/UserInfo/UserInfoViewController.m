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
@interface UserInfoViewController ()<UIAlertViewDelegate,UIActionSheetDelegate>
@property(nonatomic,strong)UITapGestureRecognizer *tapGesture;

@end

@implementation UserInfoViewController

-(void)doneButtonPressed:(UIBarButtonItem *)sender{
    
}
-(void)cancelButtonPressed:(UIBarButtonItem *)sender{
    
    
}
-(UITapGestureRecognizer *)tapGesture{
    if (nil==_tapGesture) {
        _tapGesture=[[UITapGestureRecognizer alloc]  initWithTarget:self action:@selector(handleTapGesture:)];
    }
    return _tapGesture;
}
-(void)handleTapGesture:(UITapGestureRecognizer *)gesture{
    
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
            cell=[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:idenfier];
            [cell.imageView addGestureRecognizer:self.tapGesture];
            cell.textLabel.font=[UIFont systemFontOfSize:14];
            cell.textLabel.textColor=[UIColor blackColor];
            cell.detailTextLabel.font=[UIFont systemFontOfSize:14];
            cell.detailTextLabel.textColor=[UIColor darkGrayColor];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }

    }else{
        NSString *idenfier=@"identifer";
        cell=[tableView dequeueReusableCellWithIdentifier:idenfier];
        if (nil==cell) {
            cell=[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:idenfier];
            cell.textLabel.font=[UIFont systemFontOfSize:14];
            cell.textLabel.textColor=[UIColor blackColor];
            cell.detailTextLabel.font=[UIFont systemFontOfSize:14];
            cell.detailTextLabel.textColor=[UIColor darkGrayColor];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    switch (itemModel.itemType) {
        case HHUserInfoItemTypeHeaderImage:
        {
            
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
    NSString *titleStr=@"";
    NSString *messageStr=@"";
    
    UIAlertView *alerView=[[UIAlertView alloc]  initWithTitle:titleStr message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alerView.alertViewStyle=UIAlertViewStylePlainTextInput;
    UITextField *textFiled=[alerView textFieldAtIndex:0];
    textFiled.text=messageStr;
    alerView.tag=indexPath.row;
    [alerView show];
}

#pragma mark alertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    UITextField *textFiled=[alertView textFieldAtIndex:0];
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
}
@end
