//
//  GlassToolar.m
//  Measure Anything
//
//  Created by idomechi on 9/30/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "GlassToolar.h"

#define TOTAL_BUTTON_WIDTH  99+93
#define TOTAL_BUTTON_HEIGHT 63+69
#define START_X_POS			0
#define START_Y_POS			0

@implementation GlassToolar


- (id)initWithFrame:(CGRect)frame target:(id) target{
    if (self = [super initWithFrame:frame]) {
        // Initialization code
	
		clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[clearButton setImage:[UIImage imageNamed:@"clear_bar_menu.png"] forState:UIControlStateNormal];
		[clearButton addTarget:target action:@selector(clearAction:) forControlEvents:UIControlEventTouchUpInside];
		clearButton.frame = CGRectMake(START_X_POS, START_Y_POS, 92, 63);

		[self addSubview: clearButton];
		
		newButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[newButton setImage:[UIImage imageNamed:@"new_bar_menu.png"] forState:UIControlStateNormal];
		[newButton addTarget:target action:@selector(newAction:) forControlEvents:UIControlEventTouchUpInside];
		newButton.frame = CGRectMake( START_X_POS+92, START_Y_POS, 99, 63);

		[self addSubview: newButton];
		
		saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[saveButton setImage:[UIImage imageNamed:@"save_bar_menu.png"] forState:UIControlStateNormal];
		[saveButton addTarget:target action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
		saveButton.frame = CGRectMake(START_X_POS, START_Y_POS+63, 92, 69);
		[self addSubview: saveButton];
		
		shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[shareButton setImage:[UIImage imageNamed:@"share_bar_menu.png"] forState:UIControlStateNormal];
		[shareButton addTarget:target action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
		shareButton.frame = CGRectMake(START_X_POS+92, START_Y_POS+63, 99, 69);
		[self addSubview: shareButton];
		
		self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, TOTAL_BUTTON_WIDTH, TOTAL_BUTTON_HEIGHT);
    }
    return self;
}

- (void) menuAppear
{

	self.center = CGPointMake(160,240);
	self.alpha =0;
	CGAffineTransform  normalScale = CGAffineTransformMakeScale(1.1, 1.1);
	CGAffineTransform  scale = CGAffineTransformMakeScale(0.1, 0.1);
	self.transform = scale;
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(didScale)];
	self.transform = normalScale; 
	self.center = CGPointMake(160,240);
	self.alpha = 1;
	[UIView commitAnimations];

}

- (void) didScale
{
	[UIView beginAnimations:nil context:nil];
	self.transform = CGAffineTransformMakeScale(1.0, 1.0);
	self.center = CGPointMake(160,240);
	[UIView commitAnimations];
}

- (void) menuDisappear:(BOOL) removeFromSuperview
{
	self.center = CGPointMake(160,240);
	CGAffineTransform  normalScale = CGAffineTransformMakeScale(0.1, 0.1);
	[UIView beginAnimations:nil context:nil];
	if(removeFromSuperview)
	{
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(removeView)];
	}
	self.transform = normalScale; 
	self.center = CGPointMake(160,240);
	self.alpha = 0;
	[UIView commitAnimations];

}
- (void) removeView
{
	[self removeFromSuperview];
}

- (void)dealloc {
    [super dealloc];
}


@end
