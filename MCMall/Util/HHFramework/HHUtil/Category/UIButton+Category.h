//
//  UIButton+Category.h
//  OpenCourse
//
//  Created by sun wanhua on 15-8-11.
//
//

#import <UIKit/UIKit.h>

@interface UIButton (Category)

+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font target:(id)target selector:(SEL)selctor;
+ (UIButton *)buttonWithImageString:(NSString *)string heightImageString:(NSString *)heightString target:(id)target selector:(SEL)selctor;

@end
