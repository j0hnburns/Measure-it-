//
//  DownMenu.m
//  Measure it!
//
//  Created by idomechi on 10/20/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "DownMenu.h"


@implementation DownMenu

@synthesize currentActive;

- (id)initWithTarget:(id) target{
    if (self = [super initWithFrame:CGRectZero]) {

		
		background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"choose_scale_measure_background.png"]];
		[self addSubview: background];
		[background release];
		
		self.frame = CGRectMake(0, 0, background.frame.size.width, background.frame.size.height); 

		UIImage * normalImage = [UIImage imageNamed:@"button_down.png"];
		
		chooseButton = [[UIButton  alloc] initWithFrame:CGRectMake(0, 0, CGImageGetWidth([normalImage CGImage]), CGImageGetHeight([normalImage CGImage]))];
		[chooseButton setBackgroundImage:normalImage forState:UIControlStateNormal];
		[chooseButton addTarget:target action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
		[chooseButton setTitle:@"Choose" forState:UIControlStateNormal];
		[chooseButton.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:14]];
		[chooseButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
		[chooseButton setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];
		[chooseButton.titleLabel setShadowOffset:CGSizeMake(1,1)];
		[self addSubview:chooseButton];
		chooseButton.frame = CGRectMake((background.frame.size.width/3-chooseButton.frame.size.width)/2+2 , (background.frame.size.height-chooseButton.frame.size.height)/2,
										chooseButton.frame.size.width, chooseButton.frame.size.height);
		[chooseButton release];
		
		normalImage = [UIImage imageNamed:@"button_down.png"];
	
		scaleButton = [[UIButton  alloc] initWithFrame:CGRectMake(0, 0, CGImageGetWidth([normalImage CGImage]), CGImageGetHeight([normalImage CGImage]))];
		[scaleButton setBackgroundImage:normalImage forState:UIControlStateNormal];
		[scaleButton addTarget:target action:@selector(scaleAction:) forControlEvents:UIControlEventTouchUpInside];
		[scaleButton setTitle:@"Scale" forState:UIControlStateNormal];
		[scaleButton.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:14]];
		[scaleButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
		[scaleButton setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];
		[scaleButton.titleLabel setShadowOffset:CGSizeMake(1,1)];
		[self addSubview:scaleButton];
		scaleButton.frame = CGRectMake( (background.frame.size.width-scaleButton.frame.size.width)/2, (background.frame.size.height-scaleButton.frame.size.height)/2,
									   scaleButton.frame.size.width, scaleButton.frame.size.height);
		[scaleButton release];
		scaleButton.enabled =NO;
		
		normalImage = [UIImage imageNamed:@"button_down.png"];
		measureButton = [[UIButton  alloc] initWithFrame:CGRectMake(0, 0, CGImageGetWidth([normalImage CGImage]), CGImageGetHeight([normalImage CGImage]))];
		[measureButton setBackgroundImage:normalImage forState:UIControlStateNormal];
		[measureButton addTarget:target action:@selector(measureAction:) forControlEvents:UIControlEventTouchUpInside];
		[measureButton setTitle:@"Measure" forState:UIControlStateNormal];
		[measureButton.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:14]];
		[measureButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
		[measureButton setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];
		[measureButton.titleLabel setShadowOffset:CGSizeMake(1,1)];
		[self addSubview:measureButton];
		measureButton.frame = CGRectMake( (background.frame.size.width*5/3-measureButton.frame.size.width)/2-2 , (background.frame.size.height-measureButton.frame.size.height)/2,
										 measureButton.frame.size.width, measureButton.frame.size.height);
		[measureButton release];
		measureButton.enabled =NO;
		currentActive = 0;
    }
    return self;
}


- (void) setActive:(int) active
{
	switch (active) {
		case 0:
			chooseButton.selected=YES;
			scaleButton.enabled =NO;
			scaleButton.selected =NO;
			measureButton.enabled =NO;
			measureButton.selected =NO;
			break;
		case 1:
			scaleButton.enabled =YES;
			scaleButton.selected =YES;
			measureButton.enabled =NO;
			measureButton.selected =NO;
			break;
		case 2:
			measureButton.enabled =YES;
			measureButton.selected =YES;
			break;
		default:
			break;
	}

	currentActive = active;
}

- (void)dealloc {
    [super dealloc];
}
@end
