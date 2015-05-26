//
//  HHTextField.m
//  SeaMallBuy
//
//  Created by d gl on 14-1-9.
//  Copyright (c) 2014年 d gl. All rights reserved.
//

#import "HHTextField.h"

@implementation HHTextField
@synthesize indexPath =_indexPath;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame
          fontSize:(CGFloat)fontsize
          delegate:(id)delegate
       borderStyle:(UITextBorderStyle)borderStyle
     returnKeyType:(UIReturnKeyType)returnKeyType
       placeholder:(NSString *)palcerHoder{
    self=[super initWithFrame:frame];
    if (self) {
        self.font           =[UIFont systemFontOfSize:fontsize];
        self.delegate       =delegate;
        self.borderStyle    =borderStyle;
        self.returnKeyType  =returnKeyType;
        self.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.placeholder    =(palcerHoder==nil?@"":palcerHoder);
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame
          fontSize:(CGFloat)fontsize
          delegate:(id)delegate
       borderStyle:(UITextBorderStyle)borderStyle
     returnKeyType:(UIReturnKeyType)returnKeyType
      keyboardType:(UIKeyboardType)keyboardType
       placeholder:(NSString *)palcerHoder{
    self=[super initWithFrame:frame];
    if (self) {
        self.font           =[UIFont systemFontOfSize:fontsize];
        self.delegate       =delegate;
        self.borderStyle    =borderStyle;
        self.returnKeyType  =returnKeyType;
        self.keyboardType   =keyboardType;
        self.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.placeholder    =(palcerHoder==nil?@"":palcerHoder);
    }
    return self;
}


@end
