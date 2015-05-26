//
//  HHTextView.h
//  SeaMallSell
//
//  Created by d gl on 14-3-20.
//  Copyright (c) 2014年 d gl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHTextView : UITextView
@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;

-(id)initWithFrame:(CGRect)frame textColor:(UIColor *)color textFont:(UIFont *)font delegate:(id)delegate placeHolderString:(NSString *)str;
@end
