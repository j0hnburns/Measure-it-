//
//  MultiTouchView.m
//  Measure Anything
//
//  Created by idomechi on 9/28/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MultiTouchView.h"

#import "Measure_it_AppDelegate.h"
#import "ImageReciverController.h"
#import "Player.h"
#import "SystemConfiguration/SCNetworkReachability.h"


//Marble			1cm W x 1cm H		0.4in W x 0.4in H 
//Tennis ball		6.5cm W x 6.5cm H	2.5in W x 2.5in H 
//Basketball		78 cm W x 78cm H	30in W x 30in H 
//Compact Car		4.5m W x 1.5m H		14.5ft W x 5ft H 
//Bus				11.2m W x 3m H		37ft W x 10ft H 
//Airliner			30m W x 11.2m H		100ft W x 37 ft H

@implementation MultiTouchView

@synthesize delegate, state;

- (id)initWithFrame:(CGRect)frame withImageId:(int) num {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		numScaledThing = num;
		[self setBackgroundColor:[UIColor clearColor]];
		NSArray * arr = [NSArray arrayWithObjects:@"marble.png",@"tennis_ball.png",@"basketball.png",@"car.png",@"bus.png",@"airliner.png",nil];
		scailingImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[arr objectAtIndex:num]]];
		NSArray * images = [NSArray arrayWithObjects:@"marble_measure.png",@"tennis_measure.png",@"backet_measure.png",@"car_measure.png",@"bus_measure.png",@"airplane_measure.png",nil];
		rightCornerImageView= [[UIImageView alloc] initWithImage:[UIImage imageNamed:[images objectAtIndex:num]]];
		rightCornerImageView.center = CGPointMake(320-rightCornerImageView.center.x,rightCornerImageView.center.y);
		originRect = scailingImageView.frame;
		[self addSubview:scailingImageView];
		[self addSubview:rightCornerImageView];
		[scailingImageView release];
		self.multipleTouchEnabled = YES;
		scailingImageView.center = CGPointMake(160,240);
		
		setMenu = nil;
		CountTouches = 0;
		scaleKoef = 1;
		isStartPoint = NO;
		state = STATE_SCALE;
		timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timeCheck:) userInfo:nil repeats:YES];
    }
    return self;
}
	

// set scale
-(void) initSetbutton
{
	if(setMenu)
		[setMenu removeFromSuperview];
	
	UIImage * normalImage = [UIImage imageNamed:@"button_set.png"];
	//UIImage * highlightedImage = [UIImage imageNamed:@"button_set_pressed.png"];
	setButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[setButton setBackgroundImage:normalImage forState:UIControlStateNormal];
	//[setButton setImage:highlightedImage forState:UIControlStateHighlighted];
	[setButton addTarget:self action:@selector(setImage:) forControlEvents:UIControlEventTouchUpInside];
	[setButton setTitle:@"Set" forState:UIControlStateNormal];
	[setButton.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:14]];
	[setButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
	[setButton setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];
	[setButton.titleLabel setShadowOffset:CGSizeMake(1,1)];
	
	setButton.frame = CGRectMake(0, 0, CGImageGetWidth([normalImage CGImage]), CGImageGetHeight([normalImage CGImage]));
	setButton.center = CGPointMake(5 + setButton.frame.size.width/2 ,10 + setButton.frame.size.height/2);
	[self addSubview: setButton];
	state = STATE_SCALE;
	self.multipleTouchEnabled = YES;
	scailingImageView.hidden =NO;

}

