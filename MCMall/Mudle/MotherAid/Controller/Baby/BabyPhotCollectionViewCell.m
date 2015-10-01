//
//  BabyPhotCollectionViewCell.m
//  MCMall
//
//  Created by Luigi on 15/10/1.
//  Copyright © 2015年 Luigi. All rights reserved.
//

#import "BabyPhotCollectionViewCell.h"
#import "NoteModel.h"
@interface BabyPhotCollectionViewCell ()
@property(nonatomic,strong)UIImageView *photoImageView;
@end

@implementation BabyPhotCollectionViewCell
-(instancetype)init{
    self=[super initWithFrame:CGRectZero];
    if (self) {
        
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self onInitView];
    }
    return self;
}
-(void)onInitView{
    _photoImageView=[[UIImageView alloc] init];
    [self.contentView addSubview:_photoImageView];
    
    [_photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}
-(void)setBabyPhotoModel:(BabyPhotoModel *)babyPhotoModel{
    _babyPhotoModel=babyPhotoModel;
    [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:babyPhotoModel.noteImageUrl] placeholderImage:MCMallDefaultImg];
}
@end
