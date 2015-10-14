//
//  HHImagePickerHelper.m
//  MCMall
//
//  Created by Luigi on 15/6/4.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "HHImagePickerHelper.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "QBImagePickerController.h"
@interface HHImagePickerHelper ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,QBImagePickerControllerDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)UIImagePickerController *imagePickerController;
@property(nonatomic,strong)QBImagePickerController *qbImagePickerController;
@property(nonatomic,assign)HHImagePickType pickType;
@property(nonatomic,copy)DidFinishMediaOnCompledBlock completionBlock;
@property(nonatomic,assign)BOOL enableEdit;
@end

@implementation HHImagePickerHelper
-(UIImagePickerController *)imagePickerController{
    if (nil==_imagePickerController) {
        _imagePickerController=[[UIImagePickerController alloc]  init];
        _imagePickerController.delegate=self;
    }
    return _imagePickerController;
}
-(QBImagePickerController *)qbImagePickerController{
    if (nil==_qbImagePickerController) {
        _qbImagePickerController = [QBImagePickerController new];
        _qbImagePickerController.delegate = self;
        _qbImagePickerController.allowsMultipleSelection = NO;
        _qbImagePickerController.showsNumberOfSelectedAssets = NO;
    }
    return _qbImagePickerController;
}
-(UIViewController *)parentController{
    UIViewController *rootController=[UIApplication sharedApplication].keyWindow.rootViewController;
//    if ([rootController isKindOfClass:[UITabBarController class]]) {
//        
//    }else if ([rootController isKindOfClass:[UINavigationController class]]){
//    
//    }else if([rootController isKindOfClass:[UIViewController class]]){
//    
//    }
    if ([rootController isKindOfClass:[UIViewController class]]) {
        return rootController;
    }else{
        return nil;
    }
}
#pragma mark - select iamge
-(void)imagePickerButtonPressed{
    QBImagePickerController *imagePickerController = [QBImagePickerController new];
    imagePickerController.delegate = self;
    imagePickerController.allowsMultipleSelection = NO;
    imagePickerController.showsNumberOfSelectedAssets = NO;
    [[self parentController] presentViewController:imagePickerController animated:YES completion:NULL];
}
#pragma mark - qbimagecontroller delegate
- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didSelectAsset:(ALAsset *)asset{
    CGImageRef ciimage=[[asset defaultRepresentation] fullResolutionImage];
    NSString *loaclPath=[NSFileManager saveImage:[[UIImage alloc]  initWithCGImage:ciimage] presentation:0.5];
    self.enableEdit=NO;
    if (self.completionBlock) {
        self.completionBlock(loaclPath);
    }
    [[self parentController] dismissViewControllerAnimated:YES completion:NULL];
}
- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController{
    [[self parentController] dismissViewControllerAnimated:YES completion:NULL];
}

-(void)showImagePickerWithType:(HHImagePickType)type enableEdit:(BOOL)enableEdit onCompletionHandler:(DidFinishMediaOnCompledBlock)completionBlock{
    self.completionBlock=completionBlock;
    self.enableEdit=enableEdit;
    [self showImagePickerWithType:type];
}
-(void)showImagePickerWithType:(HHImagePickType)type{
    _pickType=type;
    UIViewController *rootController=[UIApplication sharedApplication].keyWindow.rootViewController;
    if (_pickType==HHImagePickTypeCamrea) {//相机
        BOOL isAvable=[UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        if (isAvable) {
            self.imagePickerController.sourceType=UIImagePickerControllerSourceTypeCamera;
            self.imagePickerController.allowsEditing=self.enableEdit;
            _imagePickerController.modalTransitionStyle=UIModalTransitionStyleCoverVertical;

            [rootController presentViewController:self.imagePickerController animated:YES completion:^{
                
            }];
            if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) {
                AVAuthorizationStatus  authoStatus=[AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
                if (([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) && (authoStatus==AVAuthorizationStatusDenied)) {
                    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
                    // app名称
                    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
                    NSString *message=[NSString stringWithFormat:@"请在iPhone的\"设置-隐私-相机\"选项中,允许\"%@\"访问你的相机",app_Name];
                    UIAlertView *alerView=[[UIAlertView alloc]  initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    alerView.tag=1000;
                    [alerView show];
                }
            }
        }else{
            UIAlertView *alerView=[[UIAlertView alloc]  initWithTitle:@"提示" message:@"该设备不支持照相功能" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alerView show];
        }
    }else if (_pickType==HHImagePickTypeAblum){//相册
//        [[self parentController] presentViewController:self.qbImagePickerController animated:YES completion:nil];
        self.imagePickerController.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        self.imagePickerController.allowsEditing=self.enableEdit;
        _imagePickerController.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
        [rootController presentViewController:self.imagePickerController animated:YES completion:^{
            
        }];
        if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) {
            ALAuthorizationStatus authoStatus = [ALAssetsLibrary authorizationStatus];
            if (([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) && (authoStatus==ALAuthorizationStatusDenied)) {
                NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
                // app名称
                NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
                NSString *message=[NSString stringWithFormat:@"请在iPhone的\"设置-隐私-相机\"选项中,允许\"%@\"访问你的相册",app_Name];
                UIAlertView *alerView=[[UIAlertView alloc]  initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                alerView.tag=1000;
                [alerView show];
            }
        }
    }else if (_pickType==HHImagePickTypeAll){//相机和相册
        UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:@"上传图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照上传" otherButtonTitles:@"相册上传", nil];
        actionSheet.tag=1000;
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    }
}
#pragma mark -选取照片并上传
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *orignalImage=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
    NSString *loaclPath=[NSFileManager saveImage:orignalImage presentation:0.5];
    self.enableEdit=NO;
    if (self.completionBlock) {
        self.completionBlock(loaclPath);
    }
    [[self parentController] dismissViewControllerAnimated:YES completion:NULL];
}
#pragma mark- actionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag==1000) {//上传照片
        if (buttonIndex==0) {//相机
            [self showImagePickerWithType:HHImagePickTypeCamrea];
        }else if (buttonIndex==1){//相册
            [self showImagePickerWithType:HHImagePickTypeAblum];
        }
    }
}
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (alertView.tag==1000) {
        [[self parentController] dismissViewControllerAnimated:YES completion:NULL];
    }
}
@end
