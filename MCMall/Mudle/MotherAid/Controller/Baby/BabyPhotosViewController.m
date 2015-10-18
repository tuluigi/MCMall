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
#import "HHFlowView.h"
#import "AddBabPhotoMemoController.h"
#define     kCollectionIdedtifer   @"collectionViewCellIdentifer"
#define  kCollectionViewColum   3
@interface BabyPhotosViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,HHFlowViewDelegate>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)__block NoteModel *noteModel;
@property(nonatomic,strong)HHImagePickerHelper *imagePickerHelper;
@property (nonatomic,strong)HHFlowView *flowView;
@property(nonatomic,strong)UIToolbar *tooBar;
@property(nonatomic,strong)UITextView *contentTextView;
@end

@implementation BabyPhotosViewController
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(HHFlowView *)flowView{
    if (nil==_flowView) {
        _flowView=[[HHFlowView alloc]  initWithFrame:CGRectMake(0, 0,CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
        _flowView.delegate=self;
        [_flowView setContentImageViewModel:UIViewContentModeScaleAspectFit];
        _flowView.flowViewDidSelectedBlock=^(HHFlowModel *flowMode, NSInteger index){
            
        };
    }
    return _flowView;
}
-(void)flowViewDidScrollToIndex:(NSUInteger)index{
    BabyPhotoModel *babyModel=[self.noteModel.photoArrays objectAtIndexedSubscript:index];
    self.contentTextView.text=babyModel.noteContent;
    self.title=[NSString stringWithFormat:@"宝宝相册(%ld/%ld)",(self.flowView.currenttage+1),self.noteModel.photoArrays.count];
}
-(UIToolbar *)tooBar{
    if (nil==_tooBar) {
        _tooBar=[[UIToolbar alloc]  init];
        _tooBar.barStyle=UIBarStyleBlack;
        UIBarButtonItem *spaceBarButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        spaceBarButton.tag=101;
        UIBarButtonItem *editBarButton=[[UIBarButtonItem alloc]  initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(didEditBarButtonPressed)];
        editBarButton.tag=1001;
        UIBarButtonItem *deleteBarButton=[[UIBarButtonItem alloc]  initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(didDeletePhotoButtonPressed)];
        deleteBarButton.tag=1002;
        _tooBar.items=@[spaceBarButton,editBarButton,spaceBarButton,deleteBarButton,spaceBarButton];
    }
    return _tooBar;
}
-(UITextView *)contentTextView{
    if (nil==_contentTextView) {
        _contentTextView=[[UITextView alloc]  init];
        _contentTextView.backgroundColor=[UIColor colorWithWhite:0.4 alpha:0.4];
        _contentTextView.textColor=[UIColor whiteColor];
        _contentTextView.font=[UIFont systemFontOfSize:14];
        _contentTextView.editable=NO;
    }
    return _contentTextView;
}
-(void)didEditBarButtonPressed{
    WEAKSELF
    __block BabyPhotoModel *babayPhotoModel=[self.noteModel.photoArrays objectAtIndex:self.flowView.currenttage];
    AddBabPhotoMemoController *addMemoController=[[AddBabPhotoMemoController alloc]  initWithNoteID:babayPhotoModel.noteID photoID:babayPhotoModel.lineID content:babayPhotoModel.noteContent];
    addMemoController.hidesBottomBarWhenPushed=YES;
    addMemoController.contentChangedBlock=^(NSString *content ,NSString *photoID ,NSString *noteID){
        babayPhotoModel.noteContent=content;
        weakSelf.contentTextView.text=babayPhotoModel.noteContent;
    };
    [self.navigationController pushViewController:addMemoController animated:YES];
}
-(void)didDeletePhotoButtonPressed{
    WEAKSELF
    [self.view showLoadingState];
    BabyPhotoModel *babayPhotoModel=[self.noteModel.photoArrays objectAtIndex:self.flowView.currenttage];
    HHNetWorkOperation *op=[MotherAidNetService deleteBabayPhotoWithUserID:[HHUserManager userID] noteID:babayPhotoModel.noteID lineID:babayPhotoModel.lineID onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCodeSuccess) {
            [weakSelf.noteModel.photoArrays removeObjectAtIndex:weakSelf.flowView.currenttage];
            NSInteger index=weakSelf.flowView.currenttage;
            if (weakSelf.removeBabyPhotoBlock) {
                weakSelf.removeBabyPhotoBlock(index);
            }
            if (weakSelf.noteModel.photoArrays.count==0) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                NSMutableArray *photoArray=weakSelf.flowView.dataArry;
                [photoArray removeObjectAtIndex:weakSelf.flowView.currenttage];
                weakSelf.flowView.dataArry=photoArray;
                [weakSelf flowViewDidScrollToIndex:weakSelf.flowView.currenttage];
            }
            [weakSelf.view showErrorMssage:responseResult.responseMessage];
        }
    }];
    [self addOperationUniqueIdentifer:op.uniqueIdentifier];
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
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.noteModel) {
        [self reloadFlowView];
    }
   
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor red:42 green:41 blue:41 alpha:1];
    [self.view addSubview:self.flowView];
    [self.view addSubview:self.tooBar];
    [self.view addSubview:self.contentTextView];
    WEAKSELF
    [self.flowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(weakSelf.view);
        make.bottom.mas_equalTo(weakSelf.tooBar.mas_top);
    }];
    [self.tooBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf.view);
        make.bottom.mas_equalTo(weakSelf.view);
        make.height.mas_equalTo(45);
    }];
    [self.contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.view);
        make.right.mas_equalTo(weakSelf.view);
        make.bottom.mas_equalTo(weakSelf.tooBar.mas_top);
        make.height.mas_equalTo(70);
    }];
    [self reloadFlowView];
    /*
     
     [self.view addSubview:self.collectionView];
     [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
     make.edges.mas_equalTo(UIEdgeInsetsZero);
     }];
     [self.collectionView reloadData];
     */
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

-(void)setNoteModel:(NoteModel *)noteModel{
    _noteModel=noteModel;
}
-(void)reloadFlowView{
    NSMutableArray *photoImageArray=[[NSMutableArray alloc] init];
    for (BabyPhotoModel *babyPhotoModel in self.noteModel.photoArrays) {
        HHFlowModel *flowModel=[[HHFlowModel alloc]  init];
        flowModel.flowImageUrl=babyPhotoModel.noteImageUrl;
        [photoImageArray addObject:flowModel];
    }
    self.flowView.dataArry = photoImageArray;
    if (photoImageArray.count) {
        [self flowViewDidScrollToIndex:0];
    }
    
}
-(void)uploadBabyPhoto{
    WEAKSELF
    [self.imagePickerHelper showImagePickerWithType:HHImagePickTypeAll enableEdit:NO  onCompletionHandler:^(NSString *imgPath) {
        [MotherAidNetService uploadBabayPhotoWithUserID:[HHUserManager userID] noteID:nil phtoPath:imgPath uploadProgress:^(CGFloat progress) {
            [weakSelf.view showProgress:progress];
        }  onCompletionHandler:^(HHResponseResult *responseResult) {
            if (responseResult.responseCode==HHResponseResultCodeSuccess) {
                [weakSelf getDiaryDetailAtDate:weakSelf.noteModel.date];
                [weakSelf.view dismissHUD];
            }else{
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
                //                [weakSelf.collectionView reloadData];
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
