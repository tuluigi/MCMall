//
//  ActivityViewController.m
//  MCMall
//
//  Created by Luigi on 15/5/23.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "ActivityViewController.h"
#import "HHNetWorkEngine+Activity.h"
@interface ActivityViewController ()

@end

@implementation ActivityViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self getActivityListWithPageNum:1 pageSize:10];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getActivityListWithPageNum:(NSInteger)num pageSize:(NSInteger)size{
    WEAKSELF
    [[HHNetWorkEngine sharedHHNetWorkEngine]  getActivityListWithPageNum:num pageSize:size onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCode100) {
            if (num==1) {
                [weakSelf.dataArray removeAllObjects];
                [weakSelf.dataArray addObjectsFromArray:responseResult.responseData];
            }else{
                [weakSelf.dataArray addObjectsFromArray:responseResult.responseData];
            }
            [weakSelf.tableView reloadData];
        }else{
        
        }
    }];

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *idenfierStr=@"idenfierStr";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:idenfierStr];
    if (nil==cell) {
        cell=[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenfierStr];
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
