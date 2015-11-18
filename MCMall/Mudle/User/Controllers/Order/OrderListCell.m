//
//  OrderListCell.m
//  MCMall
//
//  Created by Luigi on 15/9/23.
//  Copyright © 2015年 Luigi. All rights reserved.
//

#import "OrderListCell.h"
#import "GoodsModel.h"
@interface OrderListCell ()
@property(nonatomic,strong)UILabel *orderNumLable,*orderTimeLable,*goodsNameLable,*goodsPriceLable,*orderCountLable,*totalPriceLable,*pointLable,*statusLable,*sourceLable;
@property(nonatomic,strong)UIImageView *goodsImageView;

@end

@implementation OrderListCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self onInitUI];
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
-(void)onInitUI{
    UIView *bgView=[UIView new];
    bgView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:bgView];
    self.contentView.backgroundColor=[UIColor red:240 green:240 blue:240 alpha:1];
    _orderNumLable=[[UILabel alloc]  init];
    _orderNumLable.textAlignment=NSTextAlignmentLeft;
    _orderNumLable.font=[UIFont systemFontOfSize:14];
    _orderNumLable.textColor=[UIColor red:104 green:104 blue:104 alpha:1];
    [bgView addSubview:_orderNumLable];
    
    _orderTimeLable=[[UILabel alloc]  init];
    _orderTimeLable.textAlignment=NSTextAlignmentRight;
    _orderTimeLable.font=[UIFont systemFontOfSize:14];
    _orderTimeLable.textColor=[UIColor lightGrayColor];
    [bgView addSubview:_orderTimeLable];
    
    UILabel *lineLable0=[[UILabel alloc]  init];
    lineLable0.backgroundColor=[UIColor red:239 green:239 blue:239 alpha:1];
    [bgView addSubview:lineLable0];
    
    _goodsImageView=[[UIImageView alloc]  init];
    [bgView addSubview:_goodsImageView];
    
    
    _goodsNameLable=[[UILabel alloc]  init];
    _goodsNameLable.textAlignment=NSTextAlignmentLeft;
    _goodsNameLable.font=[UIFont systemFontOfSize:14];
    _goodsNameLable.textColor=[UIColor blackColor];
    _goodsNameLable.numberOfLines=2;
    [bgView addSubview:_goodsNameLable];
    
    _goodsPriceLable=[[UILabel alloc]  init];
    _goodsPriceLable.textAlignment=NSTextAlignmentLeft;
    _goodsPriceLable.font=[UIFont systemFontOfSize:13];
    _goodsPriceLable.textColor=[UIColor darkGrayColor];
    [bgView addSubview:_goodsPriceLable];

    
    _orderCountLable=[[UILabel alloc]  init];
    _orderCountLable.textAlignment=NSTextAlignmentLeft;
    _orderCountLable.font=[UIFont systemFontOfSize:13];
    _orderCountLable.textColor=[UIColor darkGrayColor];
    [bgView addSubview:_orderCountLable];
    
    _pointLable=[[UILabel alloc]  init];
    _pointLable.textAlignment=NSTextAlignmentLeft;
    _pointLable.font=[UIFont systemFontOfSize:13];
    _pointLable.textColor=[UIColor darkGrayColor];
    [bgView addSubview:_pointLable];
    
    UILabel *lineLable1=[[UILabel alloc]  init];
    lineLable1.backgroundColor=[UIColor red:239 green:239 blue:239 alpha:1];
    [bgView addSubview:lineLable1];

    
    _totalPriceLable=[[UILabel alloc]  init];
    _totalPriceLable.textAlignment=NSTextAlignmentLeft;
    _totalPriceLable.font=[UIFont systemFontOfSize:14];
    _totalPriceLable.textColor=[UIColor blackColor];
    [bgView addSubview:_totalPriceLable];
    
    _statusLable=[[UILabel alloc]  init];
    _statusLable.textAlignment=NSTextAlignmentLeft;
    _statusLable.font=[UIFont systemFontOfSize:14];
    _statusLable.textColor=[UIColor darkGrayColor];
    [bgView addSubview:_statusLable];
    
    _sourceLable=[[UILabel alloc]  init];
    _sourceLable.textAlignment=NSTextAlignmentLeft;
    _sourceLable.font=[UIFont systemFontOfSize:14];
    _sourceLable.textColor=[UIColor darkGrayColor];
    [bgView addSubview:_sourceLable];
    
    WEAKSELF
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(5, 0, 5, 0));
    }];
    [_orderNumLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(weakSelf.contentView).offset(5);
        make.size.mas_equalTo(CGSizeMake(200, 35));
    }];
    [_orderTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.mas_equalTo(weakSelf.orderNumLable);
        make.right.mas_equalTo(bgView).offset(-5);
        make.left.mas_equalTo(weakSelf.orderNumLable.mas_right);
    }];
    [lineLable0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.orderNumLable.mas_bottom);
        make.left.right.mas_equalTo(bgView);
        make.height.mas_equalTo(1);
    }];
    
    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bgView.mas_left).offset(10);
        make.top.mas_equalTo(lineLable0.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    [_goodsNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.goodsImageView.mas_right).offset(10);
        make.right.mas_equalTo(bgView.mas_right).offset(-10);
        make.top.mas_equalTo(weakSelf.goodsImageView.mas_top).offset(5);
        make.height.mas_equalTo(20);
    }];
    [_goodsPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.goodsNameLable.mas_left);
