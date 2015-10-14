//
//  GoodsDetailViewController.m
//  MCMall
//
//  Created by Luigi on 15/8/11.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "HHNetWorkEngine+Goods.h"
#import "GoodsModel.h"
#import "HHPhotoBroswer.h"
#import "NSString+MCHtml.h"
#import "AddShopCartViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "GoodsDetailPriceCell.h"
#define GoodsDetialCommonCellIdentifer  @"GoodsDetialCommonCellIdentifer"
#define GoodsDetialPriceCellIdentifer  @"GoodsDetialPriceCellIdentifer"
@interface GoodsDetailViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIImageView *goodsImageView;
@property(nonatomic,strong)UIToolbar *tooBar;
@property(nonatomic,strong)UIWebView *footWebView;
@property(nonatomic,strong)__block GoodsModel *goodsModel;
@end

@implementation GoodsDetailViewController
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(UIImageView *)goodsImageView{
    if (nil==_goodsImageView) {
        _goodsImageView=[[UIImageView alloc]  initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)];
        _goodsImageView.contentMode=UIViewContentModeScaleAspectFill;
        _goodsImageView.clipsToBounds=YES;
        _goodsImageView.userInteractionEnabled=YES;
        NSString *imageUrl=_goodsModel.goodsBigImageUrl;
        if (imageUrl==nil) {
            imageUrl=_goodsModel.goodsImageUrl;
        }
       
        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]  initWithTarget:self action:@selector(handleGoodsImageViewTaped:)];
        
        [_goodsImageView addGestureRecognizer:tapGesture];
    }
    return _goodsImageView;
}
-(void)handleGoodsImageViewTaped:(UITapGestureRecognizer *)tap{
    [[HHPhotoBroswer sharedPhotoBroswer] showBrowserWithImages:[NSArray arrayWithObject:_goodsModel.goodsBigImageUrl] atIndex:0];
}
-(UIToolbar *)tooBar{
    if (nil==_tooBar) {
        _tooBar=[[UIToolbar alloc]  init];
        _tooBar.barStyle=UIBarStyleDefault;
//        UIBarButtonItem *collectBarButton=[[UIBarButtonItem alloc] initWithTitle:@"收藏" style:UIBarButtonItemStylePlain target:self action:@selector(handlerBarButtonClicked:)];
//        collectBarButton.tag=100;
        UIBarButtonItem *spaceBarButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        spaceBarButton.tag=101;
//        UIBarButtonItem *fixSpaceBarButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
//        fixSpaceBarButton.width=30;
        UIButton *bookButton=[UIButton buttonWithType:UIButtonTypeCustom];
        bookButton.frame=CGRectMake(0, 0, 180, 35);
        bookButton.tag=102;
        [bookButton setTitle:@"我要兑换" forState:UIControlStateNormal];
        [bookButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        bookButton.backgroundColor=MCMallThemeColor;
        bookButton.layer.cornerRadius=4;
        bookButton.layer.masksToBounds=YES;
        [bookButton addTarget:self action:@selector(handlerBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *bookBarButton=[[UIBarButtonItem alloc] initWithCustomView:bookButton];
        
        _tooBar.items=@[spaceBarButton,bookBarButton,spaceBarButton];
    }
    return _tooBar;
}
-(void)handlerBarButtonClicked:(id)sender{
    if ([sender isKindOfClass:[UIBarButtonItem class]]) {
        UIBarButtonItem *buttonItem=(UIBarButtonItem *)sender;
        if ([buttonItem tag]==100) {
            
        }
    }else if ([sender isKindOfClass:[UIButton class]]){//预订
        UIButton *button=(UIButton *)sender;
        if (button.tag==102) {
            if ([HHUserManager isLogin]&&self.goodsModel) {
                AddShopCartViewController *addShopCarController=[[AddShopCartViewController alloc]  initWithStyle:UITableViewStyleGrouped];
                addShopCarController.goodsModel=self.goodsModel;
                [self.navigationController pushViewController:addShopCarController animated:YES];
            }else{
                [HHUserManager shouldUserLoginOnCompletionBlock:^(BOOL isSucceed, NSString *userID) {
                    if (isSucceed) {
                        
                    }
                }];
            }
        }
    }
}
-(UIWebView *)footWebView{
    if (nil==_footWebView) {
        _footWebView=[[UIWebView alloc]  initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 150)];
        _footWebView.delegate=self;
    }
    return _footWebView;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    [self getGoodsDetailWithGoodsID:self.goodsID];
    self.title=@"商品详情";
    [self.view addSubview:self.tooBar];
    self.tooBar.hidden=YES;
   
    
    WEAKSELF
    [self.tooBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(weakSelf.view );
        make.height.mas_equalTo(50);
    }];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.removeExisting=YES;
        make.top.left.right.mas_equalTo(weakSelf.view);
        make.bottom.mas_equalTo(weakSelf.tooBar.mas_top);
    }];
    [[NSNotificationCenter defaultCenter] addObserverForName:MCMallTimerTaskNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        
        [weakSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0] ] withRowAnimation:UITableViewRowAnimationNone];
    }];
    
}
-(void)getGoodsDetailWithGoodsID:(NSString *)goodsID{
    [self.view showPageLoadingView];
    WEAKSELF
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine] getGoodsDetailWithGoodsID:goodsID userID:[HHUserManager userID] onCompletionHandler:^(HHResponseResult *responseResult) {
        [weakSelf.view dismissPageLoadView];
        weakSelf.tooBar.hidden=NO;
        if (responseResult.responseCode==HHResponseResultCodeSuccess) {
            weakSelf.goodsModel=((GoodsModel *)responseResult.responseData);
            weakSelf.goodsModel.goodsID=goodsID;
            UIImage *image=[[SDImageCache sharedImageCache]  imageFromDiskCacheForKey:weakSelf.goodsModel.goodsBigImageUrl];
            if (image) {
                CGSize size=image.size;
                CGFloat scale=CGRectGetWidth(weakSelf.goodsImageView.bounds)/size.width;
                CGFloat height=size.height;
                if (scale<1) {
                    height=size.height*scale;
                }
                weakSelf.goodsImageView.frame=CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), height);
            }
            weakSelf.tableView.tableHeaderView=self.goodsImageView;
             [weakSelf.goodsImageView sd_setImageWithURL:[NSURL URLWithString:weakSelf.goodsModel.goodsBigImageUrl] placeholderImage:MCMallDefaultImg];
            [weakSelf.footWebView loadHTMLString:_goodsModel.goodsDetail baseURL:nil];
            [weakSelf.tableView reloadData];
        }else{
            [weakSelf.view showPageLoadedMessage:responseResult.responseMessage delegate:nil];
        }
    }];
    [self addOperationUniqueIdentifer:op.uniqueIdentifier];
}

