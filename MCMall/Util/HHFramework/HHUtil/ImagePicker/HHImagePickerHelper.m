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
@interface HHImagePickerHelper ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
@property(nonatomic,strong)UIImagePickerController *imagePickerController;
@property(nonatomic,assign)HHImagePickType pickType;
@end

@implementation HHImagePickerHelper
-(UIImagePickerController *)imagePickerController{
    if (nil==_imagePickerController) {
        _imagePickerController=[[UIImagePickerController alloc]  init];
        _imagePickerController.delegate=self;
    }
    return _imagePickerController;
}
-(void)showImagePickerWithType:(HHImagePickType)type onCompletionHandler:(DidFinishMediaOnCompledBlock)completionBlock{

    _pickType=type;
    UIViewController *rootController=[UIApplication sharedApplication].keyWindow.rootViewController;
    if (_pickType==HHImagePickTypeCamrea) {//相机
        BOOL isAvable=[UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        if (isAvable) {
            self.imagePickerController.sourceType=UIImagePickerControllerSourceTypeCamera;
            _imagePickerController.modalTransitionStyle=UIModalTransitionStyleCoverVertical;

            [rootController presentViewController:self.imagePickerController animated:YES completion:^{
                
            }];
            if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) {
                AVAuthorizationStatus  authoStatus=[AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
                if (([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) && (authoStatus==AVAuthorizationStatusDenied)) {
                    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
                    // app名称
                    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
                    NSString *message=[NSString stringWithFormat:@"请在iPhone的\"设置-隐私-相机\"选项中,允许%@访问你的相机",app_Name];
                    UIAlertView *alerView=[[UIAlertView alloc]  initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    [alerView show];
                }
            }
        }else{
            UIAlertView *alerView=[[UIAlertView alloc]  initWithTitle:@"提示" message:@"该设备不支持照相功能" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alerView show];
        }
    }else if (_pickType==HHImagePickTypeAblum){//相册
        self.imagePickerController.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        [rootController presentViewController:self.imagePickerController animated:YES completion:nil];
        if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) {
            ALAuthorizationStatus authoStatus = [ALAssetsLibrary authorizationStatus];
            if (([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) && (authoStatus==ALAuthorizationStatusDenied)) {
                NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
                // app名称
                NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
                NSString *message=[NSString stringWithFormat:@"请在iPhone的\"设置-隐私-相机\"选项中,允许%@访问你的相册",app_Name];
                UIAlertView *alerView=[[UIAlertView alloc]  initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
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
    UIImage *images=[info objectForKey:@"UIImagePickerControllerEditedImage"];
    [[SDImageCache sharedImageCache]  storeImage:images forKey:nil];
    //NSString *filePath=[self imagePathByWirteToCacheDiroctoryWithImage:dealImage];
    WEAKSELF
    [[UIApplication sharedApplication].keyWindow.rootViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark- actionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag==1000) {//上传照片
        if (buttonIndex==0) {//相机
            [self  showImagePickerWithType:HHImagePickTypeCamrea onCompletionHandler:^(UIImage *image, NSDictionary *editingInfo, NSString *imgPath) {
                
            }];
        }else if (buttonIndex==1){//相册
            [self  showImagePickerWithType:HHImagePickTypeAblum onCompletionHandler:^(UIImage *image, NSDictionary *editingInfo, NSString *imgPath) {
                
            }];
        }
    }
}
@end
