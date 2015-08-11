//
//  BaseModel.m
//  MCMall
//
//  Created by Luigi on 15/8/11.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return nil;
}

-(void)setNilValueForKey:(NSString *)key{
    [self setValue:@"" forKey:key];
}
@end
