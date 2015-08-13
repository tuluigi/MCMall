//
//  GoodsAddressAddViewController.m
//  MCMall
//
//  Created by Luigi on 15/8/13.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "GoodsAddressAddViewController.h"
#import "HHNetWorkEngine+Goods.h"
#import "GoodsModel.h"
@interface GoodsAddressAddViewController ()<UIAlertViewDelegate>
@property(nonatomic,copy)NSString *userName,*userTel,*address;
@property(nonatomic,strong)UIView *footView;
@end

@implementation GoodsAddressAddViewController
-(UIView *)footView{
    if (nil==_footView) {
        _footView=[[UIView alloc]  initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)];
        _footView.userInteractionEnabled=YES;
        UIButton *doneButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_footView addSubview:doneButton];
        doneButton.tag=1000;
        doneButton.userInteractionEnabled=YES;
        doneButton.layer.cornerRadius=6.0;
        doneButton.layer.masksToBounds=YES;
        doneButton.backgroundColor=MCMallThemeColor;
        [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [doneButton setTitle:@"确定" forState:UIControlStateNormal];
        [doneButton addTarget:self action:@selector(didActionButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [doneButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(20, 30, 10, 30));
        }];
    }
    return _footView;
}
-(void)didActionButtonPressed:(UIButton *)sedner{
    if ([NSString IsNullOrEmptyString:self.userName]) {
        [HHProgressHUD makeToast:@"请输入收货人名称"];
    }else if (![self.userTel isPhoneNumber]){
        [HHProgressHUD makeToast:@"请输入收货人电话"];
    }else if ([NSString IsNullOrEmptyString:self.address]){
        [HHProgressHUD makeToast:@"请输入收货人地址"];
    }else{
        [HHProgressHUD showLoadingState];
        HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine] bookGoodsGoodsID:self.goodsModel.goodsID userID:[HHUserManager userID] phoneNum:self.userTel connact:self.userName address:self.address onCompletionHandler:^(HHResponseResult *responseResult) {
            [HHProgressHUD dismiss];
            if (responseResult.responseCode==HHResponseResultCode100) {
                UIAlertView *alertView=  [[UIAlertView alloc] initWithTitle:@"提示" message:@"恭喜您预订成功,可以看看其他商品！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"知道啦", nil];
                [alertView show];
            }else{
                [HHProgressHUD makeToast:responseResult.responseMessage];
            }
        }];
        [self addOperationUniqueIdentifer:op.uniqueIdentifier];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"预订信息";
    CGRect frame=self.footView.frame;
    CGSize size=[self.footView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    frame.size.height=size.height;
    frame.size.width=CGRectGetWidth(self.view.bounds);
    self.footView.frame=frame;
    self.tableView.tableFooterView=self.footView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger row=0;
    if (section==0) {
        row=3;
    }else{
        return 3;
    }
    return row;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if (indexPath.section==0) {
        NSString *identifer0=@"identifer0";
        cell=[tableView dequeueReusableCellWithIdentifier:identifer0];
        if (nil==cell) {
            cell=[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifer0];
        }
        switch (indexPath.row) {
            case 0:{
                cell.textLabel.text=@"商品名称:";
                cell.detailTextLabel.text=self.goodsModel.goodsName;
            }break;
            case 1:{
                cell.textLabel.text=@"购买数量:";
                cell.detailTextLabel.text=@"1件";
            }break;
            case 2:{
                cell.textLabel.text=@"金额";
                cell.detailTextLabel.text=[NSString stringWithFormat:@"%.2f元",_goodsModel.presenPrice];
            } break;
            default:
                break;
        }
    }else{
        NSString *identifer1=@"identifer1";
        cell=[tableView dequeueReusableCellWithIdentifier:identifer1];
        if (nil==cell) {
            cell=[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer1];
            UITextField *textField=[[UITextField alloc]  initWithFrame:CGRectMake(15.0, 0, CGRectGetWidth(tableView.bounds)-30.0, 44.0)];
            textField.textAlignment=NSTextAlignmentLeft;
            textField.tag=1000;
            cell.contentView.userInteractionEnabled=YES;
            [cell.contentView addSubview:textField];
            
            UILabel *leftLable=[[UILabel alloc]  initWithFrame:CGRectMake(0, 0, 80.0, CGRectGetHeight(textField.bounds))];
            leftLable.textAlignment=NSTextAlignmentLeft;
            leftLable.font=[UIFont systemFontOfSize:16.0];
            leftLable.textColor=[UIColor blackColor];
            textField.leftView=leftLable;
            textField.leftViewMode=UITextFieldViewModeAlways;
            
            [textField addTarget:self action:@selector(didTextFiledValueChanged:) forControlEvents:UIControlEventEditingChanged];
        }
        UITextField *textField=(UITextField *)[cell viewWithTag:1000];
        
        UILabel *leftLable=(UILabel *)textField.leftView;
        textField.rightViewMode=UITextFieldViewModeNever;
        textField.keyboardType=UIKeyboardTypeDefault;
        
        switch (indexPath.row) {
            case 0:{
                textField.placeholder=@"收货人名称";
                leftLable.text=@"姓名:";
            } break;
            case 1:{
                textField.placeholder=@"收货人电话";
                leftLable.text=@"电话";
            }break;
            case 2:{
                textField.placeholder=@"收货人地址";
                leftLable.text=@"地址:";
            }break;
            default:
                break;
        }
    }
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *lable=[[UILabel alloc]  initWithFrame:CGRectMake(15, 0, 100, 20)];
    lable.textColor=[UIColor darkGrayColor];
    lable.font=[UIFont systemFontOfSize:14];
    if (section==0) {
        lable.text=@"   商品信息";
    }else{
        lable.text=@"   完善收货人信息";
    }
    return lable;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(void)didTextFiledValueChanged:(UITextField *)textFiled{
    //get cell
    UITableViewCell *cell = (UITableViewCell *)[[textFiled superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    switch (indexPath.row) {
        case 0:{
            self.userName=textFiled.text;
        }break;
        case 1:{
            self.userTel=textFiled.text;
        }break;
        case 2:{
            self.address=textFiled.text;
        }break;
        default:
            break;
    }
}
#pragma alertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSInteger index=(self.navigationController.viewControllers.count-3);
    if (index<0) {
        index=0;
    }
    UIViewController *controller=[self.navigationController.viewControllers objectAtIndex:index];
    [self.navigationController popToViewController:controller animated:YES];
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
