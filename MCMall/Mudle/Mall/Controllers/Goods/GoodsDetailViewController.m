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
#import "GoodsAddressAddViewController.h"
#import "NSString+MCHtml.h"
@interface GoodsDetailViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIImageView *goodsImageView;
@property(nonatomic,strong)UIToolbar *tooBar;
@property(nonatomic,strong)UIWebView *footWebView;
@end

@implementation GoodsDetailViewController
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(UIImageView *)goodsImageView{
    if (nil==_goodsImageView) {
        _goodsImageView=[[UIImageView alloc]  initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)];
        _goodsImageView.userInteractionEnabled=YES;
        [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:_goodsModel.goodsImageUrl] placeholderImage:MCMallDefaultImg];
        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]  initWithTarget:self action:@selector(handleGoodsImageViewTaped:)];
        
        [_goodsImageView addGestureRecognizer:tapGesture];
    }
    return _goodsImageView;
}
-(void)handleGoodsImageViewTaped:(UITapGestureRecognizer *)tap{
    [[HHPhotoBroswer sharedPhotoBroswer] showBrowserWithImages:[NSArray arrayWithObject:_goodsModel.goodsImageUrl] atIndex:0];
}
-(UIToolbar *)tooBar{
    if (nil==_tooBar) {
        _tooBar=[[UIToolbar alloc]  init];
        _tooBar.barStyle=UIBarStyleDefault;
        UIBarButtonItem *collectBarButton=[[UIBarButtonItem alloc] initWithTitle:@"收藏" style:UIBarButtonItemStylePlain target:self action:@selector(handlerBarButtonClicked:)];
        collectBarButton.tag=100;
        UIBarButtonItem *spaceBarButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        spaceBarButton.tag=101;
        UIBarButtonItem *fixSpaceBarButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
        fixSpaceBarButton.width=30;
        UIButton *bookButton=[UIButton buttonWithType:UIButtonTypeCustom];
        bookButton.frame=CGRectMake(0, 0, 100, 30);
        bookButton.tag=102;
        [bookButton setTitle:@"我要预订" forState:UIControlStateNormal];
        [bookButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        bookButton.backgroundColor=MCMallThemeColor;
        bookButton.layer.cornerRadius=4;
        bookButton.layer.masksToBounds=YES;
        [bookButton addTarget:self action:@selector(handlerBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *bookBarButton=[[UIBarButtonItem alloc] initWithCustomView:bookButton];
        
        _tooBar.items=@[fixSpaceBarButton,collectBarButton,spaceBarButton,bookBarButton,fixSpaceBarButton];
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
            GoodsAddressAddViewController *addressAddController=[[GoodsAddressAddViewController alloc] initWithStyle:UITableViewStyleGrouped];
            addressAddController.goodsModel=self.goodsModel;
            [self.navigationController pushViewController:addressAddController animated:YES];
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

    [self getGoodsDetailWithGoodsID:self.goodsModel.goodsID];
    self.title=@"商品详情";
    [self.view addSubview:self.tooBar];
    self.tableView.tableHeaderView=self.goodsImageView;
    WEAKSELF
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.removeExisting=YES;
        make.top.left.right.mas_equalTo(weakSelf.view);
        make.bottom.mas_equalTo(weakSelf.tooBar.mas_top);
    }];
    [self.tooBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(weakSelf.view );
        make.height.mas_equalTo(50);
    }];
    [[NSNotificationCenter defaultCenter] addObserverForName:MCMallTimerTaskNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        
        [weakSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0] ] withRowAnimation:UITableViewRowAnimationNone];
    }];
    
}
-(void)getGoodsDetailWithGoodsID:(NSString *)goodsID{
    [HHProgressHUD showLoadingState];
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine] getGoodsDetailWithGoodsID:goodsID userID:[HHUserManager userID] onCompletionHandler:^(HHResponseResult *responseResult) {
        [HHProgressHUD dismiss];
        if (responseResult.responseCode==HHResponseResultCode100) {
            _goodsModel.goodsDetail=((GoodsModel *)responseResult.responseData).goodsDetail;
            [self.footWebView loadHTMLString:_goodsModel.goodsDetail baseURL:nil];
        }else{
            [HHProgressHUD makeToast:responseResult.responseMessage];
        }
    }];
    [self addOperationUniqueIdentifer:op.uniqueIdentifier];
}

#pragma mark-tableview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer=@"cellidentifer";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
    if (nil==cell) {
        cell=[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifer];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row==0) {
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
        cell.textLabel.font=[UIFont systemFontOfSize:14];
        cell.textLabel.textColor=[UIColor blackColor];
        if (_goodsModel.endTime) {
            NSString *timeStr=@"还有天0小时0分0秒";
            NSDate *earlyDate=[_goodsModel.endTime  earlierDate:[NSDate date]];
            if (earlyDate==_goodsModel.endTime) {
            }else{
                NSDateComponents *components=[_goodsModel.endTime componentsToDate:[NSDate date]];
                timeStr=[NSString stringWithFormat:@"还有%ld天%ld小时%ld分%ld秒",components.day,components.hour,components.minute,components.second];
            }
            cell.textLabel.text=timeStr;
        }
    }else if (indexPath.row==1){
        cell.textLabel.textColor=MCMallThemeColor;
        cell.textLabel.textAlignment=NSTextAlignmentRight;
        NSAttributedString *priceAttrStr=[NSString attributedStringWithOrignalPrice:_goodsModel.orignalPrice orignalFontSize:18 newPrice:_goodsModel.presenPrice newFontSize:14];
        cell.textLabel.attributedText=priceAttrStr;
        cell.detailTextLabel.font=[UIFont systemFontOfSize:14];
        cell.detailTextLabel.textColor=[UIColor darkGrayColor];
        cell.detailTextLabel.text=[NSString stringWithFormat:@"剩余%ld件",_goodsModel.storeNum];
    }
    return cell;
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
