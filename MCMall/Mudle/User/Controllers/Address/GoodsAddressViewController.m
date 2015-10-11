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
#import "GoodsAddressListCell.h"
#define  AddresssCellIdentifer  @"AddresssCellIdentifer"
@interface GoodsAddressViewController ()

@end

@implementation GoodsAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"收货地址列表";
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(didRighButtonPressed)];
    WEAKSELF
    [self.tableView addPullToRefreshWithActionHandler:^{
        [weakSelf getAddressList];
    }];
    [weakSelf.tableView triggerPullToRefresh];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)didRighButtonPressed{
    [self gotoGoodAddressAddController:nil];
}
-(void)getAddressList{
    WEAKSELF
    HHNetWorkOperation *op=[HHUserNetService getReceiveAddressListWithUserID:[HHUserManager userID] onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCodeSuccess) {
            [weakSelf.dataSourceArray removeAllObjects];
            [weakSelf.dataSourceArray addObjectsFromArray:responseResult.responseData];
            [weakSelf.tableView reloadData];
        }else{
            if (weakSelf.dataSourceArray.count) {
                [weakSelf.view showErrorMssage:responseResult.responseMessage];
            }else{
            [weakSelf.view showPageLoadedMessage:responseResult.responseMessage delegate:nil];
            }
        }
        [weakSelf.tableView.pullToRefreshView stopAnimating];
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
            [weakSelf.view dismissHUD];
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
    GoodsAddressListCell *cell=[tableView dequeueReusableCellWithIdentifier:@"identifer"];
    if (nil==cell) {
        cell=[[GoodsAddressListCell alloc]  initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"identifer"];
        
        if (self.isSelect) {
            cell.accessoryType=UITableViewCellAccessoryNone;
        }else{
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    AddressModel *addresssModel=[self.dataSourceArray objectAtIndex:indexPath.row];
    cell.addressModel=addresssModel;
 
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isSelect) {
        return NO;
    }
    return YES;
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        [self deleteAddressWithAddresssModel:[self.dataSourceArray objectAtIndex:indexPath.row]];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AddressModel *addresssModel=[self.dataSourceArray objectAtIndex:indexPath.row];
    if (self.isSelect) {
        if (_delegate&&[_delegate respondsToSelector:@selector(didSelectUserReceiveAddresss:)]) {
            [_delegate didSelectUserReceiveAddresss:addresssModel];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self gotoGoodAddressAddController:addresssModel];
    }
}

-(void)gotoGoodAddressAddController:(AddressModel *)addresssModel{
    GoodsAddressAddController *addAddresssController=[[GoodsAddressAddController alloc]  initWithAddressModel:addresssModel];
    WEAKSELF
    addAddresssController.addressModelChangeBlock=^(AddressModel *addresss,BOOL isAdd){
        if (isAdd) {
//            if (weakSelf.dataSourceArray.count>1) {
//                [weakSelf.dataSourceArray insertObject:addresssModel atIndex:1];
//            }else{
//                [weakSelf.dataSourceArray addObject:addresss];
//            }
            [weakSelf.dataSourceArray addObject:addresss];
        }else{
            NSPredicate *predicate=[NSPredicate predicateWithFormat:@"_addressID=%@",addresss.addressID];
            NSArray *tempArray=[weakSelf.dataSourceArray filteredArrayUsingPredicate:predicate];
            if (tempArray&&tempArray.count) {
                NSInteger index=[weakSelf.dataSourceArray indexOfObject:[tempArray firstObject]];
                [weakSelf.dataSourceArray replaceObjectAtIndex:index withObject:addresss];
            }
        }
        [weakSelf.tableView reloadData];
    };
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
