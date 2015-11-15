//
//  BrandModel.h
//  MCMall
//
//  Created by Luigi on 15/11/15.
//  Copyright © 2015年 Luigi. All rights reserved.
//

#import "BaseModel.h"

@interface BrandModel : BaseModel
@property(nonatomic,copy)NSString *brandID,*brandName,*brandImgUrl,*brandIntro;
@property(nonatomic,strong)NSData *endData;
@end
