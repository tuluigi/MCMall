//
//  GoodsListViewController.m
//  MCMall
//
//  Created by Luigi on 15/8/11.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "GoodsListViewController.h"
#import "HHNetWorkEngine+Goods.h"
#import "MallGoodsListCell.h"
#import "GoodsModel.h"
#import "GoodsView.h"
#import "GoodsDetailViewController.h"
@interface GoodsListViewController ()
@property(nonatomic,strong)NSArray *catArray;
@end

@implementation GoodsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"专享汇";
    if (!self.catArray.count) {
        [self getCategoryList];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return [self.dataSourceArray count]/2+(self.dataSourceArray.count%2>0?1:0);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer=@"identifer";
    MallGoodsListCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
    if (nil==cell) {
        cell=[[MallGoodsListCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        WEAKSELF
        cell.goodsViewClickedBlock=^(GoodsModel *goodsModel){
            GoodsDetailViewController *goodDetailController=[[GoodsDetailViewController alloc]  init];
            goodDetailController.hidesBottomBarWhenPushed=YES;
            goodDetailController.goodsModel=goodsModel;
            [weakSelf.navigationController pushViewController:goodDetailController animated:YES];
        };
    }
    NSInteger row=indexPath.row;
    GoodsModel *goodsModel0=[self.dataSourceArray objectAtIndex:(row*2)];
    GoodsModel *goodsModel1;
    if ((indexPath.row+1)*2<=self.dataSourceArray.count) {
        goodsModel1=[self.dataSourceArray objectAtIndex:(indexPath.row+1)];
    }
    [cell setGoodsModel0:goodsModel0 goodsModel1:goodsModel1];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!self.cellHeight) {
        GoodsView *goodsView=[[GoodsView alloc]  init];
        goodsView.goodsModel=[self.dataSourceArray objectAtIndex:0];
        CGSize size= [goodsView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize ];
        self.cellHeight=size.height;
    }
    return self.cellHeight;
}/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
