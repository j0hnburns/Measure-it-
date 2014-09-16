//
//  PhotoReciverView.m
//  Measure Anything
//
//  Created by idomechi on 9/24/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "PhotoReciverViewController.h"


@implementation PhotoReciverViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization

    }
    return self;
}


-(void) chooseSource
{
	[imageView removeFromSuperview];
	imageView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default.png"]];
	[self.view addSubview:imageView];
	[imageView release];
	
	UIAlertView* alert;
	if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
	{
		alert = [[UIAlertView alloc] initWithTitle:@"Select an object to measure" message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Camera",@"Photos",nil];
		[alert show];
		[alert release];
	}
	else
	{
		[self alertView:nil clickedButtonAtIndex:0];
	}
	

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	UIImagePickerControllerSourceType     sourceType;
	
	if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
   {
		if(buttonIndex)
			sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
		else
			sourceType = UIImagePickerControllerSourceTypeCamera;
   }
	else
		sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
				


	pickerController = [[UIImagePickerController alloc]init];
	pickerController.sourceType = sourceType;
	pickerController.delegate = self;
	[self presentModalViewController:pickerController animated:YES];
	[pickerController release];
	
				
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	UIImage* image =	[info objectForKey:UIImagePickerControllerOriginalImage];
	imageReciver = [[ImageReciverController alloc] initWithImage:image];
	[self.view addSubview:imageReciver.view];
	[picker dismissModalViewControllerAnimated:YES];
	[imageView removeFromSuperview];
}



- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[picker dismissModalViewControllerAnimated:YES];
	[imageView removeFromSuperview];
	[self performSelector:@selector(chooseSource) withObject:nil afterDelay:1];
	imageView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default.png"]];
	[self.view addSubview:imageView];
	[imageView release];
}

- (void)dealloc {
	
#if DEBUG
	NSLog(@"photo reciver dealloc %d",[imageReciver retainCount]);
#endif
	
	[imageReciver.view removeFromSuperview];
	
	[imageReciver release];

	
    [super dealloc];
}

@end
