//
//  UIPlaceHolderTextView.h
//  CloudAlbum_iPhone
//
//  Created by ios on 11-9-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIPlaceHolderTextView : UITextView {
    NSString *placeholder;
	UIColor *placeholderColor;
		
@private
	UILabel *placeHolderLabel;
}
@property (nonatomic, strong) UILabel *placeHolderLabel;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholderColor;
@property (nonatomic, assign) CGPoint position;
	
-(void)textChanged:(NSNotification*)notification;
	
@end
	
	

