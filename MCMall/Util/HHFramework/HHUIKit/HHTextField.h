//
//  HHTextField.h
//  SeaMallBuy
//
//  Created by d gl on 14-1-9.
//  Copyright (c) 2014年 d gl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHTextField : UITextField
@property(nonatomic,strong)id indexPath;
-(id)initWithFrame:(CGRect)frame
          fontSize:(CGFloat)fontsize
          delegate:(id)delegate
       borderStyle:(UITextBorderStyle)borderStyle
     returnKeyType:(UIReturnKeyType)returnKeyType
       placeholder:(NSString *)palcerHoder;

-(id)initWithFrame:(CGRect)frame
          fontSize:(CGFloat)fontsize
          delegate:(id)delegate
       borderStyle:(UITextBorderStyle)borderStyle
     returnKeyType:(UIReturnKeyType)returnKeyType
      keyboardType:(UIKeyboardType)keyboardType
       placeholder:(NSString *)palcerHoder;
@end
