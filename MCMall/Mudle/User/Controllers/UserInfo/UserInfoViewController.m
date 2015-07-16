//
//  UserInfoViewController.m
//  MCMall
//
//  Created by Luigi on 15/7/16.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "UserInfoViewController.h"


@interface UserInfoViewController ()<UIAlertViewDelegate>

@end

@implementation UserInfoViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title=@"个人信息";
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *idenfier=@"identifer";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:idenfier];
    if (nil==cell) {
        cell=[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:idenfier];
        cell.textLabel.font=[UIFont systemFontOfSize:14];
        cell.textLabel.textColor=[UIColor blackColor];
        cell.detailTextLabel.font=[UIFont systemFontOfSize:14];
        cell.detailTextLabel.textColor=[UIColor darkGrayColor];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    switch (indexPath.row) {
        case 0:{
            cell.textLabel.text=@"生日";
            cell.detailTextLabel.text=@"";
        }break;
        case 1:{
            cell.textLabel.text=@"大名";
            cell.detailTextLabel.text=@"";
        }break;
        case 2:{
            cell.textLabel.text=@"小名";
            cell.detailTextLabel.text=@"";
        }break;
        case 3:{
            cell.textLabel.text=@"性别";
            cell.detailTextLabel.text=@"";
        }break;
        default:
            break;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *titleStr=@"";
    NSString *messageStr=@"";
    switch (indexPath.row) {
        case 0:{
            titleStr=@"生日";
            messageStr=@"";
        }break;
        case 1:{
            titleStr=@"修改大名";
            messageStr=@"";
        }break;
        case 2:{
            titleStr=@"修改小名";
        }break;
        case 3:{
            titleStr=@"性别";
        }break;
        default:
            break;
    }

    UIAlertView *alerView=[[UIAlertView alloc]  initWithTitle:titleStr message:messageStr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alerView.alertViewStyle=UIAlertViewStylePlainTextInput;
    alerView.tag=indexPath.row;
    [alerView show];
}

#pragma mark alertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    UITextField *textFiled=[alertView textFieldAtIndex:0];
    
}

@end
