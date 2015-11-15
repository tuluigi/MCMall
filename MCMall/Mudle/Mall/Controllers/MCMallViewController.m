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
#import "HHNetWorkEngine+AD.h"

#define McMallCellIdenfier  @"McMallCellIdenfier"
#define MCMallAdvertismentListKey   @"MCMallAdvertismentListKey"
#define MCMallHomeGoodsListKey   @"MCMallHomeGoodsListKey"
@interface MCMallViewController ()<UIActionSheetDelegate>
@property(nonatomic,strong)__block NSMutableArray *catArray,*adArray;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)HHFlowView *flowView;
@end

@implementation MCMallViewController
-(HHFlowView *)flowView{
    if (nil==_flowView) {
        _flowView=[[HHFlowView alloc]  initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200*OCCOMMONSCALE)];
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
    self.navigationItem.title=[[HHAppInfo appName] stringByAppendingString:@"会员服务系统"];
    
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[MallListCell class] forCellReuseIdentifier:McMallCellIdenfier];
    self.tableView.tableHeaderView=self.flowView;
    [self getCategoryList];
    [self getFllowDateList];
    WEAKSELF
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf getGoodsListWithCatID:@"" userID:[HHUserManager userID]];
    }];
    
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

-(void)getFllowDateList{
    WEAKSELF
    /*
    NSData *adListDate=[[NSUserDefaults standardUserDefaults]  objectForKey:MCMallAdvertismentListKey];
    self.adArray=[NSKeyedUnarchiver unarchiveObjectWithData:adListDate];
    [[HHNetWorkEngine sharedHHNetWorkEngine] getAdvertisementListOnCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCodeSuccess) {
            weakSelf.adArray=responseResult.responseData;
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSData *adData=[NSKeyedArchiver archivedDataWithRootObject:weakSelf.adArray];
                [[NSUserDefaults standardUserDefaults] setObject:adData forKey:MCMallAdvertismentListKey];
            });
            
        }
    }];
     */
    [HHADNetService getAdvertisementListWithType:HHFlowViewTypeHomePage OnCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCodeSuccess) {
            weakSelf.adArray=responseResult.responseData;
        }
    }];
}
-(void)setAdArray:(NSMutableArray *)adArray{
    if (adArray) {
        _adArray=adArray;
        self.flowView.dataArry=_adArray;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getDataSourse{
    if (self.dataSourceArray.count==0) {
        [self getGoodsListWithCatID:@"" userID:[HHUserManager userID]];
    }
}



-(void)getCategoryList{
    [self getGoodsListWithCatID:@"" userID:[HHUserManager userID]];
    /*
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
     */
}
-(void)getGoodsListWithCatID:(NSString *)catID userID:(NSString *)userID{
    WEAKSELF
    if (self.pageIndex==1&&self.dataSourceArray.count==0) {
        NSData *adListDate=[[NSUserDefaults standardUserDefaults]  objectForKey:MCMallHomeGoodsListKey];
        NSArray *array=[NSKeyedUnarchiver unarchiveObjectWithData:adListDate];
        self.dataSourceArray=[NSMutableArray arrayWithArray:array];
        [self.tableView reloadData];
    }
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine] getGoodsListWithCatID:catID userID:userID pageNum:_pageIndex pageSize:MCMallPageSize onCompletionHandler:^(HHResponseResult *responseResult) {
        [weakSelf.view dismissPageLoadView];
        if (responseResult.responseCode==HHResponseResultCodeSuccess) {
            if (_pageIndex==1) {
                [self.dataSourceArray removeAllObjects];
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    NSData *adData=[NSKeyedArchiver archivedDataWithRootObject:responseResult.responseData];
                    [[NSUserDefaults standardUserDefaults] setObject:adData forKey:MCMallHomeGoodsListKey];
                });

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
    MallListCell *cell=[tableView dequeueReusableCellWithIdentifier:McMallCellIdenfier forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
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
    WEAKSELF
    contentView.itemTouchedBlock=^(HomeMenuViewItem item){
        if ([HHUserManager isLogin]) {
            if (item==HomeMenuViewItemSign) {
                SignUpViewController *signupController=[[SignUpViewController alloc]  init];
                signupController.hidesBottomBarWhenPushed=YES;
                [weakSelf.navigationController pushViewController:signupController animated:YES];
                
            }else if (item==HomeMenuViewItemGoods){
                UIActionSheet *actionSheet=[[UIActionSheet alloc]  initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"安健卫士" otherButtonTitles:@"防丢神奇", nil];
                [actionSheet showInView:self.view];
            }else if (item==HomeMenuViewItemDiary){
                MotherDiaryViewController *diraryController=[[MotherDiaryViewController alloc]  init];
                diraryController.hidesBottomBarWhenPushed=YES;
                [weakSelf.navigationController pushViewController:diraryController animated:YES];
            }
            
        }else{
            [HHUserManager shouldUserLoginOnCompletionBlock:^(BOOL isSucceed, NSString *userID) {
                if (isSucceed) {
                    
                }
            }];
        }
    };
    return contentView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    __block GoodsModel *goodsModel=[self.dataSourceArray objectAtIndex:indexPath.row];
    CGFloat height=[tableView fd_heightForCellWithIdentifier:McMallCellIdenfier cacheByIndexPath:indexPath  configuration:^(id cell) {
        ((MallListCell *)cell).goodsModel=goodsModel;
    }];
    
    return height;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodsModel *goodsModel=[self.dataSourceArray objectAtIndex:indexPath.row];
    GoodsDetailViewController *goodsDetailController=[[GoodsDetailViewController alloc]  init];
    goodsDetailController.goodsID=goodsModel.goodsID;
    goodsDetailController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:goodsDetailController animated:YES];
}
#pragma mark - actionSheetDeleget
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
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
