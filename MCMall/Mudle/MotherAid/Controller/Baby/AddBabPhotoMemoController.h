//
//  AddBabPhotoMemoController.h
//  MCMall
//
//  Created by Luigi on 15/10/1.
//  Copyright © 2015年 Luigi. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^BabyPhotoContentChangedBlock)(NSString *content ,NSString *photoID ,NSString *noteID);

@interface AddBabPhotoMemoController : BaseViewController
-(instancetype)initWithNoteID:(NSString *)noteID photoID:(NSString *)photoID content:(NSString *)content;
@property(nonatomic,copy)BabyPhotoContentChangedBlock contentChangedBlock;
@end
