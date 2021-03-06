//
//  GoodsAddressAddController.m
//  MCMall
//
//  Created by Luigi on 15/9/7.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "GoodsAddressAddController.h"
#import "GoodsModel.h"
#import "HHUserNetService.h"
#import "AddressModel.h"
@interface GoodsAddressAddController ()<UITextFieldDelegate>
@property(nonatomic,strong)UISwitch *switchView;
@property(nonatomic,strong)UIView *footView;
@property(nonatomic,copy)__block AddressModel *addresssModel;
@end

@implementation GoodsAddressAddController

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
        [doneButton setTitle:@"确  定" forState:UIControlStateNormal];
        [doneButton addTarget:self action:@selector(didActionButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [doneButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(20, 30, 10, 40));
        }];
    }
    return _footView;
}
-(void)didActionButtonPressed:(UIButton *)sedner{
    [self.view endEditing:YES];
    WEAKSELF
    if ([NSString IsNullOrEmptyString:self.addresssModel.receiverName]) {
        [weakSelf.view makeToast:@"请输入收货人名称"];
    }else if (![self.addresssModel.receiverTel isPhoneNumber]){
        [weakSelf.view makeToast:@"请输入正确的电话号码"];
    }else if ([NSString IsNullOrEmptyString:self.addresssModel.addressDetail]){
        [weakSelf.view makeToast:@"请输入收货人地址"];
    }else{
        if ([HHUserManager isLogin]) {
            [self editAddressWithAddressModel:self.addresssModel];
        }else{
            [HHUserManager shouldUserLoginOnCompletionBlock:^(BOOL isSucceed, NSString *userID) {
                if (isSucceed) {
                    [weakSelf editAddressWithAddressModel:weakSelf.addresssModel];
                }
            }];
        }
        
    }
}
-(instancetype)initWithAddressModel:(AddressModel *)addresssModel{
    if (self=[super initWithStyle:UITableViewStyleGrouped]) {
        _addresssModel=addresssModel;
        if (self.addresssModel) {
            self.title=@"修改收货地址";
        }else{
            self.title=@"添加收货地址";
        }

        if (nil==_addresssModel) {
            _addresssModel=[[AddressModel alloc]  init];
        }
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      CGRect frame=self.footView.frame;
    CGSize size=[self.footView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    frame.size.height=size.height;
    frame.size.width=CGRectGetWidth(self.view.bounds);
    self.footView.frame=frame;
    self.tableView.tableFooterView=self.footView;
}
#pragma mark
-(void)editAddressWithAddressModel:(AddressModel *)addresssMode{
    WEAKSELF
    [self.view showLoadingState];
    addresssMode.isDefault=self.switchView.isOn;
    [HHUserNetService addOrEditReceiveAddressWithUserID:[HHUserManager userID] addressID:addresssMode.addressID connecterName:addresssMode.receiverName connecterTel:addresssMode.receiverTel address:addresssMode.addressDetail isDefatul:addresssMode.isDefault onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCodeSuccess) {
            BOOL isAdd=[NSString IsNullOrEmptyString:addresssMode.addressID];
            weakSelf.addresssModel.addressID=responseResult.responseData;
            if (weakSelf.addressModelChangeBlock) {
                weakSelf.addressModelChangeBlock(weakSelf.addresssModel,isAdd);
            }
            [weakSelf.view showSuccessMessage:responseResult.responseMessage];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [weakSelf.view showErrorMssage:responseResult.responseMessage];
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
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
        _switchView=[[UISwitch alloc] initWithFrame:CGRectMake(CGRectGetWidth(tableView.bounds)-60.0,5, 40, 30)];
        _switchView.tag=2000;
        _switchView.hidden=YES;
        [_switchView setOn:NO];
        [cell.contentView addSubview:_switchView];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    UITextField *textField=(UITextField *)[cell viewWithTag:1000];
    UISwitch *switchView=(UISwitch *)[cell viewWithTag:2000];
    UILabel *leftLable=(UILabel *)textField.leftView;
    textField.rightViewMode=UITextFieldViewModeNever;
    textField.keyboardType=UIKeyboardTypeDefault;
    switchView.hidden=YES;
    cell.textLabel.text=@"";
    switch (indexPath.row) {
        case 0:{
            textField.hidden=NO;
            switchView.hidden=YES;
            textField.placeholder=@"收货人名称";
            leftLable.text=@"姓名:";
            textField.text=self.addresssModel.receiverName;
        } break;
        case 1:{
            textField.hidden=NO;
            switchView.hidden=YES;
            textField.placeholder=@"收货人电话";
            leftLable.text=@"手机:";
            textField.text=self.addresssModel.receiverTel;
        }break;
        case 2:{
            textField.hidden=NO;
            switchView.hidden=YES;
            textField.placeholder=@"收货人地址";
            leftLable.text=@"地址:";
            textField.text=self.addresssModel.addressDetail;
        }break;
        case 3:{
            textField.hidden=YES;
            switchView.hidden=NO;
            cell.textLabel.text=@"默认地址:";
            switchView.on=self.addresssModel.isDefault;
        }break;
        default:
            break;
    }
    return cell;
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
            self.addresssModel.receiverName=textFiled.text;
        }break;
        case 1:{
            self.addresssModel.receiverTel=textFiled.text;
        }break;
        case 2:{
            self.addresssModel.addressDetail=textFiled.text;
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
