//
//  SalesViewController.m
//  MCMall
//
//  Created by Luigi on 15/9/23.
//  Copyright © 2015年 Luigi. All rights reserved.
//

#import "SalesViewController.h"
#import "HHUserNetService.h"
#import "UserModel.h"
@interface SalesViewController ()

@end

@implementation SalesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"选择母婴顾问";
    [self getSalesList];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getSalesList{
    WEAKSELF
    [self.view showPageLoadingView];
    HHNetWorkOperation *op=[HHUserNetService getSalersOnCompletionHandler:^(HHResponseResult *responseResult) {
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger num=self.dataSourceArray.count;
    return num;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifer=@"identifer";
    
    UITableViewCell *cell=[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    if (nil==cell) {
       cell=[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
        cell.textLabel.font=[UIFont systemFontOfSize:14];
        cell.textLabel.textColor=[UIColor blackColor];
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
    }
    SalerModel *salers=[self.dataSourceArray objectAtIndex:indexPath.row];
    cell.textLabel.text=salers.salerName;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     SalerModel *salers=[self.dataSourceArray objectAtIndex:indexPath.row];
    if (_delegate&&[_delegate respondsToSelector:@selector(didSelectSalesWithSlaerID:salerName:)]) {
        [_delegate didSelectSalesWithSlaerID:salers.salerID salerName:salers.salerName];
    }
    [self.navigationController popViewControllerAnimated:YES];
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
