//
//  OCCommentView.h
//  OpenCourse
//
//  Created by Luigi on 15/8/19.
//
//

#import <UIKit/UIKit.h>

typedef void(^OCCommentViewHandleValueChangedBlock)(NSString *commentContent);
typedef void(^OCCommentViewBlock)(NSString *comment);
@interface OCCommentView : UIView
@property(nonatomic,copy)NSString *commentContent;//实际评论的内容
@property(nonatomic,copy)NSString *placeholer;//placeHoder
@property(nonatomic,copy)OCCommentViewBlock becomeActiveBlock;
@property(nonatomic,copy)OCCommentViewBlock publishCommentsBlock;
@end
