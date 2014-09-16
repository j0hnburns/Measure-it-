//
//  ImageReciverController.m
//  Measure Anything
//
//  Created by idomechi on 9/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ImageReciverController.h"
#import "Measure_it_AppDelegate.h"

@implementation ImageReciverController

- (id)initWithImage:(UIImage*) image
{
	if (self = [self initWithNibName:nil bundle:nil]) {
		self.view.backgroundColor = [UIColor blackColor];// [UIColor colorWithWhite:0.15 alpha:1];

		UIImage * newimage = [self imageByScalingProportionallyToSize:CGSizeMake(320,480)  rotateImage:image];

		backgroundView = [[UIImageView alloc] initWithImage:newimage];
		[self.view addSubview: backgroundView];
		backgroundView.center = CGPointMake(160,240);
		
		menu = [[ScalingView alloc] initWithFrame:CGRectZero];
		[menu setDelegate:self];
		
		downmenu = [[DownMenu alloc] initWithTarget:self];
		[self.view addSubview:downmenu];
		downmenu.center = CGPointMake(160,480-downmenu.frame.size.height/2);
		[downmenu release];
		
		zoomedView = nil;
		
		[self menuAppear];

    }
    return self;
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(zoomedView.state == STATE_SCALE)
	{
		[zoomedView initSetbutton];
		[downmenu setActive:1];
	}
	else
	{
		[zoomedView initSetmenu];
		[downmenu setActive:2];
	}
}


-(void)chooseAction:(UIButton*) button{

	[((Measure_it_AppDelegate*)[[UIApplication sharedApplication] delegate]) restart];

}
-(void)scaleAction:(UIButton*) button{

	if(downmenu.currentActive>1)
	{

		[zoomedView removeFromSuperview];
		zoomedView = nil;
		menu = [[ScalingView alloc] initWithFrame:CGRectZero];
		[menu setDelegate:self];
		[self menuAppear];
		[downmenu setActive:1];
	}
}


-(void)measureAction:(UIButton*) button{
	[downmenu setActive:2];
	[zoomedView clearAction:nil];
}

- (void) invisibleMenu:(BOOL) visible
{
	downmenu.hidden = visible;
}

- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize   rotateImage:(UIImage *)sourceImage{
	
	UIImage *newImage = nil;
	
	CGSize imageSize = sourceImage.size;
	CGFloat width = imageSize.width;
	CGFloat height = imageSize.height;
	
	CGFloat targetWidth = targetSize.width;
	CGFloat targetHeight = targetSize.height;
	
	CGFloat scaleFactor = 0.0;
	CGFloat scaledWidth = targetWidth;
	CGFloat scaledHeight = targetHeight;
	
	CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
	
	if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
		
		CGFloat widthFactor = targetWidth / width;
		CGFloat heightFactor = targetHeight / height;
		
		if (widthFactor < heightFactor)
			scaleFactor = widthFactor;
		else
			scaleFactor = heightFactor;
		
		scaledWidth  = width * scaleFactor;
		scaledHeight = height * scaleFactor;
		
		// center the image
		
		if (widthFactor < heightFactor) {
			thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
		} else if (widthFactor > heightFactor) {
			thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
		}
	}
	
	
	// this is actually the interesting part:
	
	UIGraphicsBeginImageContext(targetSize);
	
	CGRect thumbnailRect = CGRectZero;
	thumbnailRect.origin = thumbnailPoint;
	thumbnailRect.size.width  = scaledWidth;
	thumbnailRect.size.height = scaledHeight;
	
	[sourceImage drawInRect:thumbnailRect];
	
	newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	if(newImage == nil) NSLog(@"could not scale image");
	
	
	return newImage ;
}

