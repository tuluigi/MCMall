//
//  UITextField+Addition.m
//  HHUIKitFrameWork
//
//  Created by d gl on 14-5-30.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import "UITextField+Addition.h"
#import <objc/objc.h>
#import <objc/runtime.h>
@implementation UITextField (Addition)
static NSString *kLimitTextLengthKey = @"kLimitTextLengthKey";

- (void)limitTextLength:(NSInteger)length
{
    objc_setAssociatedObject(self, (__bridge const void *)(kLimitTextLengthKey), [NSNumber numberWithInteger:length], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addTarget:self action:@selector(textFieldTextLengthLimit:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldTextLengthLimit:(id)sender
{
    NSNumber *lengthNumber = objc_getAssociatedObject(self, (__bridge const void *)(kLimitTextLengthKey));
    int length = [lengthNumber intValue];
    if(self.text.length > length){
        self.text = [self.text substringToIndex:length];
    }
}
@end
