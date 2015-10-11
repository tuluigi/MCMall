//
//  BabyPhotosViewController.m
//  MCMall
//
//  Created by Luigi on 15/10/1.
//  Copyright © 2015年 Luigi. All rights reserved.
//

#import "BabyPhotosViewController.h"
#import "BabyPhotCollectionViewCell.h"
#import "NoteModel.h"
#import "MotherAidNetService.h"
#import "HHImagePickerHelper.h"
#import "HHPhotoBroswer.h"
#define     kCollectionIdedtifer   @"collectionViewCellIdentifer"
#define  kCollectionViewColum   3
@interface BabyPhotosViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NoteModel *noteModel;
@property(nonatomic,strong)HHImagePickerHelper *imagePickerHelper;
@end

@implementation BabyPhotosViewController
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UICollectionView *)collectionView{
    if (nil==_collectionView) {
        UICollectionViewFlowLayout *collectionViewLayout=[[UICollectionViewFlowLayout alloc] init];
        
        _collectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:collectionViewLayout];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        
        [_collectionView registerClass:[BabyPhotCollectionViewCell class] forCellWithReuseIdentifier:kCollectionIdedtifer];
        [_collectionView reloadData];
        _collectionView.backgroundColor=[UIColor clearColor];
    }
    return _collectionView;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title=@"宝宝相册";
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]  initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(uploadBabyPhoto)];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self.collectionView reloadData];
}
-(instancetype)initWithNoteModle:(NoteModel *)noteModel;{
    if (self==[super init]) {
        _noteModel=noteModel;
    }
    return self;
}
-(HHImagePickerHelper *)imagePickerHelper{
    if (nil==_imagePickerHelper) {
        _imagePickerHelper=[[HHImagePickerHelper alloc]  init];
    }
    return _imagePickerHelper;
}
-(void)uploadBabyPhoto{
        WEAKSELF
        [self.imagePickerHelper showImagePickerWithType:HHImagePickTypeAll onCompletionHandler:^(NSString *imgPath) {
            [MotherAidNetService uploadBabayPhotoWithUserID:[HHUserManager userID] noteID:nil phtoPath:imgPath onCompletionHandler:^(HHResponseResult *responseResult) {
                if (responseResult.responseCode==HHResponseResultCodeSuccess) {
                    [weakSelf getDiaryDetailAtDate:weakSelf.noteModel.date];
                }
                if (responseResult.responseCode!=HHResponseResultCodeSuccess) {
                   [weakSelf.view showSuccessMessage:responseResult.responseMessage];
                }
            }];
        }];
}
-(void)getDiaryDetailAtDate:(NSDate *)date{
    WEAKSELF
    if ([HHUserManager isLogin]) {
        HHNetWorkOperation *op=[MotherAidNetService getBabyPhotoListUserID:[HHUserManager userID] date:date onCompletionHandler:^(HHResponseResult *responseResult) {
            weakSelf.noteModel=responseResult.responseData;

            if (responseResult.responseCode==HHResponseResultCodeSuccess) {
                [weakSelf.collectionView reloadData];
            }
        }];
        [self addOperationUniqueIdentifer:op.uniqueIdentifier];
    }else{

    }
}

#pragma mark- collectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger row=self.noteModel.photoArrays.count;
    return row;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BabyPhotCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:kCollectionIdedtifer forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    cell.babyPhotoModel=[self.noteModel.photoArrays objectAtIndex:indexPath.row];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat width=(CGRectGetWidth([[UIScreen mainScreen] bounds])-(kCollectionViewColum+1)*10)/kCollectionViewColum;
    return CGSizeMake(width, width);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
/*
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
*/
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *imageArray=[NSMutableArray new];
    for (BabyPhotoModel *photoModel in self.noteModel.photoArrays) {
        [imageArray addObject:photoModel.noteImageUrl];
    }
    [[HHPhotoBroswer sharedPhotoBroswer] showBrowserWithImages:imageArray atIndex:indexPath.row];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