- (UIImage*)rotateImage:(UIImage*)img byOrientationFlag:(UIImageOrientation)orient
{
    CGImageRef          imgRef = img.CGImage;
    CGFloat             width = CGImageGetWidth(imgRef);
    CGFloat             height = CGImageGetHeight(imgRef);
    CGAffineTransform   transform = CGAffineTransformIdentity;
    CGRect              bounds = CGRectMake(0, 0, width, height);
    CGSize              imageSize = bounds.size;
    CGFloat             boundHeight;
 
    switch(orient) {
 
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
 
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
 
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
			transform = CGAffineTransformScale(transform, -1.0, 1.0);
			transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;

        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
			transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
           break;

		default:
           // image is not auto-rotated by the photo picker, so whatever the user
			// sees is what they expect to get. No modification necessary
          transform = CGAffineTransformIdentity;
          break;
 
    }
 
    UIGraphicsBeginImageContext(bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    if ((orient == UIImageOrientationDown) || (orient == UIImageOrientationRight) || (orient == UIImageOrientationUp)){
       // flip the coordinate space upside down
        CGContextScaleCTM(context, 1, -1);
        CGContextTranslateCTM(context, 0, -height);
    }
 
    CGContextConcatCTM(context, transform);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
 
    return imageCopy;
}

- (UIImage *)scaleAndRotateImage:(UIImage *)image //orient:(UIImageOrientation) orient
{
	float kMaxResolution = 320; // Or whatever
	float kMaxResolutionH = 480;
	
	CGImageRef imgRef = image.CGImage;
	
	CGFloat width = CGImageGetWidth(imgRef);
	CGFloat height = CGImageGetHeight(imgRef);

	
	//NSLog(@"width %f height %f",width,height);
	
	CGAffineTransform transform = CGAffineTransformIdentity;
	CGRect bounds = CGRectMake(0, 0, width, height);
	if (width > kMaxResolution || height > kMaxResolutionH) {
		CGFloat ratio = width/height;
		CGFloat kRatio = ((float)kMaxResolution)/kMaxResolutionH;
		NSLog(@"ratio %f kRatio %f",ratio,kRatio);
		if (ratio > kRatio) {
			bounds.size.width = kMaxResolution;
			bounds.size.height = bounds.size.width / ratio;
			NSLog(@"height %f",bounds.size.height);
		}
		else {
			bounds.size.height = kMaxResolutionH;
			bounds.size.width = bounds.size.height * ratio;
			NSLog(@"width %f",bounds.size.width);
		}
	}
	
	CGFloat scaleRatio = bounds.size.width / width;
	CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
	CGFloat boundHeight;
	UIImageOrientation orient = image.imageOrientation;
	switch(orient) {
			
		case UIImageOrientationUp: //EXIF = 1
			transform = CGAffineTransformIdentity;
			break;
			
		case UIImageOrientationUpMirrored: //EXIF = 2
			transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
			transform = CGAffineTransformScale(transform, -1.0, 1.0);
			break;
			
		case UIImageOrientationDown: //EXIF = 3
			transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
			transform = CGAffineTransformRotate(transform, M_PI);
			break;
			
		case UIImageOrientationDownMirrored: //EXIF = 4
			transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
			transform = CGAffineTransformScale(transform, 1.0, -1.0);
			break;
			
		case UIImageOrientationLeftMirrored: //EXIF = 5
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
			transform = CGAffineTransformScale(transform, -1.0, 1.0);
			transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
			break;
			
		case UIImageOrientationLeft: //EXIF = 6
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
			transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
			break;
			
		case UIImageOrientationRightMirrored: //EXIF = 7
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			transform = CGAffineTransformMakeScale(-1.0, 1.0);
			transform = CGAffineTransformRotate(transform, M_PI / 2.0);
			break;
			
		case UIImageOrientationRight: //EXIF = 8
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
			transform = CGAffineTransformRotate(transform, M_PI / 2.0);
			break;
			
		default:
			[NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
			
	}
	
	UIGraphicsBeginImageContext(bounds.size);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
		CGContextScaleCTM(context, -scaleRatio, scaleRatio);
		CGContextTranslateCTM(context, -height, 0);
	}
	else {
		CGContextScaleCTM(context, scaleRatio, -scaleRatio);
		CGContextTranslateCTM(context, 0, -height);
	}
	
	CGContextConcatCTM(context, transform);
	
	CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
	UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return imageCopy;
}

- (UIImage *)imageByScalingProportionallyToMinimumSize:(CGSize)targetSize  rotateImage:(UIImage *)sourceImage {
	

	UIImage *newImage = nil;
	
	CGSize imageSize = sourceImage.size;
	CGFloat width = imageSize.width;
	CGFloat height = imageSize.height;
	
	CGFloat targetWidth = targetSize.width;
	CGFloat targetHeight = targetSize.height;
	
	CGFloat scaleFactor = 0.0;
	CGFloat scaledWidth = targetWidth;
	CGFloat scaledHeight = targetHeight;
	
	CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
	
	if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
		
		CGFloat widthFactor = targetWidth / width;
		CGFloat heightFactor = targetHeight / height;
		
		if (widthFactor > heightFactor)
			scaleFactor = widthFactor;
		else
			scaleFactor = heightFactor;
		
		scaledWidth  = width * scaleFactor;
		scaledHeight = height * scaleFactor;
		
		// center the image
		
		if (widthFactor > heightFactor) {
			thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
		} else if (widthFactor < heightFactor) {
			thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
		}
	}
	
	
	// this is actually the interesting part:
	
	UIGraphicsBeginImageContext(targetSize);
	
	CGRect thumbnailRect = CGRectZero;
	thumbnailRect.origin = thumbnailPoint;
	thumbnailRect.size.width  = scaledWidth;
	thumbnailRect.size.height = scaledHeight;
	
	[sourceImage drawInRect:thumbnailRect];
	
	newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	if(newImage == nil) NSLog(@"could not scale image");
	
	
	return newImage ;
}