//        make.top.mas_equalTo(weakSelf.goodsNameLable.mas_bottom).offset(5);
        make.bottom.mas_equalTo(weakSelf.goodsImageView.mas_bottom).offset(-5);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
  
    [_orderCountLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.goodsPriceLable.mas_right);
        make.bottom.mas_equalTo(weakSelf.goodsPriceLable);
        make.size.mas_equalTo(weakSelf.goodsPriceLable);
    }];
    [_pointLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.orderCountLable.mas_right);
        make.bottom.mas_equalTo(weakSelf.goodsPriceLable);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    [lineLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.goodsImageView.mas_bottom).offset(5);
        make.left.right.mas_equalTo(bgView);
        make.height.mas_equalTo(0.5);
    }];
    [_totalPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineLable1.mas_bottom).offset(5);
        make.left.mas_equalTo(bgView.mas_left).offset(10);
        make.right.mas_equalTo(bgView.mas_right).offset(-10);
        make.height.mas_equalTo(30);
        
    }];
    
    [_statusLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_totalPriceLable.mas_left);
        make.top.mas_equalTo(_totalPriceLable.mas_bottom).offset(5);
        make.right.mas_equalTo(bgView.mas_centerX);
        make.height.mas_equalTo(20);
        make.bottom.mas_equalTo(bgView.mas_bottom).offset(-5);
    }];
    
    [_sourceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bgView.mas_centerX);
        make.right.mas_equalTo(bgView.mas_right).offset(-5);
        make.top.height.mas_equalTo(_statusLable);
    }];
}
-(void)setOrderModel:(OrderModel *)orderModel{
    _orderModel=orderModel;
    _orderNumLable.text=[@"订单号：" stringByAppendingString:_orderModel.orderID];
    _orderTimeLable.text=_orderModel.orderTime;
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:_orderModel.goodsThumbImageUrl] placeholderImage:MCMallDefaultImg];
    _goodsNameLable.text=_orderModel.goodsName;
    _goodsPriceLable.text=[@"单价" stringByAppendingString:[NSString stringWithFormat:@"%.1f￥",_orderModel.goodsPrice]];
    
    _orderCountLable.text=[@"数量:" stringByAppendingString:[NSString stringWithFormat:@"%ld",_orderModel.goodsNum]];
    _pointLable.text=[@"积分:" stringByAppendingString:[NSString stringWithFormat:@"%.0f",_orderModel.deductPoints]];
     _totalPriceLable.text=[@"总计:￥" stringByAppendingString:[NSString stringWithFormat:@"%.0f",_orderModel.totalPrice]];
    
    _statusLable.text=[NSString stringWithFormat:@"订单状态：%@",orderModel.orderStatus];
    _sourceLable.text=[NSString stringWithFormat:@"订单来源：%@",orderModel.orderSource];
}
@end
