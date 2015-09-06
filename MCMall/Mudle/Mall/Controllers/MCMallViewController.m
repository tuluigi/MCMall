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
#import "HomeMenuContentView.h"
#import "MotherDiaryViewController.h"
#import "GoodsDetailViewController.h"
@interface MCMallViewController ()
@property(nonatomic,strong)NSMutableArray *catArray;
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
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getDataSourse];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    _timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handTimerTask:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]  addTimer:_timer forMode:NSRunLoopCommonModes];
    // Do any additional setup after loading the view.
    self.title=@"首页";
   
    self.tableView.tableHeaderView=self.flowView;
    [self getCategoryList];
    WEAKSELF
    [[NSNotificationCenter defaultCenter]  addObserverForName:UserLoginSucceedNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        [weakSelf getCategoryList];
    }];
    [[NSNotificationCenter defaultCenter]  addObserverForName:UserLogoutSucceedNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        weakSelf.pageIndex=1;
        [weakSelf.catArray removeAllObjects];
        [weakSelf.dataSourceArray removeAllObjects];
        [weakSelf.tableView reloadData];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getDataSourse{
    if (self.catArray.count==0) {
        [self getCategoryList];
    }else{
        if (self.dataSourceArray.count==0) {
            CategoryModel *catModel=[self.catArray firstObject];
            [self getGoodsListWithCatID:catModel.catID userID:[HHUserManager userID]];
        }
    }
}

-(void)handTimerTask:(NSTimer *)timer{
    [[NSNotificationCenter defaultCenter ] postNotificationName:MCMallTimerTaskNotification object:nil userInfo:nil];
}

-(void)getCategoryList{
   [self.view showPageLoadingView];
    WEAKSELF
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine] getGoodsCategoryOnCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCodeSuccess) {
            weakSelf.catArray=[NSMutableArray arrayWithArray:responseResult.responseData];
            if (weakSelf.catArray.count) {
                CategoryModel *catModel=[weakSelf.catArray firstObject];
                [weakSelf getGoodsListWithCatID:catModel.catID userID:[HHUserManager userID]];
            }
        }else{
             [weakSelf.view makeToast:responseResult.responseMessage];
        }
    }];
    [self addOperationUniqueIdentifer:op.uniqueIdentifier];
}
-(void)getGoodsListWithCatID:(NSString *)catID userID:(NSString *)userID{
    WEAKSELF
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine] getGoodsListWithCatID:catID userID:userID pageNum:_pageIndex pageSize:MCMallPageSize onCompletionHandler:^(HHResponseResult *responseResult) {
       [weakSelf.view dismissPageLoadView];
        if (responseResult.responseCode==HHResponseResultCodeSuccess) {
            if (_pageIndex==1) {
                [self.dataSourceArray removeAllObjects];
            }
            [self.dataSourceArray addObjectsFromArray:responseResult.responseData];
        }else{
            [weakSelf.view makeToast:responseResult.responseMessage];
        }
        
        [weakSelf.tableView handlerInifitScrollingWithPageIndex:&_pageIndex pageSize:MCMallPageSize totalDataCount:weakSelf.dataSourceArray.count];
        [weakSelf.tableView reloadData];
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
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HomeMenuContentView *contentView=[[HomeMenuContentView alloc]  initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 60)];
    contentView.itemTouchedBlock=^(HomeMenuViewItem item){
        if (item==HomeMenuViewItemSign) {
            SignUpViewController *signupController=[[SignUpViewController alloc]  init];
            signupController.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:signupController animated:YES];

        }else if (item==HomeMenuViewItemGoods){
            GoodsListViewController *goodListController=[[GoodsListViewController alloc]  init];
            goodListController.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:goodListController animated:YES];
        }else if (item==HomeMenuViewItemDiary){
            MotherDiaryViewController *diraryController=[[MotherDiaryViewController alloc]  init];
            diraryController.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:diraryController animated:YES];
        }
    };
    return contentView;
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 GoodsModel *goodsModel=[self.dataSourceArray objectAtIndex:indexPath.row];
    GoodsDetailViewController *goodsDetailController=[[GoodsDetailViewController alloc]  init];
    goodsDetailController.goodsModel=goodsModel;
    goodsDetailController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:goodsDetailController animated:YES];
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
