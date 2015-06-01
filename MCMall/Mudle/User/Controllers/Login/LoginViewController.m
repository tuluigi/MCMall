//
//  LoginViewController.m
//  MCMall
//
//  Created by Luigi on 15/5/26.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property(nonatomic,strong)UIView *headerView,*footView;
@end

@implementation LoginViewController
-(UIView *)headerView{
    if (nil==_headerView) {
        _headerView=[[UIView alloc]  initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)];
        UIImageView *logoImgView=[[UIImageView alloc]  initWithImage:[UIImage imageNamed:@"loading_Default"]];
        [_headerView addSubview:logoImgView];
        [logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_headerView);
            make.size.mas_equalTo(CGSizeMake(100.0, 100.0));
        }];
    }
    return _headerView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self onInitData];
}
-(void)onInitData{
    self.title=@"知婴知孕";
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]  initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(leftNavigationItemClicked)];
    self.tableView.tableHeaderView=self.headerView;
    [self.tableView reloadData];
    self.tableView.tableFooterView=[UIView new];
}
#pragma mark -button
-(void)leftNavigationItemClicked{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -UITableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer=@"cellIdentifer";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
    if (nil==cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifer];
    }
    switch (indexPath.row) {
        case 0:{
            cell.textLabel.text=@"欢迎您!";
            cell.detailTextLabel.text=@"xxxx";
        }break;
        case 1:{
            cell.textLabel.text=@"账户余额:";
            cell.detailTextLabel.text=@"xxxx";
        }break;
        case 2:{
            cell.textLabel.text=@"所属门店:";
            cell.detailTextLabel.text=@"xxxx";
        }break;
        case 3:{
            cell.textLabel.text=@"手机号:";
            cell.detailTextLabel.text=@"xxxx";
        }break;
            
        default:
            break;
    }
    return cell;
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
