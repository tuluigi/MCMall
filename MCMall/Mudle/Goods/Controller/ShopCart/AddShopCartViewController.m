//
//  AddShopCartViewController.m
//  MCMall
//
//  Created by Luigi on 15/9/25.
//  Copyright © 2015年 Luigi. All rights reserved.
//

#import "AddShopCartViewController.h"
#import "GoodsAddressListCell.h"
#import "GoodsAddressViewController.h"
#import "GoodsModel.h"
#import "HHNetWorkEngine+UserCenter.h"
#import "AddressModel.h"
#import "HHUserNetService.h"
#import "ShopCarGoodsCell.h"
#import "GoodsNetService.h"
#define ShopCartAddresssIdentifer  @"ShopCartAddresssIdentifer"
#define ShopCartGoodsIdentifer  @"ShopCartGoodsIdentifer"
#define ShopCartCommonIdentifer  @"ShopCartCommonIdentifer"
@interface AddShopCartViewController ()<UIAlertViewDelegate,UIActionSheetDelegate,GoodsAddressViewControllerDelegate,UITextFieldDelegate>
@property(nonatomic,strong)UITextField *goodsNumTextField;
@property(nonatomic,strong)UIToolbar *tooBar;
@property(nonatomic,copy)NSString   *payMethod;
@property(nonatomic,assign)CGFloat totalPrice;
@property(nonatomic,assign)__block NSInteger usePoints,userTotalPoints;
@property(nonatomic,assign)NSInteger goodsNum;
@property(nonatomic,strong)__block AddressModel *selectAddrsssModel;

@end

