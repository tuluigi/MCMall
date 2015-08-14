//
//  MCMallViewController.m
//  MCMall
//
//  Created by Luigi on 15/5/23.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "MCMallViewController.h"
#import "HHNetWorkEngine+Goods.h"
#import "MallListCell.h"
#import "GoodsModel.h"
#import "GoodsListViewController.h"
#import "SignUpViewController.h"
#import "HHFlowView.h"
@interface MCMallViewController ()
@property(nonatomic,strong)NSArray *catArray;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)HHFlowView *flowView;
@end

@implementation MCMallViewController
-(HHFlowView *)flowView{
    if (nil==_flowView) {
        _flowView=[[HHFlowView alloc]  initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)];
        _flowView.flowViewDidSelectedBlock=^(HHFlowModel *flowMode, NSInteger index){
            
        };
    }
    return _flowView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handTimerTask:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]  addTimer:_timer forMode:NSRunLoopCommonModes];
    // Do any additional setup after loading the view.
    self.title=@"首页";
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]  initWithTitle:@"商品列表" style:UIBarButtonItemStylePlain target:self action:@selector(didBarButtonPressed:)];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]  initWithTitle:@"签到" style:UIBarButtonItemStylePlain target:self action:@selector(didBarButtonPressed:)];
    self.tableView.tableHeaderView=self.flowView;
    if (!self.catArray.count) {
        [self getCategoryList];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)handTimerTask:(NSTimer *)timer{
    [[NSNotificationCenter defaultCenter ] postNotificationName:MCMallTimerTaskNotification object:nil userInfo:nil];
}
-(void)didBarButtonPressed:(UIBarButtonItem *)barButton{
    if (barButton ==self.navigationItem.rightBarButtonItem) {
        GoodsListViewController *goodListController=[[GoodsListViewController alloc]  init];
        goodListController.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:goodListController animated:YES];
    }else if (barButton==self.navigationItem.leftBarButtonItem){
        SignUpViewController *signupController=[[SignUpViewController alloc]  init];
        signupController.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:signupController animated:YES];
    }
   
}
-(void)getCategoryList{
    [self.view showPageLoadingView];
    WEAKSELF
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine] getGoodsCategoryOnCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCode100) {
            weakSelf.catArray=[NSArray arrayWithArray:responseResult.responseData];
            if (weakSelf.catArray.count) {
                CategoryModel *catModel=[weakSelf.catArray firstObject];
                [weakSelf getGoodsListWithCatID:catModel.catID userID:[HHUserManager userID]];
            }
        }else{
             [HHProgressHUD makeToast:responseResult.responseMessage];
        }
    }];
    [self addOperationUniqueIdentifer:op.uniqueIdentifier];
}
-(void)getGoodsListWithCatID:(NSString *)catID userID:(NSString *)userID{
    WEAKSELF
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine] getGoodsListWithCatID:catID userID:userID pageNum:_pageIndex pageSize:MCMallPageSize onCompletionHandler:^(HHResponseResult *responseResult) {
        [weakSelf.view dismissPageLoadView];
        if (responseResult.responseCode==HHResponseResultCode100) {
            if (_pageIndex==1) {
                [self.dataSourceArray removeAllObjects];
            }
            [self.dataSourceArray addObjectsFromArray:responseResult.responseData];
        }else{
            [HHProgressHUD makeToast:responseResult.responseMessage];
        }
        [weakSelf.tableView reloadData];
        [weakSelf.tableView handlerInifitScrollingWithPageIndex:&_pageIndex pageSize:MCMallPageSize totalDataCount:weakSelf.dataSourceArray.count];
    }];
    [self addOperationUniqueIdentifer:op.uniqueIdentifier];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSourceArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer=@"identifer";
    MallListCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
    if (nil==cell) {
        cell=[[MallListCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    GoodsModel *goodsModel=[self.dataSourceArray objectAtIndex:indexPath.row];
    cell.goodsModel=goodsModel;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!self.cellHeight) {
        MallListCell *cell=(MallListCell *)[tableView cellForRowAtIndexPath:0];
        if (!cell) {
            cell=[[MallListCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifer"];
            GoodsModel *goodsModel=[self.dataSourceArray objectAtIndex:indexPath.row];
            cell.goodsModel=goodsModel;
        }
        CGSize size= [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize ];
        self.cellHeight=size.height+1;
 
    }
       return self.cellHeight;
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
