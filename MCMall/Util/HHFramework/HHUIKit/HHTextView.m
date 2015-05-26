//
//  HHTextView.m
//  SeaMallSell
//
//  Created by d gl on 14-3-20.
//  Copyright (c) 2014年 d gl. All rights reserved.
//

#import "HHTextView.h"

@interface HHTextView ()
@property (nonatomic, strong) UILabel *placeHolderLabel;
@end

@implementation HHTextView
@synthesize placeholder=_placeholder;
@synthesize placeholderColor=_placeholderColor;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setPlaceholder:@""];
        [self setPlaceholderColor:[UIColor lightGrayColor]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame textColor:(UIColor *)color textFont:(UIFont *)font delegate:(id)delegate placeHolderString:(NSString *)str{
    self = [super initWithFrame:frame];
    if (self) {
        self.textColor=color;
        self.font=font;
        self.delegate=delegate;
        self.placeholder=str;
        self.backgroundColor=[UIColor clearColor];
        
        [self setPlaceholder:@""];
        [self setPlaceholderColor:[UIColor lightGrayColor]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)textChanged:(NSNotification *)notification
{
    if([[self placeholder] length] == 0)
    {
        return;
    }
    
    if([[self text] length] == 0)
    {
        [[self viewWithTag:999] setAlpha:1];
    }
    else
    {
        [[self viewWithTag:999] setAlpha:0];
    }
}
- (void)setText:(NSString *)text {
    [super setText:text];
    [self textChanged:nil];
}
- (void)drawRect:(CGRect)rect
{
    
    if( [[self placeholder] length] > 0 )
    {
        if (_placeHolderLabel == nil )
        {
            _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(8,8,self.bounds.size.width - 16,0)];
            _placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
            _placeHolderLabel.numberOfLines = 0;
            _placeHolderLabel.font = self.font;
            _placeHolderLabel.backgroundColor = [UIColor clearColor];
            _placeHolderLabel.textColor = self.placeholderColor;
            _placeHolderLabel.alpha = 0;
            _placeHolderLabel.tag = 999;
            [self addSubview:_placeHolderLabel];
        }
        
        _placeHolderLabel.text = self.placeholder;
        [_placeHolderLabel sizeToFit];
        [self sendSubviewToBack:_placeHolderLabel];
    }
    
    if( [[self text] length] == 0 && [[self placeholder] length] > 0 )
    {
        [[self viewWithTag:999] setAlpha:1];
    }
    
    [super drawRect:rect];
}

@end
