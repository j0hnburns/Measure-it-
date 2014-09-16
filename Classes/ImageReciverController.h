//
//  ImageReciverController.h
//  Measure Anything
//
//  Created by idomechi on 9/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MultiTouchView.h"
#import "ScalingView.h"
#import "DownMenu.h"

@interface ImageReciverController : UIViewController {

	UIImageView * backgroundView;
	UIImageView * scalingView;
	ScalingView * menu;
	DownMenu * downmenu;
	MultiTouchView * zoomedView;
	
}
- (UIImage*)rotateImage:(UIImage*)img byOrientationFlag:(UIImageOrientation)orient;
- (UIImage *)imageByScalingProportionallyToMinimumSize:(CGSize)targetSize  rotateImage:(UIImage *)sourceImage;
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize   rotateImage:(UIImage *)sourceImage;
- (void) menuAppear;
- (void) invisibleMenu:(BOOL) visible;
@end
