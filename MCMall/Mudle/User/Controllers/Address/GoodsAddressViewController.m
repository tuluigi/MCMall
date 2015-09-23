//
//  GoodsAddressAddController.m
//  MCMall
//
//  Created by Luigi on 15/8/13.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "GoodsAddressViewController.h"
#import "GoodsAddressAddController.h"
#import "HHUserNetService.h"
#import "AddressModel.h"
#define  AddresssCellIdentifer  @"AddresssCellIdentifer"
@interface GoodsAddressViewController ()

@end

@implementation GoodsAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"收获地址列表";
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(didRighButtonPressed)];
    [self getAddressList];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)didRighButtonPressed{
    GoodsAddressAddController *addAddresssController=[[GoodsAddressAddController alloc]  initWithAddressModel:nil];
    [self.navigationController pushViewController:addAddresssController animated:YES];
}
-(void)getAddressList{
    if (self.dataSourceArray.count==0) {
        [self.view showPageLoadingView];
    }
    WEAKSELF
    HHNetWorkOperation *op=[HHUserNetService getReceiveAddressListWithUserID:[HHUserManager userID] onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCodeSuccess) {
            [weakSelf.view dismissPageLoadView];
            [weakSelf.dataSourceArray addObjectsFromArray:responseResult.responseData];
            [weakSelf.tableView reloadData];
        }else{
            [weakSelf.view showPageLoadedMessage:responseResult.responseMessage delegate:nil];
        }
    }];
    [self addOperationUniqueIdentifer:op.uniqueIdentifier];
}
-(void)deleteAddressWithAddresssModel:(AddressModel *)addressModel{
    [self.view showLoadingState];
    WEAKSELF
    HHNetWorkOperation *op=[HHUserNetService deleteReceiveAddressWithUserID:[HHUserManager userID] addressID:addressModel.addressID onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCodeSuccess) {
            NSInteger index=[weakSelf.dataSourceArray indexOfObject:addressModel];
            [weakSelf.dataSourceArray removeObject:addressModel];
            [weakSelf.tableView beginUpdates];
            [weakSelf.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
            [weakSelf.tableView endUpdates];
            
        }else{
            [weakSelf.view showErrorMssage:responseResult.responseMessage];
        }
    }];
    [self addOperationUniqueIdentifer:op.uniqueIdentifier];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"identifer"];
    if (nil==cell) {
        cell=[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"identifer"];
        cell.selectionStyle=UITableViewCellSelectionStyleGray;
        cell.textLabel.font=[UIFont systemFontOfSize:14];
        cell.textLabel.textColor=[UIColor blackColor];
        cell.detailTextLabel.textColor=[UIColor darkGrayColor];
        cell.detailTextLabel.font=[UIFont systemFontOfSize:13];
        cell.detailTextLabel.numberOfLines=2;
    }
    AddressModel *addresssModel=[self.dataSourceArray objectAtIndex:indexPath.row];
    cell.textLabel.text=[[addresssModel.receiverName stringByAppendingString:@"   "] stringByAppendingString:addresssModel.receiverTel];
    cell.detailTextLabel.text=addresssModel.addressDetail;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        [self deleteAddressWithAddresssModel:[self.dataSourceArray objectAtIndex:indexPath.row]];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AddressModel *addresssModel=[self.dataSourceArray objectAtIndex:indexPath.row];
    GoodsAddressAddController *addAddresssController=[[GoodsAddressAddController alloc]  initWithAddressModel:addresssModel];
    [self.navigationController pushViewController:addAddresssController animated:YES];
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
