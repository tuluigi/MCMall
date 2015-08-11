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
@interface GoodsDetailViewController ()
@property(nonatomic,strong)UIImageView *goodsImageView;
@end

@implementation GoodsDetailViewController
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(UIImageView *)goodsImageView{
    if (nil==_goodsImageView) {
        _goodsImageView=[[UIImageView alloc]  initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)];
          [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:_goodsModel.goodsImageUrl] placeholderImage:MCMallDefaultImg];
    }
    return _goodsImageView;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    [self getGoodsDetailWithGoodsID:self.goodsModel.goodsID];
    self.title=@"商品详情";
    self.tableView.tableHeaderView=self.goodsImageView;
    WEAKSELF
    [[NSNotificationCenter defaultCenter] addObserverForName:MCMallTimerTaskNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        
        [weakSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0] ] withRowAnimation:UITableViewRowAnimationNone];
    }];
  
}
-(void)getGoodsDetailWithGoodsID:(NSString *)goodsID{
    [HHProgressHUD showLoadingState];
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine] getGoodsDetailWithGoodsID:goodsID onCompletionHandler:^(HHResponseResult *responseResult) {
        [HHProgressHUD dismiss];
        if (responseResult.responseCode==HHResponseResultCode100) {
            _goodsModel.goodsDetail=((GoodsModel *)responseResult.responseData).goodsDetail;
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
        cell.textLabel.textAlignment=NSTextAlignmentRight;
         NSAttributedString *priceAttrStr=[NSString attributedStringWithOrignalPrice:_goodsModel.orignalPrice orignalFontSize:18 newPrice:_goodsModel.presenPrice newFontSize:14];
        cell.textLabel.attributedText=priceAttrStr;
        cell.detailTextLabel.font=[UIFont systemFontOfSize:14];
        cell.detailTextLabel.textColor=[UIColor darkGrayColor];
        cell.detailTextLabel.text=[NSString stringWithFormat:@"剩余%ld件",_goodsModel.storeNum];
    }
    return cell;
}

@end
