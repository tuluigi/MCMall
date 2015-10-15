//
//  EditPasswordViewController.m
//  MCMall
//
//  Created by Luigi on 15/6/6.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "EditPasswordViewController.h"
#import "HHNetWorkEngine+UserCenter.h"
#import "HHTextField.h"
@interface EditPasswordViewController ()<UITextFieldDelegate>
@property(nonatomic,copy)NSString *orignalPwd,*newsPwd,*repeatNewPwd;
@end

@implementation EditPasswordViewController
-(instancetype)init{
    self=[super init];
    if (self) {
        self.tableViewStyle=UITableViewStyleGrouped;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title=@"修改密码";
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]  initWithTitle:@"确定修改" style:UIBarButtonItemStylePlain target:self action:@selector(didRightNavBarButtonPressed)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didRightNavBarButtonPressed{
    if (self.orignalPwd.length<6) {
        [self.view showErrorMssage:@"旧密码不能少于6位"];
    }else if(self.newsPwd.length<6||self.repeatNewPwd.length<6){
        [self.view showErrorMssage:@"新密码不能少于6位"];
    }else if(![self.newsPwd isEqualToString:self.repeatNewPwd]){
        [self.view showErrorMssage:@"两次输入的密码不一致"];
    }else{
        [self.view showLoadingState];
        WEAKSELF
        [[HHNetWorkEngine sharedHHNetWorkEngine]  editUserPassWordWithUserID:[HHUserManager userID] OrignalPwd:self.orignalPwd newsPwd:self.newsPwd onCompletionHandler:^(HHResponseResult *responseResult) {
            if (responseResult.responseCode==HHResponseResultCodeSuccess) {
                [weakSelf.view showSuccessMessage:@"密码修改成功"];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                [weakSelf.view showErrorMssage:responseResult.responseMessage];
            }
        }];
    }
}

#pragma mark -UITableView Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15.0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifer=@"identifer";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
    if (nil==cell) {
        cell=[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        HHTextField *textField=[[HHTextField alloc]  initWithFrame:CGRectMake(15.0, 0, CGRectGetWidth(tableView.bounds)-30.0, 44.0)];
        textField.delegate=self;
        textField.textAlignment=NSTextAlignmentLeft;
        textField.tag=1000;
        [cell.contentView addSubview:textField];
        
        UILabel *leftLable=[[UILabel alloc]  initWithFrame:CGRectMake(0, 0, 80.0, CGRectGetHeight(textField.bounds))];
        leftLable.textAlignment=NSTextAlignmentLeft;
        leftLable.font=[UIFont systemFontOfSize:16.0];
        leftLable.textColor=[UIColor blackColor];
        textField.leftView=leftLable;
        textField.leftViewMode=UITextFieldViewModeAlways;
        [textField addTarget:self action:@selector(didTextFiledValueChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    HHTextField *textField=(HHTextField *)[cell viewWithTag:1000];
    textField.indexPath=indexPath;
    UILabel *leftLable=(UILabel *)textField.leftView;
    textField.rightViewMode=UITextFieldViewModeNever;
    textField.secureTextEntry=YES;
    switch (indexPath.row) {
        case 0:{
            textField.placeholder=@"请输入旧密码";
            leftLable.text=@"旧密码";
        } break;
        case 1:{
            textField.placeholder=@"请输入至少6位密码";
            leftLable.text=@"新密码";
        }break;
        case 2:{
            textField.placeholder=@"请输入至少6位密码";
            leftLable.text=@"确认密码";
        }break;
        default:
            break;
    }
    return cell;
}
-(void)didTextFiledValueChanged:(UITextField *)textFiled{
    //get cell
    NSIndexPath *indexPath = ((HHTextField *)textFiled).indexPath;
    switch (indexPath.row) {
        case 0:{
            self.orignalPwd=textFiled.text;
        }break;
        case 1:{
            self.newsPwd=textFiled.text;
        }break;
        case 2:{
            self.repeatNewPwd=textFiled.text;
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
