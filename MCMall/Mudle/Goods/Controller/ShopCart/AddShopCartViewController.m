//
//  AddShopCartViewController.m
//  MCMall
//
//  Created by Luigi on 15/9/25.
//  Copyright © 2015年 Luigi. All rights reserved.
//

#import "AddShopCartViewController.h"

@interface AddShopCartViewController ()

@end

@implementation AddShopCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"兑换";
    UIBarButtonItem *titleBarButton=[[UIBarButtonItem alloc]  initWithTitle:@" 应付金额: " style:UIBarButtonItemStylePlain target:nil action:NULL];
    UIBarButtonItem *moneyBarButton=[[UIBarButtonItem alloc]  initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:NULL];
    
    UIButton *bookButton=[UIButton buttonWithType:UIButtonTypeCustom];
    bookButton.frame=CGRectMake(0, 0, 100, 35);
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
    [self.navigationController.toolbar setItems:bartItems];
    // Do any additional setup after  the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)didBookButtonPressed{
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else{
        return 5;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifer=@"identifer0";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
    if (nil==cell) {
        cell=[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifer];
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