// set measure length
-(void) initSetmenu
{

	int buttonX = 1;
	int buttonY = 1;
	UIImageView * background = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"share_save_background.png"]] autorelease];
	UIImage * normalImage = [UIImage imageNamed:@"share_save_button.png"];

	setMenu = [[UIView alloc] initWithFrame:background.frame];	
	[setMenu addSubview:background];
	
	UIButton * saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[saveButton setBackgroundImage:normalImage forState:UIControlStateNormal];
	[saveButton addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
	[saveButton setTitle:@"Save" forState:UIControlStateNormal];
	[saveButton.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:14]];
	[saveButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
	[saveButton setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];
	[saveButton.titleLabel setShadowOffset:CGSizeMake(1,1)];
	saveButton.frame = CGRectMake(buttonX, buttonY, CGImageGetWidth([normalImage CGImage]), CGImageGetHeight([normalImage CGImage]));
	//saveButton.center = CGPointMake(setMenu.frame.size.width/6+2 , setMenu.frame.size.height/2);
	[setMenu addSubview: saveButton];
	
	buttonY += normalImage.size.height +1;
	
	//normalImage = [UIImage imageNamed:@"share_save_button.png"];
	UIButton * shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[shareButton setBackgroundImage:normalImage forState:UIControlStateNormal];
	[shareButton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
	[shareButton setTitle:@"Email" forState:UIControlStateNormal];
	[shareButton.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:14]];
	[shareButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
	[shareButton setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];
	[shareButton.titleLabel setShadowOffset:CGSizeMake(1,1)];
	shareButton.frame = CGRectMake(buttonX, buttonY, CGImageGetWidth([normalImage CGImage]), CGImageGetHeight([normalImage CGImage]));
	//shareButton.center = CGPointMake(setMenu.frame.size.width/2, setMenu.frame.size.height/2);
	[setMenu addSubview: shareButton];
	
	buttonY += normalImage.size.height +1;
	
	//normalImage = [UIImage imageNamed:@"share_save_button.png"];
	UIButton * twitterButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[twitterButton setBackgroundImage:normalImage forState:UIControlStateNormal];
	[twitterButton addTarget:self action:@selector(twitterAction:) forControlEvents:UIControlEventTouchUpInside];
	[twitterButton setTitle:@"Tweet" forState:UIControlStateNormal];
	[twitterButton.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:14]];
	[twitterButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
	[twitterButton setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];
	[twitterButton.titleLabel setShadowOffset:CGSizeMake(1,1)];
	twitterButton.frame = CGRectMake(buttonX, buttonY, CGImageGetWidth([normalImage CGImage]), CGImageGetHeight([normalImage CGImage]));
	//twitterButton.center = CGPointMake(5*setMenu.frame.size.width/6-2, setMenu.frame.size.height/2);
	[setMenu addSubview: twitterButton];
	
	
	//setMenu.center = CGPointMake(setMenu.center.x , setMenu.center.y);
	rollet = [[Rollet alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	footsLabel = [[CustomLabel alloc] initWithFrame: CGRectMake(0, 0, 320, 50)];
	metersLabel= [[CustomLabel alloc] initWithFrame: CGRectMake(0, 50, 320, 50)];
	[self addSubview:rollet];
	[self addSubview:footsLabel];
	[self addSubview:metersLabel];
	[self addSubview:setMenu];
	[self bringSubviewToFront:setMenu];
}


	////////////////
	// show tip TRACE
	////////////////
-(void)setImage:(id)sender
{
	//TODO: cheat
	scailingImageView.hidden =YES;
	rightCornerImageView.hidden = YES;
	[setButton removeFromSuperview];
	setButton = nil;
	
	state = STATE_MEASURE;
	UIAlertView* alert= [[UIAlertView alloc] initWithTitle:@"Now simply trace the length you wish to measure!" message:nil delegate:delegate cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];

	self.multipleTouchEnabled = NO;
}


- (void) showMenu {
	
	UIAlertView* alert= [[UIAlertView alloc] initWithTitle:@"Scale this item until it’s a relative size to the object you wish to measure.\n\nTap ‘Set’ when complete." message:nil delegate:delegate cancelButtonTitle:@"OK" otherButtonTitles:nil];//initWithImage:@"scale_object_tips.png"];
	[alert show];
	[alert release];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

	if(state == STATE_SCALE) 
	{
			currLength =-1;
			CountTouches += [touches count];
#if	DEBUG 
			NSLog(@"Was toushes %d",[touches count]);
#endif
	
	}else
	{
	
			UITouch * t  = [touches anyObject];
			startPoint =	[t locationInView:self];
			endPoint = startPoint;
			
			[footsLabel setHidden:NO];
			[metersLabel setHidden:NO];
			[Player play];
			startTime = [[NSDate date] timeIntervalSince1970];
	
			isStartPoint = YES;
	}
	
	[super touchesBegan:touches withEvent:event];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	if(state == STATE_SCALE)
	{
	
		switch (CountTouches)
		{
			case 1:
			{
				UITouch * t  = [touches anyObject];
				CGPoint pt =	[t locationInView:self];
				scailingImageView.center = pt;
			}
				break;
			case 2:
			{
				NSArray * arr = [touches allObjects];
				if([arr count]==2)
				{
					UITouch * t;
					t= [arr objectAtIndex:0];
					CGPoint pt1 =	[t locationInView:self];
					t= [arr objectAtIndex:1];
					CGPoint pt2 =	[t locationInView:self];

					if(currLength==-1)
					{
						currLength = sqrt((pt1.x-pt2.x)*(pt1.x-pt2.x)+(pt1.y-pt2.y)*(pt1.y-pt2.y));
					
					}
					else
					{
						double len = sqrt((pt1.x-pt2.x)*(pt1.x-pt2.x)+(pt1.y-pt2.y)*(pt1.y-pt2.y));
						scaleKoef*=len/currLength;
						currLength = len;
					}
					
#if	DEBUG 
					NSLog(@"koef %f", scaleKoef);
#endif
					scailingImageView.frame = CGRectMake(0,0,originRect.size.width*scaleKoef, originRect.size.height*scaleKoef);
					scailingImageView.center = CGPointMake(MIN(pt1.x,pt2.x)+ABS(pt1.x -pt2.x)/2,MIN(pt1.y,pt2.y)+ABS(pt1.y -pt2.y)/2);
					
				}
			}
				break;
				
			default:
				break;
		}
	}
	else // MEASURE
	{
		UITouch * t  = [touches anyObject];
		endPoint =	[t locationInView:self];
		NSTimeInterval currtime = [[NSDate date] timeIntervalSince1970]*1000;
		
		if(![Player isPlaying])
		{
#if DEBUG
			NSLog(@"play");
#endif
			[Player play];
		}
		startTime = currtime;
		[rollet setStartPoint:startPoint endPoint:endPoint];
		[self calculateLength];

		[self setNeedsDisplay];
	}
	[super touchesBegan:touches withEvent:event];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	if(state == STATE_SCALE)
	{
		CountTouches -= [touches count];
#if DEBUG	
		NSLog(@"toushes relesed %d",[touches count]);
#endif
	}else
	{
		currenttLine.animate = YES;
		[Player stop];
	}
	[super touchesBegan:touches withEvent:event];
}


-(void) clearAction: (id) sender
{
	startPoint=endPoint=CGPointZero;
	rollet.hidden = YES;
	[footsLabel setHidden:YES];
	[metersLabel setHidden:YES];
	
	UIAlertView* alert= [[UIAlertView alloc] initWithTitle:@"Now simply trace the length you wish to measure!" message:nil delegate:delegate cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];

	
}
-(void) newAction: (id) sender
{
	[(Measure_it_AppDelegate*)[[UIApplication sharedApplication] delegate] restart];
}
-(void) saveAction: (id) sender
{
	UIImage * theImage= [self getScreenShot];
	UIImageWriteToSavedPhotosAlbum( theImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil );
	
	UIAlertView* alert= [[UIAlertView alloc] initWithTitle:@"Your image has been saved in 'Photos'" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];//initWithImage:@"scale_object_tips.png"];
	[alert show];
	[alert release];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
}

-(void) shareAction: (id) sender
{

	UIImage * theImage= [self getScreenShot];
	ImageReciverController * parent = (ImageReciverController *) delegate;
	[parent invisibleMenu:YES];
	
	proxyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	mail = [[MailSender alloc] initWithNibName:nil bundle:nil];

	[proxyView addSubview:mail.view];
	[self addSubview:proxyView];
	[proxyView release];
	[mail sendImage:UIImagePNGRepresentation(theImage) delegate:self];
}

-(void) twitterAction: (id) sender
{

	if(![self isDataSourceAvailable])
	{
		UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Network unavailable" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		return;
	}
		
	UIImage * theImage= [self getScreenShot];
	ImageReciverController * parent = (ImageReciverController *) delegate;
	[parent invisibleMenu:YES];
	
	proxyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	twitter = [[TwitterController alloc] initWithNibName:@"TwitterController" bundle:nil];
	
	twitter.backDelegate= self;
	[proxyView addSubview:twitter.view];
	
	// animation
	CGRect rect = twitter.view.frame;
	rect.origin.y = 480;
	twitter.view.frame = rect;
	[UIView beginAnimations:nil context:nil];
	[self addSubview:proxyView];
	rect.origin.y = 0;
	twitter.view.frame = rect;
	[UIView commitAnimations];
	
	[proxyView release];
	[twitter.picture setImage:theImage];
	twitter.picture.frame = CGRectMake(0, twitter.picture.frame.origin.y, 320, 420);
	[twitter.scrollView setContentSize:CGSizeMake(320 , twitter.picture.frame.origin.y +twitter.picture.frame.size.height )];
}


- ( BOOL )isDataSourceAvailable
{
	BOOL checkNetwork = YES;
	BOOL _isDataSourceAvailable = NO;
	if (checkNetwork) 
	{ 
        checkNetwork = NO;
        
        Boolean success;    
		const char *host_name = "apple.com";
		
        SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, host_name);
        SCNetworkReachabilityFlags flags;
        success = SCNetworkReachabilityGetFlags(reachability, &flags);
        _isDataSourceAvailable = success && (flags & kSCNetworkFlagsReachable) && !(flags & kSCNetworkFlagsConnectionRequired);
    }
	
    return _isDataSourceAvailable;
}

-(UIImage*) getScreenShot
{
	setMenu.hidden = YES;
	ImageReciverController * parent = (ImageReciverController *) delegate;
	[parent invisibleMenu:YES];
	
	UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
	
	UIGraphicsBeginImageContext(screenWindow.frame.size);
	[(CALayer *)screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	[parent invisibleMenu:NO];
	setMenu.hidden = NO;
	return screenshot;
}

-(void)calculateLength
{
	NSString *metersStr;
	NSString *inchesStr;
	float met;
	float inch;
	float height = scailingImageView.frame.size.height;
	
	double measureLen = sqrt((startPoint.x-endPoint.x)*(startPoint.x-endPoint.x)+(startPoint.y-endPoint.y)*(startPoint.y-endPoint.y));

//	if(measureLen<15) measureLen = 0;
//	else
//		measureLen -=15;
		
	double realLenM=0;
	double realLenI=0;
	int type;
	switch (numScaledThing) {
		case 0:
			met = 1;
			inch = 0.4;
			metersStr =@"cm";
			inchesStr =@"in";
			type = 0;
			break;
		case 1:
			met = 6.5;
			inch = 2.5;
			metersStr =@"cm";
			inchesStr =@"in";
			type = 0;
			break;
		case 2:
			met = 22;
			inch = 9;
			metersStr =@"cm";
			inchesStr =@"in";
			type = 0;
			break;
		case 3:
			met = 1.5;
			inch = 5;
			metersStr =@"m";
			inchesStr =@"ft";
			type = 1;
			break;
		case 4:
			met = 3;
			inch = 10;
			metersStr =@"m";
			inchesStr =@"ft";
			type = 1;
			break;
		case 5:
			met = 11.2;
			inch = 37;
			metersStr =@"m";
			inchesStr =@"ft";
			type = 1;
			break;
		default:
			break;
	}
	realLenM = measureLen*met/height;
	realLenI = measureLen*inch/height;

	[footsLabel setLength:((int)realLenI) withSize:type];
	[metersLabel setLength:((int)realLenM) withSize:type+2];
	
	
}


// //Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
	[mail.view removeFromSuperview];
	[controller dismissModalViewControllerAnimated:YES];
	[mail release];
	[proxyView removeFromSuperview];

	[delegate performSelector:@selector(bringToFront)];
}

- (void) dismissMail
{
	[twitter.view removeFromSuperview];
	//[controller dismissModalViewControllerAnimated:YES];
	[twitter release];
	[proxyView removeFromSuperview];
	[delegate performSelector:@selector(bringToFront)];
}

- (void) changeOrientation
{
	
}
-(void) timeCheck:(id) sender
{
	NSTimeInterval currtime = [[NSDate date] timeIntervalSince1970]*1000;
	
	if(currtime - startTime > 400)
	{
		startTime = currtime;
#if DEBUG
		NSLog(@"pause %d",currtime - startTime);
#endif
		if([Player isPlaying])
			[Player pause];
	}
}

-(void) stopTimer
{
	[timer invalidate];
}

- (void)dealloc {
#if DEBUG
	NSLog(@"multitouch dealloc");
#endif
	
	[Player stop];
	[rightCornerImageView removeFromSuperview];
	[rightCornerImageView release];
	[lines removeAllObjects];
	[lines release];
	[colorfull release];
	[scailingImageView removeFromSuperview];
    [super dealloc];
}


@end
