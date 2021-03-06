//
//  OCPageLoadAnimationView.m
//  OpenCourse
//
//  Created by Luigi on 15/8/31.
//
//

#import "OCPageLoadAnimationView.h"
NSString *const OCPageLoadViewImageKey               =@"OCPageLoadingImageKey";
NSString *const OCPageLoadingAnimationImagesKey    =@"OCPageLoadingAnimationImagesKey";
NSString *const OCPageLoadingAnimationDurationKey  =@"OCPageLoadingAnimationDurationKey";
@interface OCPageLoadAnimationView ()
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel      *textLable;
@property(nonatomic,strong)UIActivityIndicatorView *indecatorView;
@end

@implementation OCPageLoadAnimationView
+(OCPageLoadAnimationView *)defaultPageLoadView{
    OCPageLoadAnimationView *pageView=[[OCPageLoadAnimationView alloc]  init];
    return pageView;
}
-(void)onInitUI{
    [super onInitUI];
//    _imageView=[UIImageView new];
//    [self addSubview:_imageView];
    _indecatorView=[[UIActivityIndicatorView alloc]  initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _indecatorView.hidesWhenStopped=YES;
    [self addSubview:_indecatorView];
    _textLable=[[UILabel alloc]  init];
    _textLable.textAlignment=NSTextAlignmentCenter;
    _textLable.font=[UIFont systemFontOfSize:14];
    _textLable.textColor=[UIColor colorWithRed:138/255.0 green:138/255.0 blue:138/255.0 alpha:1];
    [self addSubview:_textLable];
    __weak OCPageLoadAnimationView *weakSelf=self;
//    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.bottom.mas_equalTo(weakSelf.mas_centerY).offset(-20);
//        make.centerX.mas_equalTo(weakSelf.mas_centerX);
//        make.size.mas_lessThanOrEqualTo(CGSizeMake(200, 200));
//    }];
    [_indecatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.mas_centerY).offset(-20);
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.size.mas_lessThanOrEqualTo(CGSizeMake(30, 30));
    }];
    [_textLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_indecatorView.mas_bottom).offset(10);
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.height.mas_equalTo(20);
    }];
}

-(void)showLoadingData:(NSDictionary *)dic inView:(UIView *)aView delegate:(id)delegate{
    [super showLoadingData:dic inView:aView delegate:delegate];
    if (dic) {
        if ([dic objectForKey:OCPageLoadingAnimationImagesKey]) {
            self.imageView.image=nil;
            self.imageView.animationImages=[dic objectForKey:OCPageLoadingAnimationImagesKey];
            self.imageView.animationDuration=[[dic objectForKey:OCPageLoadingAnimationDurationKey] floatValue];
            [self.imageView startAnimating];
        }else if ([dic objectForKey:OCPageLoadViewImageKey]){
            self.imageView.animationImages=nil;
            [self.imageView stopAnimating];
            self.imageView.image=[dic objectForKey:OCPageLoadViewImageKey];
        }
        BOOL isLoading=[[dic objectForKey:OCPageLoadViewIsLoadingKey] boolValue];
        if (isLoading) {
            [self.indecatorView startAnimating];
        }else{
            [self.indecatorView stopAnimating];
        }
        
        self.textLable.text=[dic objectForKey:OCPageLoadViewTexKey];
    }
}
-(void)dismiss{
    [self.indecatorView stopAnimating];
    [self.imageView stopAnimating];
    [super dismiss];
}
@end
