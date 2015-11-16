//
//  VipHomeTagCell.h
//  MCMall
//
//  Created by Luigi on 15/11/16.
//  Copyright © 2015年 Luigi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VipHomeTagCellDelegate <NSObject>

-(void)didSelectItemWithTag:(MCVipGoodsItemTag)itemTag;

@end

@interface VipHomeTagCell : UITableViewCell
@property(nonatomic,weak)id<VipHomeTagCellDelegate>delegate;
+(CGFloat)vipHomeCellHeight;
@end
