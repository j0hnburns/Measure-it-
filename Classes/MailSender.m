//
//  MailSender.m
//  Measure it!
//
//  Created by idomechi on 10/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MailSender.h"


@implementation MailSender



-(void) sendImage:(NSData*) data delegate:(id) delegate
{
Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
if (mailClass != nil)
{
	// We must always check whether the current device is configured for sending emails
	if ([mailClass canSendMail])
	{ 
		MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
		picker.mailComposeDelegate = delegate;
		
		[picker setSubject:@"Check out the size of this!"];
		
		[picker addAttachmentData:data mimeType:@"image/png" fileName:@"Measured"];
		
		// Fill out the email body text
		NSString *emailBody = @"Created with Measure it! for the iPhone - “Estimate the size of anything!” \n http://www.ikonstrukt.com/measure.php";
		[picker setMessageBody:emailBody isHTML:NO];
		
		[self presentModalViewController:picker animated:YES];
		[[picker navigationBar] setTintColor:[UIColor blackColor]];
		//[[picker navigationBar] setTranslucent:YES];

		[picker release];
	}
}	
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
    [super dealloc];
}


@end
