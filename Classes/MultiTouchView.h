//
//  MultiTouchView.h
//  Measure Anything
//
//  Created by idomechi on 9/28/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "GlassToolar.h"
#import "MailSender.h"
#import "TwitterController.h"
#import "LineMeasure.h"
#import "Rollet.h"
#import "CustomLabel.h"

#define STATE_SCALE		0
#define STATE_MEASURE	1

@interface MultiTouchView : UIView {

	// bus, tennis, car, airplane e.t.c
	UIImageView * scailingImageView;
	UIImageView * rightCornerImageView;
	//UIView * view;
	UIButton * setButton;
	UIView   * setMenu;
	
	// image for saving

	//
	CustomLabel * footsLabel;
	CustomLabel * metersLabel;
	//UILabel *metersLabel;
	//UILabel *footsLabel;
	
	int numScaledThing;
	BOOL isStartPoint;
	CGPoint startPoint;
	CGPoint endPoint;
	float angel;

	Rollet * rollet;

	int state;
	double scaleKoef;
	double currLength;
	int CountTouches;
	CGRect originRect;
	MailSender * mail;
	TwitterController * twitter;

	NSMutableArray *lines;
	LineMeasure * currenttLine;
	NSArray * colorfull;
	UIView * proxyView;
	NSTimer * timer;
	NSTimeInterval startTime;
	id delegate;
}
- (id) initWithFrame:(CGRect)frame withImageId:(int) num;

- (UIImage*) getScreenShot;
- (void) calculateLength;
- (void) showMenu;

- (void) initSetbutton;
- (void) initSetmenu;

- (void) clearAction: (id) sender;
- (void) stopTimer;
- (BOOL) isDataSourceAvailable;

@property (nonatomic,assign) id delegate;
@property (nonatomic) int state;

@end
