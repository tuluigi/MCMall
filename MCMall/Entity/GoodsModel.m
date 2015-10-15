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
             @"orignalPrice":@"scprice",
             @"sellPrice":@"zxprice",
              @"vipPrice":@"vipprice",
              @"deductionPoint":@"deduction",
             @"storeNum":@"stock",
             @"endTime":@"endDay",
             @"goodsDetail":@"synopsis",
             @"goodsBigImageUrl":@"bigImg",
             @"deliverNotice":@"notice",
             @"goodsRemark":@"oneself",
             };
}
+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key {
    if ([key isEqualToString:@"orignalPrice"]||[key isEqualToString:@"sellPrice"]||[key isEqualToString:@"vipPrice"]||[key isEqualToString:@"storeNum"]||[key isEqualToString:@"deductionPoint"]) {
        return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
            if ([value isKindOfClass:[NSString class]]) {
                NSNumberFormatter *numberFormatter=[[NSNumberFormatter alloc]  init];
                numberFormatter.numberStyle=kCFNumberFormatterDecimalStyle;
                NSNumber *number=[numberFormatter numberFromString:(NSString *)value];;
                if (!number) {
                    number=[NSNumber numberWithFloat:0];
                }
                return number;

            }else{
                return value;
            }
        }];
    }
    return nil;
}
-(void)setGoodsImageUrl:(NSString *)goodsImageUrl{
    _goodsImageUrl=goodsImageUrl;
    _goodsImageUrl=[HHGlobalVarTool fullImagePath:_goodsImageUrl];
}
-(void)setGoodsBigImageUrl:(NSString *)goodsBigImageUrl{
    _goodsBigImageUrl=goodsBigImageUrl;
    _goodsBigImageUrl=[HHGlobalVarTool fullImagePath:_goodsBigImageUrl];
}
+(MTLValueTransformer *)endTimeJSONTransformer{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSDateFormatter *formatter= [NSDateFormatter defaultDateFormatter];
        NSDate *date=[formatter dateFromString:value];
        return date;
    }];
}
@end

@implementation OrderModel

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"orderID":@"no",
             @"orderTime":@"time",
             @"goodsName":@"goodName",
             @"goodsThumbImageUrl":@"small",
             @"totalPrice":@"total",
             @"goodsNum":@"quantity",
             @"deductPoints":@"point",
              @"goodsPrice":@"price",
             };
}
-(void)setGoodsThumbImageUrl:(NSString *)goodsThumbImageUrl{
    _goodsThumbImageUrl=goodsThumbImageUrl;
    _goodsThumbImageUrl=[HHGlobalVarTool fullImagePath:_goodsThumbImageUrl];
}
+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key {
    if ([key isEqualToString:@"totalPrice"]||[key isEqualToString:@"goodsPrice"]) {
        return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
            if ([value isKindOfClass:[NSString class]]) {
                NSNumberFormatter *numberFormatter=[[NSNumberFormatter alloc]  init];
                numberFormatter.numberStyle=kCFNumberFormatterDecimalStyle;
                NSNumber *number=[numberFormatter numberFromString:(NSString *)value];;
                if (!number) {
                    number=[NSNumber numberWithFloat:0];
                }
                return number;
            }else{
                return value;
            }
        }];
    }else  if ([key isEqualToString:@"goodsNum"]||[key isEqualToString:@"deductPoints"]) {
        return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
            if ([value isKindOfClass:[NSString class]]) {
                return [NSNumber numberWithFloat:[value integerValue]];
            }else{
                return value;
            }
        }];
    }

    return nil;
}

@end
