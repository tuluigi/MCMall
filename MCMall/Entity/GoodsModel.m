//
//  GoodsModel.m
//  MCMall
//
//  Created by Luigi on 15/6/18.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "GoodsModel.h"


@implementation CategoryModel

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"catID":@"cId",
             @"catName":@"cName",
             };
}

@end

@implementation GoodsModel
+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"goodsID":@"goodId",
             @"goodsName":@"goodName",
             @"goodsImageUrl":@"goodImg",
             @"orignalPrice":@"oldprice",
             @"presenPrice":@"newprice",
             @"storeNum":@"stock",
             @"endTime":@"endDay",
             @"goodsDetail":@"synopsis",
             @"goodsBigImageUrl":@"bigImg",
             };
}
+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key {
    if ([key isEqualToString:@"oldPrice"]||[key isEqualToString:@"newPrice"]||[key isEqualToString:@"stock"]) {
        return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
            if ([value isKindOfClass:[NSString class]]) {
                return [NSNumber numberWithFloat:[value floatValue]];
            }else{
                return value;
            }
        }];
    }
    return nil;
}
-(void)setGoodsImageUrl:(NSString *)goodsImageUrl{
    _goodsImageUrl=goodsImageUrl;
    if (_goodsImageUrl&&![_goodsImageUrl hasPrefix:@"http"]) {
        _goodsImageUrl=[HHGlobalVarTool fullImagePath:_goodsImageUrl];
    }
}
-(void)setGoodsBigImageUrl:(NSString *)goodsBigImageUrl{
    _goodsBigImageUrl=goodsBigImageUrl;
    if (_goodsBigImageUrl&&_goodsBigImageUrl.length&&![_goodsBigImageUrl hasPrefix:@"http"]) {
        _goodsBigImageUrl=[HHGlobalVarTool fullImagePath:_goodsBigImageUrl];
    }
}
+(MTLValueTransformer *)endTimeJSONTransformer{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSDateFormatter *formatter= [NSDateFormatter defaultDateFormatter];
        NSDate *date=[formatter dateFromString:value];
        return date;
    }];
}
@end
