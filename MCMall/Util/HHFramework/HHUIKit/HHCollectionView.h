//
//  HHCollectionView.h
//  SeaMallBuy
//
//  Created by d gl on 14-4-25.
//  Copyright (c) 2014年 d gl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingCollectionView.h"

@interface HHCollectionView : TPKeyboardAvoidingCollectionView
-(id)initWithFrame:(CGRect)frame delegate:(id)delegate dataSource:(id)dataSourse;
@end
