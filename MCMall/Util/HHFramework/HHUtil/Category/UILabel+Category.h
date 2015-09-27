//
//  UILabel+Category.h
//  OpenCourse
//
//  Created by sun wanhua on 15-8-11.
//
//

#import <UIKit/UIKit.h>

@interface UILabel (Category)

- (void)changeColor:(UIColor *)color range:(NSRange)range;
- (void)changeColor:(UIColor *)color font:(UIFont *)font range:(NSRange)range;

+ (UILabel *)labelWithText:(NSString *)text font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment;
+ (UILabel *)labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor*)textColor textAlignment:(NSTextAlignment)textAlignment;
+ (UILabel *)labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor*)textColor backgroundColor:(UIColor *)backGroundColor textAlignment:(NSTextAlignment)textAlignment;

@end