#pragma mark  menu animation 
- (void) menuAppear
{
	[self.view addSubview:menu];
	menu.center = CGPointMake(160,240);
	menu.alpha =0;
	CGAffineTransform  normalScale = CGAffineTransformMakeScale(1.1, 1.1);
	CGAffineTransform  scale = CGAffineTransformMakeScale(0.1, 0.1);
	menu.transform = scale; 

	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDelay:.5];	
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(didScale)];
	menu.transform = normalScale; 
	menu.center = CGPointMake(160,240);
	menu.alpha = 1;
	[UIView commitAnimations];
	[menu release];

}

- (void) didScale
{
	[UIView beginAnimations:nil context:nil];
	menu.transform = CGAffineTransformMakeScale(1.0, 1.0);
	menu.center = CGPointMake(160,240);
	[UIView commitAnimations];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}

-(void)selectImage:(NSNumber*) number
{
	int num = [number intValue];
	
	[menu removeFromSuperview];
	zoomedView = [[MultiTouchView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) withImageId:num];
	zoomedView.delegate = self;
	[zoomedView showMenu];
	[self.view addSubview:zoomedView];
	[zoomedView release];
	[self.view bringSubviewToFront:downmenu];
}


- (void)viewDidLoad {
    [super viewDidLoad];

  // here we are subscribing to the device rotation notification  
//  [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];      
//  [[NSNotificationCenter defaultCenter] addObserver:self  
//                              selector:@selector(didRotate:)  
//                              name:UIDeviceOrientationDidChangeNotification   
//                              object:nil];  
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)didRotate:(NSNotification *)notification  
 {          
     UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];  
       
     if ((orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight)) {  

     }  
     else{  

     }  
 }  

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

-(void) bringToFront
{
	[self.view bringSubviewToFront: zoomedView];
	[self.view bringSubviewToFront: downmenu];
	downmenu.hidden = NO;
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;//(interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;
{
	NSLog(@"Will rotete");
}
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
	NSLog(@"Did rotate");
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
#if DEBUG
	NSLog(@"image reciver dealloc zoomedView retainCount %d",[zoomedView retainCount]);
#endif
	[backgroundView removeFromSuperview];
	[backgroundView release];
	[zoomedView stopTimer];
	[zoomedView removeFromSuperview];
    [super dealloc];
}


@end

