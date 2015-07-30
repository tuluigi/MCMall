//
//  SubtitleExpertAnswerController.h
//  MCMall
//
//  Created by Luigi on 15/7/26.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "BaseTableViewController.h"
#import "SubjectModel.h"
@interface SubtitleExpertAnswerController : BaseTableViewController
-(id)initWithSubjectID:(NSString *)subjectID title:(NSString *)title state:(SubjectModelState)state;
@end
