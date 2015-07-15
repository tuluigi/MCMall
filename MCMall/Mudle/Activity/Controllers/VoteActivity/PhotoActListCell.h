//
//  PhotoActListCell.h
//  MCMall
//
//  Created by Luigi on 15/7/1.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PhotoModel;

@protocol PhotoActListCellDelegate <NSObject>

-(void)photoListCellDidSelectedWithPhotoModel:(PhotoModel *)photoModel;

@end

@interface PhotoActListCell : UITableViewCell
@property(nonatomic,assign)id<PhotoActListCellDelegate>delegate;
@property(nonatomic,strong)NSArray *photoArray;
+(CGFloat)photoListCellHeight;
@end
