//
//  BabyPhotosViewController.h
//  MCMall
//
//  Created by Luigi on 15/10/1.
//  Copyright © 2015年 Luigi. All rights reserved.
//

#import "BaseViewController.h"
@class NoteModel;
@interface BabyPhotosViewController : BaseViewController
@property(nonatomic,assign)BOOL enableUpload;
-(instancetype)initWithNoteModle:(NoteModel *)noteModel;
@end

