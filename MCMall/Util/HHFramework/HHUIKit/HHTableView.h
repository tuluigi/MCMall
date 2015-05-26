//
//  HHTableView.h
//  SeaMallBuy
//
//  Created by d gl on 14-2-11.
//  Copyright (c) 2014年 d gl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingTableView.h"
@interface HHTableView : TPKeyboardAvoidingTableView
/**
 *  hhtableview
 *
 *  @param frame          frame
 *  @param dataSource     dataSource delegate
 *  @param delegate       delegate
 *  @param style          group/plain
 *  @param separatorColor 分割线颜色
 *
 *  @return uitableview
 */

- (id)initWithFrame:(CGRect)frame
         dataSource:(id)dataSource
           delegate:(id)delegate
              style:(UITableViewStyle )style;
 
@end
