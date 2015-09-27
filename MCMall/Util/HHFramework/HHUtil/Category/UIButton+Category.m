//
//  UIButton+Category.m
//  OpenCourse
//
//  Created by sun wanhua on 15-8-11.
//
//

#import "UIButton+Category.h"

@implementation UIButton (Category)

+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font target:(id)target selector:(SEL)selctor {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = font;
    [button addTarget:target action:selctor forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

+ (UIButton *)buttonWithImageString:(NSString *)string heightImageString:(NSString *)heightString target:(id)target selector:(SEL)selctor {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:string] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:heightString] forState:UIControlStateHighlighted];
    [button addTarget:target action:selctor forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

@end
