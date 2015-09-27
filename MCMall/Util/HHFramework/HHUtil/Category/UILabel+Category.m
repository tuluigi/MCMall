//
//  UILabel+Category.m
//  OpenCourse
//
//  Created by sun wanhua on 15-8-11.
//
//

#import "UILabel+Category.h"

@implementation UILabel (Category)

- (void)changeColor:(UIColor *)color range:(NSRange)range {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    [attributedString addAttributes:@{NSForegroundColorAttributeName: color} range:range];
    self.attributedText = attributedString;
}

- (void)changeColor:(UIColor *)color font:(UIFont *)font range:(NSRange)range {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    [attributedString addAttributes:@{NSForegroundColorAttributeName: color, NSFontAttributeName: font} range:range];
    self.attributedText = attributedString;
}

+ (UILabel *)labelWithText:(NSString *)text font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment {
    
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.font = font;
    label.textAlignment = textAlignment;
    
    return label;
}

+ (UILabel *)labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor*)textColor textAlignment:(NSTextAlignment)textAlignment {
    
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.font = font;
    [label setTextColor:textColor];
    label.textAlignment = textAlignment;
    
    return label;
}

+ (UILabel *)labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor*)textColor backgroundColor:(UIColor *)backGroundColor textAlignment:(NSTextAlignment)textAlignment {
    
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.font = font;
    [label setTextColor:textColor];
    label.backgroundColor = backGroundColor;
    label.textAlignment = textAlignment;
    
    return label;
}


@end
