//
//  PlayerCell.h
//  MCMall
//
//  Created by Luigi on 15/6/18.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PlayerModel;
@protocol PlayerCellDelegate <NSObject>

-(void)playerCellDidVoteButtonPressedWithPlayer:(PlayerModel *)playerModel;
-(void)playerCellDidMoreButtonPressedWithPlayer:(PlayerModel *)playerModel;

@end


@interface PlayerCell : UITableViewCell
@property(nonatomic,strong)PlayerModel *playerModel;
@property(nonatomic,weak)id <PlayerCellDelegate>delegate;

+(CGFloat)playerCellHeightWithPlayerModel:(PlayerModel *)model;
@end