@implementation AddShopCartViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.toolbarHidden=NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    self.navigationController.toolbarHidden=YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self onInitData];
    // Do any additional setup after  the view.
}
-(void)onInitData{
    self.title=@"兑换";
    self.goodsNum=1;

    [self.view addSubview:self.tooBar];
    [self updateTotalPrice];
    WEAKSELF
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.removeExisting=YES;
        make.top.left.right.mas_equalTo(weakSelf.view);
        make.bottom.mas_equalTo(weakSelf.tooBar.mas_top);
    }];
    [self.tooBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(weakSelf.view );
        make.height.mas_equalTo(50);
    }];
    [self getDefaultReceiveAddress];
}
-(UIToolbar *)tooBar{
    if (nil==_tooBar) {
        _tooBar=[[UIToolbar alloc]  init];
        _tooBar.barStyle=UIBarStyleDefault;
        UIBarButtonItem *titleBarButton=[[UIBarButtonItem alloc]  initWithTitle:@" 应付金额: " style:UIBarButtonItemStylePlain target:nil action:NULL];
        titleBarButton.tag=1000;
        [titleBarButton setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
        UIBarButtonItem *moneyBarButton=[[UIBarButtonItem alloc]  initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:NULL];
        [moneyBarButton setTitleTextAttributes:@{NSForegroundColorAttributeName:MCMallThemeColor} forState:UIControlStateNormal];
        UIButton *bookButton=[UIButton buttonWithType:UIButtonTypeCustom];
        bookButton.frame=CGRectMake(0, 7, 100, 35);
        bookButton.enabled=NO;
        bookButton.tag=102;
        [bookButton setTitle:@"兑换" forState:UIControlStateNormal];
        [bookButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        bookButton.backgroundColor=MCMallThemeColor;
        bookButton.layer.cornerRadius=4;
        bookButton.layer.masksToBounds=YES;
        [bookButton addTarget:self action:@selector(didBookButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *bookBarButton=[[UIBarButtonItem alloc] initWithCustomView:bookButton];
        UIBarButtonItem *spaceBarButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        NSArray *bartItems=@[titleBarButton,moneyBarButton,spaceBarButton,bookBarButton];
        
        _tooBar.items=bartItems;
    }
    return _tooBar;
}
-(void)updateTotalPrice{
    UIBarButtonItem *titleBarButton=(UIBarButtonItem *)[self.tooBar.items objectAtIndex:1];
    self.totalPrice=self.goodsModel.sellPrice*self.goodsNum-self.usePoints;
    NSString *priceStr=[NSString stringWithFormat:@"￥%.1f",self.totalPrice];
    [titleBarButton setTitle:priceStr];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didBookButtonPressed{
    if (!self.selectAddrsssModel.addressID) {
        [self.view showErrorMssage:@"请选择收获地址"];
    }else if (!self.payMethod){
        [self.view showErrorMssage:@"请选择付款方式"];
    }else{
    WEAKSELF
    [weakSelf.view showLoadingState];
    HHNetWorkOperation *op=[GoodsNetService addOrderWithUserID:[HHUserManager userID] goodsID:self.goodsModel.goodsID addressID:self.selectAddrsssModel.addressID buyNum:self.goodsNum totalPrice:self.totalPrice points:self.usePoints payMethod:self.payMethod onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCodeSuccess) {
            [weakSelf.view dismissHUD];
            UIAlertView *alerView=[[UIAlertView alloc]  initWithTitle:nil message:@"兑换成功,再看看其他商品吧。" delegate:self cancelButtonTitle:nil otherButtonTitles:@"知道啦", nil];
            alerView.tag=2000;
            [alerView show];

        }else{
            [weakSelf.view showErrorMssage:responseResult.responseMessage];
        };
    }];
    [self addOperationUniqueIdentifer:op.uniqueIdentifier];
    }
}
-(void)setSelectAddrsssModel:(AddressModel *)selectAddrsssModel{
    _selectAddrsssModel=selectAddrsssModel;
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}
-(void)getUserTotalPoints{
    WEAKSELF
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine] getUserPointWithUserID:[HHUserManager userID] onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCodeSuccess) {
            weakSelf.userTotalPoints=[responseResult.responseData integerValue];
        }
    }];
    [self addOperationUniqueIdentifer:op.uniqueIdentifier];
}
-(void)getDefaultReceiveAddress{
    WEAKSELF
    HHNetWorkOperation *op=[HHUserNetService getDefaultAddressWithUserID:[HHUserManager userID] onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCodeSuccess) {
            weakSelf.selectAddrsssModel=responseResult.responseData;
        }
    }];
    [self addOperationUniqueIdentifer:op.uniqueIdentifier];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else{
        return 6;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if (indexPath.section==0) {
        NSString *identifer=ShopCartAddresssIdentifer;
        cell=[tableView dequeueReusableCellWithIdentifier:identifer];
        if (nil==cell) {
            cell=[[GoodsAddressListCell alloc]  initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifer];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        if (self.selectAddrsssModel) {
            ((GoodsAddressListCell *)cell).addressModel=self.selectAddrsssModel;
        }else{
            cell.textLabel.text=@"请选择收获地址";
        }
    }else{
        if (indexPath.row==1) {
            NSString *identifer=ShopCartGoodsIdentifer;
           cell=[tableView dequeueReusableCellWithIdentifier:identifer];
            if (nil==cell) {
                cell=[[ShopCarGoodsCell alloc]  initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                cell.textLabel.font=[UIFont systemFontOfSize:14];
                cell.textLabel.textColor=[UIColor darkGrayColor];
                cell.detailTextLabel.textColor=[UIColor blackColor];
                cell.detailTextLabel.font=[UIFont systemFontOfSize:14];
                cell.imageView.layer.cornerRadius=5;
                cell.imageView.layer.masksToBounds=YES;
               
                [cell.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo(CGSizeMake(60, 60));
                    make.left.mas_equalTo(15);
                    make.centerY.mas_equalTo(cell.contentView.mas_centerY);
                }];
                _goodsNumTextField=[[UITextField alloc]  init];
                _goodsNumTextField.keyboardType=UIKeyboardTypeNumberPad;
                _goodsNumTextField.textAlignment=NSTextAlignmentCenter;
                _goodsNumTextField.borderStyle=UITextBorderStyleNone;
                _goodsNumTextField.tag=1000;
                _goodsNumTextField.textColor=MCMallThemeColor;
                _goodsNumTextField.font=[UIFont systemFontOfSize:14];
                _goodsNumTextField.delegate=self;
                cell.contentView.userInteractionEnabled=YES;
                [cell.contentView addSubview:_goodsNumTextField];
                
                __weak ShopCarGoodsCell *weakCell=(ShopCarGoodsCell *)cell;
                
                [_goodsNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(weakCell.contentView.mas_right).offset(-10);
                    make.bottom.mas_equalTo(weakCell.contentView.mas_bottom).offset(-5);
                    make.size.mas_equalTo(CGSizeMake(100, 40));
                }];
                UIButton *plusButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
                plusButton.frame=CGRectMake(0, 5, 30, 30);
                plusButton.userInteractionEnabled=YES;
                plusButton.layer.borderWidth=0.5;
                plusButton.layer.borderColor=[UIColor red:240 green:240 blue:240 alpha:1].CGColor;
                [plusButton setTitle:@"+" forState:UIControlStateNormal];
                [plusButton setTitleColor:MCMallThemeColor forState:UIControlStateNormal];
                plusButton.titleLabel.font=[UIFont boldSystemFontOfSize:15.0];
                [plusButton addTarget:self action:@selector(didPlusButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

                plusButton.userInteractionEnabled=YES;
                
                
                UIButton *minusButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
                minusButton.frame=CGRectMake(0, 5, 30, 30);
                minusButton.userInteractionEnabled=YES;
                minusButton.layer.borderWidth=0.5;
                minusButton.layer.borderColor=[UIColor red:240 green:240 blue:240 alpha:1].CGColor;
                [minusButton setTitle:@"-" forState:UIControlStateNormal];
                [minusButton setTitleColor:MCMallThemeColor forState:UIControlStateNormal];
                minusButton.titleLabel.font=[UIFont boldSystemFontOfSize:15];
                [minusButton addTarget:self action:@selector(didMinusButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                minusButton.userInteractionEnabled=YES;
                _goodsNumTextField.rightViewMode=UITextFieldViewModeAlways;
                  _goodsNumTextField.leftViewMode=UITextFieldViewModeAlways;
                _goodsNumTextField.rightView=minusButton;
                _goodsNumTextField.leftView=plusButton;
                [_goodsNumTextField addTarget:self action:@selector(didTextFiledValueChanged:) forControlEvents:UIControlEventEditingChanged];

            }
            _goodsNumTextField.text=[NSString stringWithFormat:@"%ld",self.goodsNum];
            cell.textLabel.textAlignment=NSTextAlignmentLeft;
             cell.separatorInset=UIEdgeInsetsMake(0, 15, 0, 0);
            [((ShopCarGoodsCell *)cell).imageView sd_setImageWithURL:[NSURL URLWithString:self.goodsModel.goodsBigImageUrl] placeholderImage:MCMallDefaultImg];
            ((ShopCarGoodsCell *)cell).textLabel.text=self.goodsModel.goodsName;
            
            ((ShopCarGoodsCell *)cell).detailTextLabel.text=@" ";
        }else{
            NSString *identifer=ShopCartCommonIdentifer;
            cell=[tableView dequeueReusableCellWithIdentifier:identifer];
            if (nil==cell) {
                cell=[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifer];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                cell.textLabel.font=[UIFont systemFontOfSize:14];
                cell.textLabel.textColor=[UIColor darkGrayColor];
                cell.detailTextLabel.textColor=[UIColor blackColor];
                cell.detailTextLabel.font=[UIFont systemFontOfSize:14];
                
            }
            cell.accessoryType=UITableViewCellAccessoryNone;
            cell.detailTextLabel.textColor=[UIColor blackColor];
            switch (indexPath.row) {
                case 0:{
                    cell.textLabel.text=@"订单";
                    cell.detailTextLabel.text=@"";
                }break;
                case 2:{
                    cell.textLabel.text=@"商品金额";
                    cell.detailTextLabel.text=[NSString stringWithFormat:@"￥%.1f",self.goodsModel.vipPrice];
                }break;
                case 3:{
                    cell.textLabel.text=@"运费";
                    cell.detailTextLabel.text=@"免运费";
                }break;
                case 4:{
                    cell.textLabel.text=@"积分";
                    cell.detailTextLabel.textColor=MCMallThemeColor;
                    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                    if (self.usePoints) {
                        cell.detailTextLabel.text=[NSString stringWithFormat:@"%ld",self.usePoints];
                    }else{
                        cell.detailTextLabel.text=@"使用积分";
                    }
                }break;
                case 5:{
                    cell.textLabel.text=@"付款方式";
                    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                    if (self.payMethod) {
                        cell.detailTextLabel.text=self.payMethod;
                    }else{
                        cell.detailTextLabel.text=@"选择付款方式";
                    }
                }break;
                default:
                    break;
            }
        }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        GoodsAddressViewController *addressController=[[GoodsAddressViewController alloc]  init];
        addressController.isSelect=YES;
        addressController.delegate=self;
        [self.navigationController pushViewController:addressController animated:YES];
    }else{
        if (indexPath.row==4) {
            if (!self.userTotalPoints) {
                self.userTotalPoints=[[HHUserManager userModel] userPoint];
            }
            NSString *msg=[NSString stringWithFormat:@"您当前可用积分:%ld",self.userTotalPoints] ;
            UIAlertView *alerView=[[UIAlertView alloc]  initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alerView.alertViewStyle=UIAlertViewStylePlainTextInput;
            alerView.tag=indexPath.row;
            UITextField *textFiled=[alerView textFieldAtIndex:0];
            textFiled.keyboardType=UIKeyboardTypeNumberPad;
            alerView.tag=100;
            [alerView show];
            
        }else if (indexPath.row==5){
            UIActionSheet *actionSheet= [[UIActionSheet alloc]  initWithTitle:@"选择付款方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"现金",@"刷卡", nil];
            [actionSheet showInView:self.view];
            
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height=44;
    if (indexPath.section==0) {
        height=80;
    }else if (indexPath.section==1){
        if (indexPath.row==1) {
            height=80;
        }
    }
    return height;
}


#pragma mark
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return NO;
}
-(void )didTextFiledValueChanged:(UITextField *)textFiled{
    self.goodsNum=[textFiled.text integerValue];
}
-(void)didPlusButtonPressed:(UIButton *)sender{
    if (self.goodsNum<=self.goodsModel.storeNum) {
        self.goodsNum++;
        self.goodsNumTextField.text=[NSString stringWithFormat:@"%ld",self.goodsNum];
        [self updateTotalPrice];
    }else{
        [self.view showErrorMssage:@"库存数量不足"];
    }
}

-(void)didMinusButtonPressed:(UIButton *)sender{
    if (self.goodsNum) {
        self.goodsNum--;
       self.goodsNumTextField.text=[NSString stringWithFormat:@"%ld",self.goodsNum];
        [self updateTotalPrice];
    }
}
-(void)didSelectUserReceiveAddresss:(AddressModel *)addressModel{
    self.selectAddrsssModel=addressModel;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==100) {
        UITextField *textFiled=[alertView textFieldAtIndex:0];
        [textFiled resignFirstResponder];
        if (buttonIndex==1) {
            NSInteger point=[textFiled.text integerValue];
            if (point>self.userTotalPoints) {
                [self.view showErrorMssage:@"输入积分大于个人可用积分,请重新填写！"];
            }else{
                self.usePoints=point;
                 [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:4 inSection:1]] withRowAnimation:UITableViewRowAnimationAutomatic];
                [self updateTotalPrice];
            }
        }
    }else if (alertView.tag==2000){
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    self.payMethod=[actionSheet buttonTitleAtIndex:buttonIndex];
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:5 inSection:1]] withRowAnimation:UITableViewRowAnimationAutomatic];
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
