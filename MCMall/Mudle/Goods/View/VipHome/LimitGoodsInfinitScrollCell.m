//
//  LimitGoodsInfinitScrollCell.m
//  MCMall
//
//  Created by Luigi on 15/11/19.
//  Copyright © 2015年 Luigi. All rights reserved.
//

#import "LimitGoodsInfinitScrollCell.h"
#import "LimitGoodsScrollCell.h"
#import "GoodsNetService.h"
#import "GoodsModel.h"
#define  LimitGoodsScrollCellTimeSpan  3
@interface LimitGoodsInfinitScrollCell ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *goodsArray;
@property(nonatomic,assign)NSInteger timeSpanIndex,currentIndex;
@end

@implementation LimitGoodsInfinitScrollCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.tableview];
        [self getLimitGoodsList];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(UITableView *)tableview{
    if (nil==_tableview) {
        _tableview=[[UITableView alloc]  initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableview.delegate=self;
        _tableview.dataSource=self;
        _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableview.userInteractionEnabled=NO;
    }
    return _tableview;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.tableview.frame=self.contentView.bounds;
}
-(void)updateLimitGoods{
    WEAKSELF
    if (weakSelf.timeSpanIndex<LimitGoodsScrollCellTimeSpan) {
        weakSelf.timeSpanIndex++;
        if (weakSelf.currentIndex==weakSelf.goodsArray.count) {
            [weakSelf.tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
        }
    }else{
        weakSelf.timeSpanIndex=1;
        if ((weakSelf.currentIndex) >= (weakSelf.goodsArray.count)) {
            weakSelf.currentIndex=1;
        }else{
            weakSelf.currentIndex++;
        }
        [weakSelf.tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:weakSelf.currentIndex inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
    }
}
-(void)getLimitGoodsList{
    WEAKSELF
    [GoodsNetService getLimitedSalesGoodsListOnCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCodeSuccess) {
            if (nil==weakSelf.goodsArray) {
                weakSelf.goodsArray=[[NSMutableArray alloc]  init];
            }
            [weakSelf.goodsArray removeAllObjects];
            [weakSelf.goodsArray addObjectsFromArray:responseResult.responseData];
            [weakSelf.tableview reloadData];
            [[NSNotificationCenter defaultCenter] addObserverForName:MCMallTimerTaskNotification object:nil queue:[NSOperationQueue currentQueue] usingBlock:^(NSNotification * _Nonnull note) {
                if (weakSelf.goodsArray) {
                    [weakSelf updateLimitGoods];
                }
            }];
        }
    }];
}
-(GoodsModel *)goodsModel{
    if (self.goodsArray.count) {
        if (self.currentIndex<self.goodsArray.count) {
            return [self.goodsArray objectAtIndex:self.currentIndex];
        }else{
            return [self.goodsArray firstObject];
        }
    }else{
        return nil;
    }
}
#pragma mark -tableviewdelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger row=self.goodsArray.count;
    if (row) {
        row++;
    }
    return row;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifer=@"identfier";
    LimitGoodsScrollCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
    if (nil==cell) {
        cell=[[LimitGoodsScrollCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row==self.goodsArray.count) {
        cell.goodsModel=[self.goodsArray firstObject];
    }else{
        cell.goodsModel=[self.goodsArray objectAtIndex:indexPath.row];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableView.bounds.size.height;
}
+(CGFloat)infiniteScrollCellHeight{
   return  [LimitGoodsScrollCell infiniteScrollCellHeight];
}
@end
