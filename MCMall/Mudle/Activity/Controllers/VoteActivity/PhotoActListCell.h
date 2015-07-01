//
//  PhotoActListCell.h
//  MCMall
//
//  Created by Luigi on 15/7/1.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PhotoModel;
@interface PhotoActListCell : UITableViewCell
@property(nonatomic,strong)NSMutableArray *photoArray;
+(CGFloat)photoListCellHeight;
@end
