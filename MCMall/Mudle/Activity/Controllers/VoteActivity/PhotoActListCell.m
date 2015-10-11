//
//  PhotoActListCell.m
//  MCMall
//
//  Created by Luigi on 15/7/1.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "PhotoActListCell.h"
#import "ActivityModel.h"
@interface PhotoActListCell ()

@property(nonatomic,strong)UIImageView *imageView0,*imageView1,*imageView2;
@end

@implementation PhotoActListCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self onInitUI];
    }
    return self;
}
-(void)onInitUI{
    _imageView0=[[UIImageView alloc]  init];
    _imageView0.contentMode=UIViewContentModeScaleToFill;
    [self.contentView addSubview:_imageView0];
    _imageView0.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapGesture0=[[UITapGestureRecognizer alloc]  initWithTarget:self action:@selector(didImageViewTaped:)];
    [_imageView0 addGestureRecognizer:tapGesture0];
    
    _imageView1=[[UIImageView alloc]  init];
    _imageView1.contentMode=UIViewContentModeScaleToFill;
    [self.contentView addSubview:_imageView1];
    _imageView1.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapGesture1=[[UITapGestureRecognizer alloc]  initWithTarget:self action:@selector(didImageViewTaped:)];
    [_imageView1 addGestureRecognizer:tapGesture1];
    
    _imageView2=[[UIImageView alloc]  init];
    _imageView2.contentMode=UIViewContentModeScaleToFill;
    [self.contentView addSubview:_imageView2];
    _imageView2.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapGesture2=[[UITapGestureRecognizer alloc]  initWithTarget:self action:@selector(didImageViewTaped:)];
    [_imageView2 addGestureRecognizer:tapGesture2];
    
    
    CGFloat pading=1.0;
    CGFloat imageViewWidth=(CGRectGetWidth([UIScreen mainScreen].bounds)-pading*2)/3.0;
    WEAKSELF
    [_imageView0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.contentView.mas_top).offset(pading);
        make.left.bottom.mas_equalTo(weakSelf);
        //make.right.mas_equalTo(_imageView1.left).offset(pading);
        make.width.mas_equalTo(CGSizeMake(imageViewWidth, imageViewWidth));
    }];
    [_imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_imageView0.mas_right).offset(pading);
        make.bottom.top.mas_equalTo(_imageView0);
        make.width.mas_equalTo(_imageView0);
    }];
    [_imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_imageView1.mas_right).offset(pading);
        make.top.bottom.mas_equalTo(_imageView0);
        make.right.mas_equalTo(weakSelf.contentView.mas_right);
    }];
}

-(void)setPhotoArray:(NSArray *)photoArray{
    _photoArray=photoArray;
    _imageView0.image=nil;
    _imageView1.image=nil;
    _imageView2.image=nil;
    for (NSInteger i=0; i<_photoArray.count ; i++) {
        PhotoModel *photoModel=[_photoArray objectAtIndex:i];
        UIImageView *imageView;
        if (i==0) {
            imageView=_imageView0;
        }else if (i==1){
            imageView=_imageView1;
        }else if (i==2){
            imageView=_imageView2;
        }
        [imageView sd_setImageWithURL:[NSURL URLWithString:photoModel.photoUrl] placeholderImage:MCMallDefaultImg];
        
    }
}
-(void)didImageViewTaped:(UITapGestureRecognizer *)tapGestre{
    UIImageView *imageView=(UIImageView *)tapGestre.view;
    PhotoModel *photoModel;
    if (imageView==_imageView0) {
        if (self.photoArray.count>=1) {
            photoModel=[self.photoArray objectAtIndex:0];
        }
    }else if (imageView==_imageView1){
        if (self.photoArray.count>=2) {
            photoModel=[self.photoArray objectAtIndex:1];
        }
    }else if (imageView==_imageView2){
        if (self.photoArray.count>=3) {
            photoModel=[self.photoArray objectAtIndex:2];
        }
    }
    if (photoModel) {
        if (_delegate&&[_delegate respondsToSelector:@selector(photoListCellDidSelectedWithPhotoModel:)]) {
            [_delegate photoListCellDidSelectedWithPhotoModel:photoModel];
        }
    }

}
+(CGFloat)photoListCellHeight{
    CGFloat pading=1.0;
    CGFloat imageViewWidth=(CGRectGetWidth([UIScreen mainScreen].bounds)-pading*2)/3.0;
    return imageViewWidth;
}
@end
