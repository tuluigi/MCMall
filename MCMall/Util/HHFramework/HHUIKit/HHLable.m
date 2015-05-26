//
//  HHLable.m
//  SeaMallBuy
//
//  Created by d gl on 14-2-11.
//  Copyright (c) 2014年 d gl. All rights reserved.
//

#import "HHLable.h"

@implementation HHLable
@synthesize inputAccessoryView      =_inputAccessoryView;
@synthesize inputView               =_inputView;
@synthesize shouldShowInputView     =_shouldShowInputView;

@synthesize  delegate               =_delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/**
 *  自定义lable
 *
 *  @param frame      fram
 *  @param fontsize   字体大小<使用的是系统默认的字体>
 *  @param textcolor  字体的颜色
 *  @param alignment  对齐方式
 *  @param lines      行数 <默认1行>
 *  @param breakModel 换行方式 <系统默认的方式>
 *
 *  @return HHLable
 */
- (id)initWithFrame:(CGRect)frame fontSize:(CGFloat)fontsize text:(NSString *)text textColor:(UIColor *)textcolor textAlignment:(NSTextAlignment )alignment numberOfLines:(NSInteger)lines lineBreakMode:(NSLineBreakMode)breakModel{
    self = [super initWithFrame:frame];
    if (self) {
        self.font               =   [UIFont systemFontOfSize:fontsize];
        self.textColor          =   textcolor;
        self.textAlignment      =   alignment;
        self.numberOfLines      =   lines;
        self.lineBreakMode      =   breakModel;
        self.text               =   (text==nil?@"":text);
        self.backgroundColor    =   [UIColor clearColor];
    }
    return self;
}
/**
 *  自定义lable
 *
 *  @param frame      fram
 *  @param fontsize   字体大小<使用的是系统默认的字体>
 *  @param textcolor  字体的颜色
 *  @param alignment  对齐方式
 *  @param lines      行数 <默认1行>
 *
 *  @return HHLable
 */

- (id)initWithFrame:(CGRect)frame fontSize:(CGFloat)fontsize text:(NSString *)text textColor:(UIColor *)textcolor textAlignment:(NSTextAlignment )alignment numberOfLines:(NSInteger)lines{
    self = [super initWithFrame:frame];
    if (self) {
        self.font               =   [UIFont systemFontOfSize:fontsize];
        self.textColor          =   textcolor;
        self.text               =   (text==nil?@"":text);
        self.textAlignment      =   alignment;
        self.numberOfLines      =   lines;
        self.backgroundColor    =   [UIColor clearColor];
    }
    return self;
}
-(void)launchPicker:(UITapGestureRecognizer *) tapper
{
    BOOL canFirstResponsder=[self canBecomeFirstResponder];
    if (_delegate&&[_delegate respondsToSelector:@selector(hhlable:isBecomeFirstResponder:)]) {
        [_delegate hhlable:self isBecomeFirstResponder:canFirstResponsder];
    }
    [self becomeFirstResponder];
}
-(void)setShouldShowInputView:(BOOL)shouldShowInputView{
    _shouldShowInputView=shouldShowInputView;
    if (shouldShowInputView) {
        UITapGestureRecognizer *tapper = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(launchPicker:)];
        [self addGestureRecognizer:tapper];
    }
}
- (BOOL)isUserInteractionEnabled
{
    return YES;
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}
@end
