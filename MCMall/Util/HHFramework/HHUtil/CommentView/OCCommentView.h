//
//  OCCommentView.h
//  OpenCourse
//
//  Created by Luigi on 15/8/19.
//
//

#import <UIKit/UIKit.h>

typedef void(^OCCommentViewBlock)(NSString *comment);
typedef void(^OCCommentViewCompletionBlock)(NSString *comments,BOOL isCancled);
@interface OCCommentView : UIView
@property(nonatomic,copy)NSString *commentContent;//实际评论的内容
@property(nonatomic,copy)NSString *placeholer;//placeHoder
@property(nonatomic,copy)OCCommentViewCompletionBlock completionBlock;
@property(nonatomic,copy)OCCommentViewBlock valueChangedBlock;
-(instancetype)initWithFrame:(CGRect)frame parentView:(UIView *)aView;
@end
