//
//  OCCommentView.m
//  OpenCourse
//
//  Created by Luigi on 15/8/19.
//
//

#import "OCCommentView.h"
#import "OCBlurCommentView.h"
@interface OCCommentView ()
@property(nonatomic,strong) UIButton    *sendButton;
@property(nonatomic,strong) UIButton    *commentButton;
@property(nonatomic,weak)   UIView *parentView;
@property(nonatomic,strong) OCBlurCommentView *blurCommentView;
@end

@implementation OCCommentView
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
      [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}
-(instancetype)init{
    self=[self initWithFrame:CGRectZero];
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self onInitUI];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame parentView:(UIView *)aView{
    self=[self initWithFrame:frame];
    _parentView=aView;
    return self;
}
-(void)onInitUI{
    
    CGFloat sendButtonHeight=30;
    self.backgroundColor=[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1];
    _commentButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _commentButton.backgroundColor=[UIColor whiteColor];
    [_commentButton setTitle:@"添加评论" forState:UIControlStateNormal];
    [_commentButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _commentButton.titleLabel.font=[UIFont systemFontOfSize:14];
    _commentButton.tag=1001;
    [_commentButton addTarget:self action:@selector(didPublishCommentButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_commentButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_commentButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    _commentButton.layer.cornerRadius=10;
    _commentButton.layer.masksToBounds=YES;
    _commentButton.layer.borderColor=[UIColor darkGrayColor].CGColor;
    _commentButton.layer.borderWidth=0.5;
    [self addSubview:_commentButton];

    
    
    _sendButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [_sendButton setTitle:@"回复" forState:UIControlStateNormal];
    [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _sendButton.titleLabel.font=[UIFont systemFontOfSize:14];
    _sendButton.tag=1001;
    _sendButton.enabled=NO;
    [_sendButton setBackgroundColor:MCMallThemeColor];
    [_sendButton addTarget:self action:@selector(didPublishCommentButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    _sendButton.layer.cornerRadius=6;
    _sendButton.layer.masksToBounds=YES;
    [self addSubview:_sendButton];
    WEAKSELF
    [_commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(5);
        make.bottom.mas_equalTo(weakSelf.mas_bottom).offset(-5);
    }];
    [_sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.mas_right).offset(-10);
        make.top.mas_equalTo(5);
        make.size.mas_equalTo(CGSizeMake(60, sendButtonHeight));
        make.left.mas_equalTo(_commentButton.mas_right).offset(10);
    }];

}
#pragma mark -setter getter
-(void)setCommentContent:(NSString *)commentContent{
    _commentContent=commentContent;
    if (_commentContent) {
        [self.commentButton setTitle:_commentContent forState:UIControlStateNormal];
    }else{
        [self.commentButton setTitle:_placeholer forState:UIControlStateNormal];
    }
}
-(void)setPlaceholer:(NSString *)placeholer{
    if (nil==placeholer) {
        _placeholer=@"";
    }else{
    _placeholer=placeholer;
    }
    [self.commentButton setTitle:placeholer forState:UIControlStateNormal];
}
-(OCBlurCommentView *)blurCommentView{
    if (nil==_blurCommentView) {
        _blurCommentView=[OCBlurCommentView blurCommentView];
    }
    return _blurCommentView;
}


-(void)handCommentTextFiledValueChagned:(UITextField *)textField{
    self.sendButton.enabled=textField.text.length>0?YES:NO;
}
-(void)didPublishCommentButtonPressed:(UIButton *)sender{
    if (sender==_commentButton) {
        WEAKSELF
        [OCBlurCommentView showOCBlouCommenInView:self.parentView comments:self.commentContent placeholder:self.placeholer title:nil onValueChangedBlock:^(NSString *comments) {
            if (weakSelf.valueChangedBlock) {
                weakSelf.valueChangedBlock(comments);
            }
            weakSelf.commentContent=comments;
        } completionBlock:^(NSString *comments, BOOL isCancled) {
            if (weakSelf.completionBlock ) {
                weakSelf.completionBlock(comments,isCancled);
            }
        }];
    }else if (sender==_sendButton){
        if (self.completionBlock ) {
            self.completionBlock(self.commentContent,NO);
        }
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
