//
//  OCPageLoadAnimationView.h
//  OpenCourse
//
//  Created by Luigi on 15/8/31.
//
//

#import "OCPageLoadView.h"
UIKIT_EXTERN NSString *const OCPageLoadViewImageKey;
UIKIT_EXTERN NSString *const OCPageLoadingAnimationImagesKey;
UIKIT_EXTERN NSString *const OCPageLoadingAnimationDurationKey;

@interface OCPageLoadAnimationView : OCPageLoadView
+(OCPageLoadAnimationView *)defaultPageLoadView;
@end
