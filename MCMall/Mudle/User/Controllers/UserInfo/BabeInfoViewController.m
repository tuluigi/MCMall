//
//  BabeInfoViewController.m
//  MCMall
//
//  Created by Luigi on 15/8/8.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "BabeInfoViewController.h"
#import "HHNetWorkEngine+UserCenter.h"
@interface BabeInfoViewController ()<UIAlertViewDelegate,UIActionSheetDelegate>
@property(nonatomic,strong)BabeModel *babeModel;
@property(nonatomic,strong)UIDatePicker *dataPicker;
@property(nonatomic,strong)UIView *pickView;
@property (nonatomic, strong) MASConstraint *pickViewHeightConstraint;
@end

@implementation BabeInfoViewController
-(UIView *)pickView{
    if (nil==_pickView) {
        _pickView=[[UIView alloc]  init];
        [_pickView addSubview:self.dataPicker];
        
        UIToolbar *pickerToolbar = [[UIToolbar alloc] init];
        pickerToolbar.backgroundColor=[UIColor red:240 green:240 blue:240 alpha:1];
        pickerToolbar.barStyle = UIBarStyleDefault;
        [pickerToolbar sizeToFit];
        NSMutableArray *barItems = [[NSMutableArray alloc] init];
        
        UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc]
                                      
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed:)];
        [barItems addObject:cancelBtn];
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        [barItems addObject:flexSpace];
        UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc]
                                    
                                    initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed:)];
        [barItems addObject:doneBtn];
        [pickerToolbar setItems:barItems animated:YES];
        [_pickView addSubview:pickerToolbar];
        
        
        
        [pickerToolbar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(_pickView);
            make.height.equalTo(@(40));
        }];
        
        [_dataPicker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(pickerToolbar.mas_bottom);
            make.left.right.bottom.equalTo(_pickView);
        }];
    }
    return _pickView;
}
-(UIDatePicker *)dataPicker{
    if (nil==_dataPicker) {
        _dataPicker = [[UIDatePicker alloc] init];
        _dataPicker.datePickerMode = UIDatePickerModeDate;
        _dataPicker.hidden = NO;
        _dataPicker.minimumDate = [[NSDate alloc]  initWithTimeIntervalSince1970:0];
        _dataPicker.maximumDate= [NSDate date];
        //响应日期选择事件，自定义dateChanged方法
        [ _dataPicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
        
    }
    return _dataPicker;
}
-(BabeModel *)babeModel{
    if (nil==_babeModel) {
        _babeModel=[[BabeModel alloc]  init];
    }
    return _babeModel;
}
-(void)dateChanged:(UIDatePicker *)sender{
    NSDate*date= sender.date;
    self.babeModel.birthday=date;
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
}
-(void)doneButtonPressed:(UIBarButtonItem *)sender{
    WEAKSELF
    [UIView animateWithDuration:0.2 animations:^{
        [weakSelf.pickView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.view).offset(300);
        }];
        [weakSelf.pickView layoutIfNeeded];
        NSDate*date= weakSelf.dataPicker.date;
        weakSelf.babeModel.birthday=date;
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    return;
}
-(void)cancelButtonPressed:(UIBarButtonItem *)sender{
    WEAKSELF
    [UIView animateWithDuration:0.2 animations:^{
        [weakSelf.pickView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.view).offset(300);
        }];
        [weakSelf.pickView layoutIfNeeded];
    }];
    return;
    
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title=@"宝宝信息";
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]  initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonPressed)];
    [self.view addSubview:self.pickView];
    if (self.isFromStateSelcted) {
        [self.navigationItem setHidesBackButton:YES animated:YES];
    }
    WEAKSELF
    [self.pickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view).offset(300);
    }];
    if (!self.isFromStateSelcted) {
       [self getUserInfo];
    }
    
}
#pragma mark- getuserinfo
-(void)rightBarButtonPressed{
    WEAKSELF
    [weakSelf.view showLoadingState];
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine]  editBabeInfoWithUserID:[HHUserManager userID] birthday:[self.babeModel.birthday convertDateToStringWithFormat:@"yyyy-MM-dd"] bigNickName:self.babeModel.bigNickName smallNickeName:self.babeModel.smallNickName gender:self.babeModel.gender onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCodeSuccess) {
            if (weakSelf.isFromStateSelcted) {
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
                 [weakSelf.navigationController popViewControllerAnimated:YES];
            }
           
            [weakSelf.view dismissHUD];
        }else{
            [weakSelf.view showErrorMssage:responseResult.responseMessage];
        }
    }];
    [self addOperationUniqueIdentifer:op.uniqueIdentifier];
}
-(void)getUserInfo{
    WEAKSELF
    [weakSelf.view showLoadingState];
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine]  getBabeInfoWithUserID:[HHUserManager userID] onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCodeSuccess) {
            weakSelf.babeModel=responseResult.responseData;
            [weakSelf.tableView reloadData];
            [weakSelf.view dismissHUD];
        }else{
            [weakSelf.view showErrorMssage:responseResult.responseMessage];
        }
    }];
    [self addOperationUniqueIdentifer:op.uniqueIdentifier];
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
            if (self.babeModel.birthday) {
                cell.detailTextLabel.text=[self.babeModel.birthday convertDateToStringWithFormat:@"yyyy-MM-dd"];
            }else{
                cell.detailTextLabel.text=@"";
            }
            
        }break;
        case 1:{
            cell.textLabel.text=@"大名";
            cell.detailTextLabel.text=self.babeModel.bigNickName;
        }break;
        case 2:{
            cell.textLabel.text=@"小名";
            cell.detailTextLabel.text=self.babeModel.smallNickName;
        }break;
        case 3:{
            cell.textLabel.text=@"性别";
            cell.detailTextLabel.text=self.babeModel.gender;
            
        }break;
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
    if (self.pickView.frame.origin.y==self.view.frame.size.height-self.pickView.frame.size.height) {
        WEAKSELF
        [UIView animateWithDuration:0.2 animations:^{
            [weakSelf.pickView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(weakSelf.view).offset(300);
            }];
            [weakSelf.pickView layoutIfNeeded];
        }];
        
    }
    switch (indexPath.row) {
        case 0:{
            WEAKSELF
            [UIView animateWithDuration:0.2 animations:^{
                [weakSelf.pickView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(weakSelf.view);
                }];
                if (weakSelf.babeModel.birthday) {
                    [weakSelf.dataPicker setDate:weakSelf.babeModel.birthday animated:YES];
                }
                [weakSelf.pickView layoutIfNeeded];
            }];
            return;
        }break;
        case 1:{
            titleStr=@"修改大名";
            messageStr=self.babeModel.bigNickName;
        }break;
        case 2:{
            titleStr=@"修改小名";
            messageStr=self.babeModel.smallNickName;
        }break;
        case 3:{
            UIActionSheet *actionSheet= [[UIActionSheet alloc]  initWithTitle:@"性别" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
            [actionSheet showInView:self.view];
            return;
        }break;
        default:
            break;
    }
    
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
    
    if (alertView.tag==1) {
        if ([self.babeModel.bigNickName isEqualToString:textFiled.text]) {
            return;
        }
        self.babeModel.bigNickName=textFiled.text;
    }else if (alertView.tag==2){
        if ([self.babeModel.smallNickName isEqualToString:textFiled.text]) {
            return;
        }
        self.babeModel.smallNickName=textFiled.text;
    }
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:alertView.tag inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([self.babeModel.gender isEqualToString:[actionSheet buttonTitleAtIndex:buttonIndex]]) {
        return;
    }
    self.babeModel.gender=[actionSheet buttonTitleAtIndex:buttonIndex];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}
@end
