//
//  BrandModel.m
//  MCMall
//
//  Created by Luigi on 15/11/15.
//  Copyright © 2015年 Luigi. All rights reserved.
//

#import "BrandModel.h"

@implementation BrandModel


+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"brandID":@"brandId",
             @"brandName":@"brandName",
             @"brandImgUrl":@"bigImg",
             @"brandIntro":@"explain",
             @"brandDeclaration":@"declaration",};
};

-(void)setBrandImgUrl:(NSString *)brandImgUrl{
    _brandImgUrl=brandImgUrl;
    _brandImgUrl=[HHGlobalVarTool fullImagePath:_brandImgUrl];
}
@end
