//
//  TwitterController.h
//  Measure it!
//
//  Created by idomechi on 12/1/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwitterRequest.h"


@interface TwitterController : UIViewController <UITextFieldDelegate, UITextViewDelegate> {

	UITextField * login;
	UITextField * password;
	UILabel * counter;
	UITextView  * textView;
	UIImageView * picture;
	UIScrollView * scrollView;
	id backDelegate;
	UIBarButtonItem * upload;
	BOOL editing;
	UIActivityIndicatorView * activity;
	UIView * activityView;
	TwitterRequest * t;

}

-(IBAction) upload:(id) sender;
-(IBAction) close:(id) sender;
-(IBAction) clear:(id) sender;

-(void) startActivity;
-(void) stopActivity;


-(void) uploadData;

@property (nonatomic,retain) IBOutlet  UITextField * login;
@property (nonatomic,retain) IBOutlet  UITextField * password;
@property (nonatomic,retain) IBOutlet  UILabel * counter;
@property (nonatomic,retain) IBOutlet  UITextView  * textView;
@property (nonatomic,retain) IBOutlet  UIImageView * picture;
@property (nonatomic,retain) IBOutlet  UIScrollView * scrollView;
@property (nonatomic,assign) IBOutlet  UIBarButtonItem * upload;
@property (nonatomic,assign) id backDelegate;
@property (nonatomic,readonly) UIActivityIndicatorView * activity;

@end
