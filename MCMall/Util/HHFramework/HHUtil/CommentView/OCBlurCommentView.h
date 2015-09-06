//
//  OCBlurCommentView.h
//  OpenCourse
//
//  Created by Luigi on 15/8/25.
//
//

#import <UIKit/UIKit.h>

typedef void(^OCBlurCommentViewValueChangeBlock)(NSString *comments);
typedef void(^OCBlurCommentViewCompletionBlock)(NSString *comments,BOOL isCancled);
@interface OCBlurCommentView : UIImageView

+(OCBlurCommentView *)blurCommentView;
/**
 *  弹出带键盘的评论页面
 *
 *  @param aView            在哪个view之上弹出,如果nil则在 [UIApplication sharedApplication].keyWindow弹出
 *  @param comment          评论内容
 *  @param title            标题;如果为nil则为“写评论”
 *  @param valueChangeBlock 输入内容变化的block
 *  @param completionBlock  确定 block。isCancled=No 则为点击取消了, 否则为点击确定
 */
+(void)showOCBlouCommenInView:(UIView *)aView
                     comments:(NSString *)comment
                  placeholder:(NSString *)placeholder
                        title:(NSString *)title
          onValueChangedBlock:(OCBlurCommentViewValueChangeBlock)valueChangeBlock
              completionBlock:(OCBlurCommentViewCompletionBlock)completionBlock;
-(void)showOCBlouCommenInView:(UIView *)aView
                     comments:(NSString *)comment
                  placeholder:(NSString *)placeholder
                        title:(NSString *)title
          onValueChangedBlock:(OCBlurCommentViewValueChangeBlock)valueChangeBlock
              completionBlock:(OCBlurCommentViewCompletionBlock)completionBlock;
@end
