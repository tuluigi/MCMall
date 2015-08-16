//
//  UserStateSelectController.m
//  MCMall
//
//  Created by Luigi on 15/8/14.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "UserStateSelectController.h"
#import "HHNetWorkEngine+UserCenter.h"
@implementation UserStateSelectController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title=@"请选择状态";
    self.tableView.separatorColor=[UIColor clearColor];
    [self.navigationItem setHidesBackButton:YES animated:NO];
}
-(void)updateMotherState:(NSInteger)state{
    WEAKSELF
    [HHProgressHUD showLoadingState];
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine] userChoseWithUserID:[HHUserManager userID] statu:state onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCode100) {
            [HHUserManager setMotherState:state];
            
            if ([[[weakSelf.navigationController viewControllers] firstObject] presentingViewController]) {
                [(UIViewController *)[[weakSelf.navigationController viewControllers] firstObject] dismissViewControllerAnimated:YES completion:^{
                    
                }];
            }else{
                NSInteger index=(weakSelf.navigationController.viewControllers.count-3);
                if (index<0) {
                    [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                }else{
                    UIViewController *controller=[weakSelf.navigationController.viewControllers objectAtIndex:index];
                    [weakSelf.navigationController popToViewController:controller animated:YES];
                }
            }
            
        }else{
            [HHProgressHUD makeToast:responseResult.responseMessage];
        }
    }];
    [self addOperationUniqueIdentifer:op.uniqueIdentifier];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *idenfier=@"identifer";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:idenfier];
    if (nil==cell) {
        cell=[[UITableViewCell alloc]   initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenfier];
        
        UIImageView *imgView=[[UIImageView alloc]  init];
        [cell.contentView addSubview:imgView];
        imgView.tag=1000;
        
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }
    UIImageView *imgView=(UIImageView *)[cell viewWithTag:1000];
    if (indexPath.row==0) {
        imgView.image=[UIImage imageNamed:@"beiyun"];
    }else if (indexPath.row==1){
        imgView.image=[UIImage imageNamed:@"chanhou"];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGRectGetHeight(self.view.bounds)/2;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self updateMotherState:(indexPath.row+1)];
}
@end
