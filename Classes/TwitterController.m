//
//  TwitterController.m
//  Measure it!
//
//  Created by idomechi on 12/1/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TwitterController.h"
#import "ASIFormDataRequest.h"


@implementation TwitterController

@synthesize login, password, counter ,textView, picture, scrollView, backDelegate, upload , activity;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


-(IBAction) upload:(id) sender
{
	if(editing)
	{
		[textView resignFirstResponder];
		[login  resignFirstResponder];
		[password  resignFirstResponder];
		editing = NO;
		return;
	}
	
	
	[self startActivity];
}

-(void) uploadData
{

	NSURL *url = [NSURL URLWithString:@"http://twitpic.com/api/upload"];
	NSString *sUsername = login.text;
	NSString *sPassword = password.text;
	NSString *message = textView.text;

	// Now, set up the post data:
	ASIFormDataRequest *request = [[[ASIFormDataRequest alloc] initWithURL:url] autorelease];
	
	NSData * data = UIImagePNGRepresentation([picture image]);
	[request setData:data forKey:@"media"];
	[request setPostValue:sUsername forKey:@"username"];
	[request setPostValue:sPassword forKey:@"password"];
	[request setPostValue:message forKey:@"message"];
	
	// Initiate the WebService request
	[request start];
	
	int statusCode = [request responseStatusCode];
	bool success = NO;
	if(statusCode == 200)
	{
		success = YES;
		
		NSString * resp = [request responseString];
		if([resp rangeOfString:@"stat=\"fail\""].location != NSNotFound)
		{
			UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Your Twitter username or password is incorrect.  Please try again" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			[alert release];
			
			success = NO; 
		}

	}
	else
	{
		success = NO;
	}
	
	if(success)
	{
		NSLog(@"response :  -----------------------------------------");
		NSLog([request responseString]);
		NSLog(@"-----------------------------------------------------");
		NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
		[defaults setObject:sUsername forKey:@"LOGIN"];
		[defaults setObject:sPassword forKey:@"PASSWORD"];
		
		NSString * urlmessage= [request responseString];
		int index = [urlmessage rangeOfString:@"<mediaurl>"].location;
		urlmessage = [urlmessage substringFromIndex: index+10];
		index = [urlmessage rangeOfString:@"</mediaurl>"].location;
		urlmessage = [urlmessage substringToIndex: index];	

		NSLog(@"try alloc twitter response");
		t = [[TwitterRequest alloc] init];
		NSLog(@"Alloc twitter response");
		t.username = sUsername;
		t.password = sPassword;		
		NSLog(@"statuses_update");
		[t statuses_update:[NSString stringWithFormat:@"%@ %@",message, urlmessage] delegate:self requestSelector:@selector(status_updateCallback:)];

		return;
	}
	[self stopActivity];
}

-(IBAction) close:(id) sender
{
	NSLog(@"close:");
	[self  dismissModalViewControllerAnimated:YES];
	if([backDelegate respondsToSelector:@selector(dismissMail)])
		[backDelegate performSelector:@selector(dismissMail)];
}

-(IBAction) clear:(id) sender
{
	textView.text = @"";
	counter.text = [NSString stringWithFormat:@"%d", 110];
}

-(void) startActivity
{
	NSLog(@"start activity");
	activityView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	[activityView addSubview:activity];
	[self.view addSubview:activityView];
	[activityView release];
	activity.center = CGPointMake(160,240);
	[activity startAnimating];
	[NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(start:) userInfo:nil repeats:NO];
}

-(void) start:(NSTimer  * ) timer
{
	NSLog(@"start upload data");
	[self uploadData];
}

-(void) stopActivity
{
	NSLog(@"stop activity");
	[activity stopAnimating];
	[activity removeFromSuperview];
	[activity release];
	activity = nil;
	[activityView removeFromSuperview];
}



- (void) status_updateCallback: (NSData *) content {

	NSLog(@"status updated successfully");
	UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"The picture was uploaded successfully" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
	
	
	NSLog(@"show content");
	NSLog(@"%@",[[NSString alloc] initWithData:content encoding:NSASCIIStringEncoding]);
	
	[self stopActivity];
	[self  dismissModalViewControllerAnimated:YES];
	if([backDelegate respondsToSelector:@selector(dismissMail)])
		[backDelegate performSelector:@selector(dismissMail)];
	

}


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
	NSString *sUsername = [defaults objectForKey:@"LOGIN"];
	NSString *sPassword = [defaults objectForKey:@"PASSWORD"];
	if(sUsername == nil) sUsername = @"";
	if(sPassword == nil) sPassword = @"";
	login.text = sUsername;
	password.text = sPassword;
	
	counter.text = [NSString stringWithFormat:@"%d",110-[textView.text length]];
	
    [super viewDidLoad];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark TextFieldDelegates

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	editing = YES;
	return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
	editing = NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	editing = NO;
	return YES;
}

#pragma mark TextViewDelegates



- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
	[upload setTitle:@"Done"];
	editing = YES;
	return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
	[upload setTitle:@"Upload"];
	editing = NO;
}

- (BOOL)textView:(UITextView *)_textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
	
	int additionalSymbol = [text length];
	if(additionalSymbol == 0 && range.length==1) additionalSymbol = -1;
	int count  = 110-[textView.text length] - additionalSymbol;
	if(count<0) return NO;
	counter.text = [NSString stringWithFormat:@"%d", count];
	return YES;
}

- (void)textViewDidChange:(UITextView *)_textView
{
	int count  = 110-[textView.text length];
	counter.text = [NSString stringWithFormat:@"%d", count];
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
	self.login = nil;
	self.password = nil;
	self.textView = nil;
	self.picture = nil;
	self.counter = nil;
	self.scrollView = nil;
    [super dealloc];
}




@end
