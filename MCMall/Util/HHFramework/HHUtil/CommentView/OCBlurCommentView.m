//
//  OCBlurCommentView.m
//  OpenCourse
//
//  Created by Luigi on 15/8/25.
//
//

#import "OCBlurCommentView.h"
#import "UIImageEffects.h"
#import "UIPlaceHolderTextView.h"
#define OCBlurCommentViewHeight     160
@interface OCBlurCommentView ()<UITextViewDelegate>
@property (nonatomic, copy)   OCBlurCommentViewValueChangeBlock valueChangeBlock;
@property (nonatomic, copy)   OCBlurCommentViewCompletionBlock completionBlock;
@property (nonatomic, strong) UIView *sheetView;
@property (nonatomic, strong) UIPlaceHolderTextView *commentTextView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *commentButton;
@end

@implementation OCBlurCommentView
-(void)dealloc{
#ifdef DEBUG
    NSLog(@"OCBlurView is dealloc");
#endif
}
+(void)showOCBlouCommenInView:(UIView *)aView
                     comments:(NSString *)comment
                  placeholder:(NSString *)placeholder
                        title:(NSString *)title
          onValueChangedBlock:(OCBlurCommentViewValueChangeBlock)valueChangeBlock
              completionBlock:(OCBlurCommentViewCompletionBlock)completionBlock{
    OCBlurCommentView *blurView=[[OCBlurCommentView alloc]  init];
    
    blurView.userInteractionEnabled=YES;
    [blurView addEventResponsors];
    blurView.backgroundColor=[UIColor colorWithWhite:0.2 alpha:0.6];
         blurView.commentTextView.placeholder=placeholder;
    if (comment) {
        blurView.commentTextView.text=comment;
    }else{
        blurView.commentTextView.text=@"";
    }

    blurView.commentButton.enabled=(comment!=nil)?YES:NO;
    if (title) {
        blurView.titleLabel.text=title;
    }else{
        blurView.titleLabel.text=@"写评论";
    }
    blurView.valueChangeBlock=valueChangeBlock;
    blurView.completionBlock=completionBlock;
    if (aView) {
        blurView.frame=aView.bounds;
        [aView addSubview:blurView];
    }else{
        blurView.frame=[UIApplication sharedApplication].keyWindow.bounds;
        [[UIApplication sharedApplication].keyWindow addSubview:blurView];
    }
    blurView.image=[UIImageEffects imageByApplyingLightEffectToImage:[OCBlurCommentView ScreenShot]];
    [blurView.commentTextView becomeFirstResponder];
}
+(UIImage *)ScreenShot
{
    UIView *aView=[UIApplication sharedApplication].keyWindow ;
    UIGraphicsBeginImageContextWithOptions(aView.bounds.size, YES, 0.0f);
    [aView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
-(void)didMoveToSuperview{
    [super didMoveToSuperview ];
    [self layoutIfNeeded];
}
#pragma mark -Privater selector
-(instancetype)init{
    if (self=[self initWithFrame:CGRectZero]) {
        
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame: frame]) {
        [self onInitUI];
    }
    return self;
}

-(void)onInitUI{
    __weak OCBlurCommentView *weakSelf=self;
    _sheetView = [[UIView alloc] init];
    _sheetView.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1];
    [self addSubview:_sheetView];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [cancelButton addTarget:self action:@selector(cancleComment) forControlEvents:UIControlEventTouchUpInside];
    [_sheetView addSubview:cancelButton];
    
    _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _commentButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
    [_commentButton setTitle:@"确定" forState:UIControlStateNormal];
    [_commentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _commentButton.titleLabel.font = [UIFont systemFontOfSize:14];
    _commentButton.enabled=NO;
    [_commentButton addTarget:self action:@selector(comment) forControlEvents:UIControlEventTouchUpInside];
    [_sheetView addSubview:_commentButton];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textAlignment=NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [_sheetView addSubview:_titleLabel];
    
    _commentTextView = [[UIPlaceHolderTextView alloc]  init];
    _commentTextView.placeholderColor=[UIColor lightGrayColor];
    _commentTextView.font=[UIFont systemFontOfSize:14];
    _commentTextView.layer.borderColor= [UIColor colorWithRed:202.0/255.0 green:202.0/255.0 blue:202.0/255.0 alpha:1].CGColor;
    _commentTextView.layer.borderWidth=0.5;
    _commentTextView.text = nil;
    _commentTextView.delegate=self;
    [_sheetView addSubview:_commentTextView];
    [_sheetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(weakSelf);
        make.height.mas_equalTo(OCBlurCommentViewHeight);
    }];
    
    
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_sheetView).offset(15);
        make.top.mas_equalTo(_sheetView.mas_top).offset(15);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    [_commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_sheetView.mas_right).offset(-15);
        make.top.mas_equalTo(cancelButton.mas_top);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(cancelButton.mas_top);
        make.left.mas_equalTo(cancelButton.mas_right);
        make.right.mas_equalTo(_commentButton.mas_left);
        make.top.height.mas_equalTo(cancelButton);
    }];
    [_commentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_sheetView.mas_left).offset(10);
        make.right.mas_equalTo(_sheetView.mas_right).offset(-10);
        make.bottom.mas_equalTo(_sheetView.mas_bottom).offset(-10);
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(15);
    }];
}
- (void)addEventResponsors
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)dismissCommentView
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_sheetView removeFromSuperview];
    [self removeFromSuperview];
}
-(void)comment{
    if (self.completionBlock) {
        self.completionBlock(self.commentTextView.text,NO);
    }
    [_sheetView endEditing:YES];
}
-(void)cancleComment{
    if (self.completionBlock) {
        self.completionBlock(self.commentTextView.text,YES);
    }
    [_sheetView endEditing:YES];
}
#pragma mark - Keyboard Notification Action
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    __weak OCBlurCommentView *weakSelf=self;
    CGFloat keyboardHeight = [[aNotification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    NSTimeInterval animationDuration = [[aNotification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:animationDuration animations:^{
        self.alpha = 1;
        [weakSelf.sheetView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.mas_bottom).offset(-keyboardHeight);
        }];
        [weakSelf layoutIfNeeded];
    } completion:nil];
}

- (void)keyboardWillHide:(NSNotification *)aNotification
{
    __weak OCBlurCommentView *weakSelf=self;
    NSDictionary *userInfo = [aNotification userInfo];
    NSTimeInterval animationDuration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:animationDuration animations:^{
        self.alpha = 0;
        [weakSelf.sheetView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.mas_bottom).offset(OCBlurCommentViewHeight);
        }];
        [weakSelf layoutIfNeeded];
    } completion:^(BOOL finished){
        [self dismissCommentView];
    }];
}
#pragma mark -UITouch
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *aTouch=[touches anyObject];
    if (aTouch.view ==self) {
        [self cancleComment];
    }
}
#pragma mark -textViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    _commentButton.enabled=textView.text.length>0?YES:NO;
    if (self.valueChangeBlock) {
        self.valueChangeBlock(textView.text);
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
