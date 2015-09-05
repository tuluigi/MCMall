//
//  HHResponseResult.h
//  PsHospital
//
//  Created by d gl on 13-11-11.
//  Copyright (c) 2013年 d gl. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, HHResponseResultCode) {
    HHResponseResultCodeSuccess         =100,//成功
    HHResponseResultCodeFailed      =101,//参数错误
    HHResponseResultCodeEmptyData   =1030,//
};
@class HHResponseResult;
typedef void(^HHResponseResultSucceedBlock)(HHResponseResult *responseResult);
typedef void(^HHResponseResultBlock)(HHResponseResult *responseResult);
typedef void(^HHResponseObjectBlock)(id responseData, NSError *error);
typedef void(^HHResponseResultErrorBlock)(NSError *error);

@interface HHResponseResult : NSObject
@property (nonatomic, strong) id        responseData;
@property (nonatomic, assign) NSInteger responseCode;
@property (nonatomic, strong) NSString *responseMessage;
+(HHResponseResult *)responseResultWithResponseObject:(id)responseObject error:(NSError *)aError;
@end
