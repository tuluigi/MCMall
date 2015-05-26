//
//  HHResponseResult.h
//  PsHospital
//
//  Created by d gl on 13-11-11.
//  Copyright (c) 2013年 d gl. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, HHResponseResultCode) {
    
    HHResponseResultCode100         =100,//成功
    HHResponseResultCode101         =101,//数据为空
    HHResponseResultCode102         =102,//参数错误
    HHResponseResultCode103         =103,//
    HHResponseResultCode104         =104,//
    HHResponseResultCode105         =105,//
    HHResponseResultCode106         =106,//
    HHResponseResultCode107         =107,//
    HHResponseResultCode108         =108,//
    HHResponseResultCode109         =109,//
    HHResponseResultCode110         =110,
    HHResponseResultCodeSeverError  =100001,//服务器后台错误
    HHResponseResultCodeJsonError   =100002,//返回数据json格式错误
    HHResponseResultCodeConenectError   =200001,//连接失败
    HHResponseResultCodeUNKownError     =200002,//未知错误
};
@class HHResponseResult;
typedef void(^HHResponseResultSucceedBlock)(HHResponseResult *responseResult);
@interface HHResponseResult : NSObject
@property (nonatomic, strong) id        responseData;
@property (nonatomic, assign) NSInteger responseCode;
@property (nonatomic, strong) NSString *responseMessage;
@end
