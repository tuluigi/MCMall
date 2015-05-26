//
//  HHButton.m
//  SeaMallBuy
//
//  Created by d gl on 14-2-11.
//  Copyright (c) 2014年 d gl. All rights reserved.
//

#import "HHButton.h"

@implementation HHButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
+ (id)buttonWithType:(UIButtonType)buttonType frame:(CGRect)frame titleColor:(UIColor *)titleColor titleSize:(CGFloat)size{
    UIButton *button=[super buttonWithType:buttonType];
    button.frame        =frame;
    button.titleLabel.textColor=titleColor;
    button.titleLabel.font=[UIFont systemFontOfSize:size];
    return button;
}
- (UIImage *) buttonImageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
@end
