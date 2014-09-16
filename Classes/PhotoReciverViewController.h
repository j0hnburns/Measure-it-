//
//  PhotoReciverView.h
//  Measure Anything
//
//  Created by idomechi on 9/24/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageReciverController.h"

@interface PhotoReciverViewController: UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate>{

		UIImagePickerController *pickerController;
		ImageReciverController * imageReciver;
		UIImageView * imageView;
}
-(void) chooseSource;
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
@end