#pragma mark-tableview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if (indexPath.row==1) {
       cell=(GoodsDetailPriceCell *)[tableView dequeueReusableCellWithIdentifier:GoodsDetialPriceCellIdentifer];
        if (nil==cell) {
            cell=[[GoodsDetailPriceCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GoodsDetialPriceCellIdentifer];
        }
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [(GoodsDetailPriceCell *)cell setOrignalPrice:self.goodsModel.orignalPrice sellPrice:self.goodsModel.sellPrice vipPrice:self.goodsModel.vipPrice goodsPoints:self.goodsModel.goodsPoints endTime:self.goodsModel.endTime storeNum:self.goodsModel.storeNum];
    }else{
        cell=[tableView dequeueReusableCellWithIdentifier:GoodsDetialCommonCellIdentifer];
        if (nil==cell) {
            cell=[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:GoodsDetialCommonCellIdentifer];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.detailTextLabel.font=[UIFont systemFontOfSize:14];
        cell.textLabel.textColor=MCMallThemeColor;
        cell.detailTextLabel.numberOfLines=0;
        if (indexPath.row==0) {
            cell.textLabel.numberOfLines=2;
            cell.textLabel.textAlignment=NSTextAlignmentCenter;
            cell.textLabel.font=[UIFont systemFontOfSize:14];
            
            cell.textLabel.text=self.goodsModel.goodsName;
            cell.detailTextLabel.text=@"";
        }else if (indexPath.row==2){
            cell.textLabel.text=@"顾问推荐:";
            cell.detailTextLabel.text=self.goodsModel.goodsRemark;
        }else if (indexPath.row==3){
            cell.textLabel.text=@"发货须知:";
            cell.detailTextLabel.text=self.goodsModel.deliverNotice;
        }
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat heiht=44;
    if (indexPath.row==0) {
        heiht=50;
    }else if (indexPath.row==1) {
        heiht=[GoodsDetailPriceCell goodsDetailPriceHeight];
    }else if (indexPath.row==2||indexPath.row==3){
        
       __block NSString *detailText=@"";
        if (indexPath.row==2) {
            detailText=self.goodsModel.goodsRemark;
        }else if (indexPath.row==3){
            detailText=self.goodsModel.deliverNotice;
        }
        CGSize size=[detailText boundingRectWithfont:[UIFont systemFontOfSize:14] maxTextSize:CGSizeMake(200, CGFLOAT_MAX)];
        heiht=MAX(44.0, size.height+10);
    }
    return heiht;
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    CGFloat  sizeHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight;"] floatValue];
    CGRect frame=webView.frame;
    frame.size.height=sizeHeight;
    webView.frame=frame;
    self.tableView.tableFooterView=webView;
    webView.scrollView.scrollEnabled=NO;
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    
}
@end
