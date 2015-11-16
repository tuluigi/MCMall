//
//  GoodsListViewController.m
//  MCMall
//
//  Created by Luigi on 15/8/11.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "GoodsListViewController.h"
#import "HHNetWorkEngine+Goods.h"
#import "GoodsModel.h"
#import "GoodsDetailViewController.h"
#import "HHClassMenuView.h"
#import "GoodsCollectionViewCell.h"
#import "GoodsNetService.h"
#define HHClassMenuViewHeight  40
#define kCollectionViewColum  2
#define     kGoodsCollectionCellIdedtifer   @"kGoodsCollectionCellIdedtifer"
@interface GoodsListViewController ()<HHClassMenuViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>{
 __block  NSUInteger _pageIndex;
}
@property(nonatomic,strong)NSMutableArray *catArray,*dataSourceArray;
@property(nonatomic,strong)HHClassMenuView *classMenuView;
@property(nonatomic,strong)CategoryModel *selectedCatModel;
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,assign)__block NSUInteger pageIndex;
@property(nonatomic,assign)CGFloat cellHeight;

@end

@implementation GoodsListViewController

-(NSMutableArray *)dataSourceArray{
    if (nil==_dataSourceArray) {
        _dataSourceArray=[NSMutableArray new];
    }
    return _dataSourceArray;
}
-(HHClassMenuView *)classMenuView{
    if (nil==_classMenuView) {
        _classMenuView=[[HHClassMenuView alloc]  initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), HHClassMenuViewHeight)];
        _classMenuView.backgroundColor=[UIColor whiteColor];
        _classMenuView.menuDelegate=self;
    }
    return _classMenuView;
}
-(UICollectionView *)collectionView{
    if (nil==_collectionView) {
        UICollectionViewFlowLayout *collectionViewLayout=[[UICollectionViewFlowLayout alloc] init];
        
        _collectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:collectionViewLayout];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        
        [_collectionView registerClass:[GoodsCollectionViewCell class] forCellWithReuseIdentifier:kGoodsCollectionCellIdedtifer];
        [_collectionView reloadData];
        _collectionView.backgroundColor=[UIColor clearColor];
    }
    return _collectionView;
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
    self.pageIndex=1;
//self.tableView.tableHeaderView=self.flowView;
    [self.view addSubview:self.classMenuView];
    [self.view addSubview:self.collectionView];
    WEAKSELF
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       // make.removeExisting=YES;
        make.top.mas_equalTo(HHClassMenuViewHeight);
        make.left.right.bottom.mas_equalTo(weakSelf.view);
    }];
    [self.collectionView addPullToRefreshWithActionHandler:^{
        weakSelf.pageIndex=1;
        [weakSelf getGoodsListWithCatID:weakSelf.selectedCatModel.catID userID:[HHUserManager userID]];
    }];
    [self.collectionView addInfiniteScrollingWithActionHandler:^{
//        weakSelf.pageIndex++;
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
        [weakSelf.collectionView reloadData];
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
    /*
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"_catID=%@",catID];
    NSArray *tempArray=[self.catArray filteredArrayUsingPredicate:predicate];
    if (tempArray&&tempArray.count) {
        _selectedCatModel=[tempArray firstObject];
    }
    if (_pageIndex==1) {
        [self.view showLoadingState];
        [self.dataSourceArray removeAllObjects];
        [self.collectionView reloadData];
    }
    WEAKSELF
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine] getGoodsListWithCatID:catID userID:userID pageNum:_pageIndex pageSize:MCMallPageSize onCompletionHandler:^(HHResponseResult *responseResult) {
        
       // [weakSelf.view dismissHUD];
        if (responseResult.responseCode==HHResponseResultCodeSuccess) {
            [weakSelf.view dismissHUD];
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
        [weakSelf.collectionView reloadData];
        [weakSelf.collectionView handlerInifitScrollingWithPageIndex:&_pageIndex pageSize:MCMallPageSize totalDataCount:weakSelf.dataSourceArray.count];
    }];
    [self addOperationUniqueIdentifer:op.uniqueIdentifier];
     */
    if (self.dataSourceArray.count==0) {
        [self.collectionView showPageLoadingView];
    }
    WEAKSELF
    HHNetWorkOperation *op=[GoodsNetService getNewGoodsListWithTag:self.vipGoodsItemTag CatID:catID brandID:self.brandID pageNum:self.pageIndex pageSize:MCMallPageSize onCompletionHandler:^(HHResponseResult *responseResult) {
        [weakSelf.collectionView dismissPageLoadView];
        if (responseResult.responseCode==HHResponseResultCodeSuccess) {
            [weakSelf.view dismissHUD];
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
        [weakSelf.collectionView reloadData];
        [weakSelf.collectionView handlerInifitScrollingWithPageIndex:&_pageIndex pageSize:MCMallPageSize totalDataCount:weakSelf.dataSourceArray.count];
    } ];
    [self addOperationUniqueIdentifer:op.uniqueIdentifier];
}

#pragma mark- collectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger row=self.dataSourceArray.count;
    return row;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GoodsCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:kGoodsCollectionCellIdedtifer forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    cell.goodsModel=[self.dataSourceArray objectAtIndex:indexPath.row];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat width=(CGRectGetWidth([[UIScreen mainScreen] bounds])/kCollectionViewColum);
    if (!self.cellHeight) {
//        GoodsView *goodsView=[[GoodsView alloc]  init];
//        goodsView.goodsModel=[self.dataSourceArray objectAtIndex:0];
//        CGSize size= [goodsView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize ];
//        self.cellHeight=size.height;
        //cell高度计算
        self.cellHeight=338.0;
    }
    return CGSizeMake(width, self.cellHeight);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}

 - (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
 return 0;
 }
 - (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
 return 0;
 }

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GoodsModel *goodsModel=[self.dataSourceArray objectAtIndex:indexPath.row];
    GoodsDetailViewController *goodDetailController=[[GoodsDetailViewController alloc]  init];
    goodDetailController.hidesBottomBarWhenPushed=YES;
    goodDetailController.goodsID=goodsModel.goodsID;
    [self.navigationController pushViewController:goodDetailController animated:YES];
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
