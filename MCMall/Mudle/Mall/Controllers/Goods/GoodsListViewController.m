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
#import "HHFlowView.h"
#import "HHClassMenuView.h"

#define HHClassMenuViewHeight  40

@interface GoodsListViewController ()<HHClassMenuViewDelegate>
@property(nonatomic,strong)NSMutableArray *catArray;
@property(nonatomic,strong)HHFlowView *flowView;
@property(nonatomic,strong)HHClassMenuView *classMenuView;
@property(nonatomic,strong)CategoryModel *selectedCatModel;
@end

@implementation GoodsListViewController
-(HHFlowView *)flowView{
    if (nil==_flowView) {
        _flowView=[[HHFlowView alloc]  initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)];
        _flowView.flowViewDidSelectedBlock=^(HHFlowModel *flowMode, NSInteger index){
            
        };
    }
    return _flowView;
}
-(HHClassMenuView *)classMenuView{
    if (nil==_classMenuView) {
        _classMenuView=[[HHClassMenuView alloc]  initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), HHClassMenuViewHeight)];
        _classMenuView.backgroundColor=[UIColor whiteColor];
        _classMenuView.menuDelegate=self;
    }
    return _classMenuView;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getDataSourse];
}
-(void)setCatArray:(NSMutableArray *)catArray{
    _catArray=catArray;
    self.classMenuView.classDataArry=[NSMutableArray arrayWithArray:_catArray];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"专享汇";
//self.tableView.tableHeaderView=self.flowView;
    [self.view addSubview:self.classMenuView];

    WEAKSELF
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
       // make.removeExisting=YES;
        make.top.mas_equalTo(HHClassMenuViewHeight);
    }];
    [self.tableView addPullToRefreshWithActionHandler:^{
        weakSelf.pageIndex=1;
        [weakSelf getGoodsListWithCatID:weakSelf.selectedCatModel.catID userID:[HHUserManager userID]];
    }];
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        weakSelf.pageIndex++;
        [weakSelf getGoodsListWithCatID:weakSelf.selectedCatModel.catID userID:[HHUserManager userID]];
    }];
    [[NSNotificationCenter defaultCenter]  addObserverForName:UserLoginSucceedNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        [weakSelf getCategoryList];
    }];
    [[NSNotificationCenter defaultCenter]  addObserverForName:UserLogoutSucceedNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        weakSelf.pageIndex=1;
        [weakSelf.catArray removeAllObjects];
        weakSelf.classMenuView.classDataArry=nil;
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
            if (!_selectedCatModel) {
                _selectedCatModel=[self.catArray firstObject];
                [self.classMenuView selectClassMenuAtIndex:0];
            }
            [self getGoodsListWithCatID:_selectedCatModel.catID userID:[HHUserManager userID]];
        }
    }
}
-(void)getCategoryList{
    [self.view showPageLoadingView];
    WEAKSELF
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine] getGoodsCategoryOnCompletionHandler:^(HHResponseResult *responseResult) {
        [weakSelf.view dismissPageLoadView];
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
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"_catID=%@",catID];
    NSArray *tempArray=[self.catArray filteredArrayUsingPredicate:predicate];
    if (tempArray&&tempArray.count) {
        _selectedCatModel=[tempArray firstObject];
    }
    if (_pageIndex==1) {
        [self.view showLoadingState];
        [self.dataSourceArray removeAllObjects];
        [self.tableView reloadData];
    }
    WEAKSELF
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine] getGoodsListWithCatID:catID userID:userID pageNum:_pageIndex pageSize:MCMallPageSize onCompletionHandler:^(HHResponseResult *responseResult) {
        
       // [weakSelf.view dismiss];
        if (responseResult.responseCode==HHResponseResultCodeSuccess) {
            [weakSelf.view dismiss];
            if (_pageIndex==1) {
                [self.dataSourceArray removeAllObjects];
            }
            if (((NSArray *)responseResult.responseData).count) {
                 [self.dataSourceArray addObjectsFromArray:responseResult.responseData];
            }else{
                [weakSelf.view makeToast:@"没有更多商品喽"];
            }
        }else{
            [weakSelf.view makeToast:responseResult.responseMessage];
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
        goodsModel1=[self.dataSourceArray objectAtIndex:(indexPath.row*2+1)];
    }
    [cell setGoodsModel0:goodsModel0 goodsModel1:goodsModel1];
    
    return cell;
}
/*
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.classMenuView;
}
 */
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
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
}
#pragma mark classMenuDelegate

-(void)classMenuSelectIndexChanded:(NSInteger)index classID:(NSString *)classID{
    _pageIndex=1;
    [self getGoodsListWithCatID:classID userID:[HHUserManager userID]];
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
