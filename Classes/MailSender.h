//
//  MailSender.h
//  Measure it!
//
//  Created by idomechi on 10/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface MailSender : UIViewController {
	
}
-(void) sendImage:(NSData*) data delegate:(id) delegate;
@end
