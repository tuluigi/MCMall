//
//  VipHomeViewController.m
//  MCMall
//
//  Created by Luigi on 15/11/15.
//  Copyright © 2015年 Luigi. All rights reserved.
//

#import "VipHomeViewController.h"
#import "GoodsNetService.h"
#import "HHFlowView.h"
#import "VipHomeTagCell.h"
#import "LimitGoodsScrollCell.h"
#import "BradnListViewController.h"
#import "GoodsListViewController.h"
#import "GoodsDetailViewController.h"
#import "GoodsModel.h"
@interface VipHomeViewController ()<VipHomeTagCellDelegate>
@property(nonatomic,strong)HHFlowView *flowView;
@property(nonatomic,strong)NSMutableArray *limitGoodsArray;
@end

@implementation VipHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"专享汇";
    self.tableView.showsHorizontalScrollIndicator=NO;
    self.tableView.showsVerticalScrollIndicator=NO;
    self.tableView.tableHeaderView=self.flowView;
    self.tableView.backgroundColor=[UIColor red:245 green:245 blue:245 alpha:1];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self getFlowList];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(HHFlowView *)flowView{
    if (nil==_flowView) {
        _flowView=[[HHFlowView alloc]  initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200*OCCOMMONSCALE)];
        _flowView.flowViewDidSelectedBlock=^(HHFlowModel *flowMode, NSInteger index){
            
        };
    }
    return _flowView;
}
-(void)getFlowList{
    WEAKSELF
    [HHADNetService getAdvertisementListWithType:HHFlowViewTypeVipPage OnCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCodeSuccess) {
            weakSelf.flowView.dataArry=responseResult.responseData;
        }
    }];
}
-(void)getLimitGoodsList{
    WEAKSELF
    [GoodsNetService getLimitedSalesGoodsListOnCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCodeSuccess) {
            if (nil==weakSelf.limitGoodsArray) {
                weakSelf.limitGoodsArray=[[NSMutableArray alloc]  init];
            }
            if (weakSelf.limitGoodsArray.count) {
                [weakSelf.limitGoodsArray removeAllObjects];
            }
            [weakSelf.limitGoodsArray addObjectsFromArray:responseResult.responseData];
        }
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        UITableViewCell *cell=[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"tableviewcell01"];
        cell.textLabel.text=@"每日限时抢购";
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row==1){
        LimitGoodsScrollCell *cell=[[LimitGoodsScrollCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"limitiCelll1"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        VipHomeTagCell *cell=[[VipHomeTagCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"vipHomeCell02"];
        cell.delegate=self;
         cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height=44;
    if (indexPath.row==0) {
        height=30;
    }else if (indexPath.row==1){
        height=180;
    }else{
        height=[VipHomeTagCell vipHomeCellHeight];
    }
    return height;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        
    }else if (indexPath.row==1){
        GoodsDetailViewController *detailController=[[GoodsDetailViewController alloc]  init];
        LimitGoodsScrollCell *cell=(LimitGoodsScrollCell *)[tableView cellForRowAtIndexPath:indexPath];
        GoodsModel *goodsModel=[cell goodsModel];
        detailController.goodsID=goodsModel.goodsID;
        detailController.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:detailController animated:YES];
    }
}
#pragma mark -vipTagCell delegate
-(void)didSelectItemWithTag:(MCVipGoodsItemTag)itemTag{
    
    if (itemTag==MCVipGoodsItemTagGroupMother||itemTag==MCVipGoodsItemTagGroupDiscountGoods) {
        BradnListViewController *brandListController=[[BradnListViewController alloc]  init];
        brandListController.goodsItemTag=itemTag;
        brandListController.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:brandListController animated:YES];
    }else if (itemTag==MCVipGoodsItemTagImmediatelySend||itemTag==MCVipGoodsItemTagTimeLimitedSales){
        GoodsListViewController *goodsListController=[[GoodsListViewController alloc]  init];
        goodsListController.vipGoodsItemTag=itemTag;
        goodsListController.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:goodsListController animated:YES];
    }
   }
@end
