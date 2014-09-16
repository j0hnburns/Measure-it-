//
//  ScalingView.m
//  Measure Anything
//
//  Created by idomechi on 9/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ScalingView.h"

#define START_X_POS			0//60
#define OFFSET_X			86

#define FIRST_Y_POS			80				//50+89
#define SECOND_Y_POS		FIRST_Y_POS+107 //140+89
#define TOTAL_BUTTON_HEIGHT 107+111 
#define TOTAL_BUTTON_WIDTH  93+90+100

@implementation ScalingView

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
	//if (self = [super initWithNibName:nil bundle:nil]) {
        // Initialization code
		[self setBackgroundColor:[UIColor clearColor]];
		delegate = nil;
		
		mainView = self;
		
		UIImageView * imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"choose_descriptions.png"]];


		
	
		[mainView addSubview:imgView];
		imgView.frame = CGRectMake((TOTAL_BUTTON_WIDTH - imgView.frame.size.width)/2, imgView.frame.origin.y, imgView.frame.size.width, imgView.frame.size.height);
		
		UILabel * label = [[UILabel alloc] initWithFrame:imgView.frame];
		label.numberOfLines =2;
		[label setText:@"Choose an item to scale\nagainst your object."];
		[label setFont:[UIFont fontWithName:@"Arial-BoldMT" size:18]];
		[label setTextAlignment:UITextAlignmentCenter];
		[label setBackgroundColor:[UIColor clearColor]];
		label.textColor = [UIColor whiteColor];
		label.shadowColor = [UIColor blackColor];
		[label setShadowOffset:CGSizeMake(0,-1)];
		[mainView addSubview:label];
		
		[label release];
		[imgView release];
		
		self.frame = CGRectMake(0, 0,TOTAL_BUTTON_WIDTH, TOTAL_BUTTON_HEIGHT + imgView.frame.size.height+10); 
		
		//mainView.frame = self.view.frame;
	
		int x= START_X_POS;
		UIImage * image = [UIImage imageNamed:@"marble_choose_menu.png"];
		marbleButton = [[UIButton  alloc] initWithFrame:CGRectMake(0, 0, CGImageGetWidth([image CGImage]), CGImageGetHeight([image CGImage]))];
		[marbleButton setBackgroundImage:image forState:UIControlStateNormal];
		[marbleButton addTarget:self action:@selector(marbleAction:) forControlEvents:UIControlEventTouchUpInside];
		marbleButton.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
		[marbleButton setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];
		[marbleButton.titleLabel setShadowOffset:CGSizeMake(2,2)];
		[marbleButton setTitle:@"Marble" forState:UIControlStateNormal];
		marbleButton.titleEdgeInsets = UIEdgeInsetsMake(70, 4 ,0 ,0);
		[mainView addSubview:marbleButton];
		marbleButton.frame = CGRectMake( x, FIRST_Y_POS, marbleButton.frame.size.width, marbleButton.frame.size.height);
		[marbleButton release];
		x+=marbleButton.frame.size.width;
		
		image = [UIImage imageNamed:@"tennis_choose_menu.png"];
		tennisButton = [[UIButton  alloc] initWithFrame:CGRectMake(0, 0, CGImageGetWidth([image CGImage]), CGImageGetHeight([image CGImage]))];
		[tennisButton setBackgroundImage:[UIImage imageNamed:@"tennis_choose_menu.png"] forState:UIControlStateNormal];
		[tennisButton addTarget:self action:@selector(tennisAction:) forControlEvents:UIControlEventTouchUpInside];
		tennisButton.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
		[tennisButton setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];
		[tennisButton.titleLabel setShadowOffset:CGSizeMake(2,2)];
		[tennisButton setTitle:@"Tennis ball" forState:UIControlStateNormal];
		tennisButton.titleEdgeInsets = UIEdgeInsetsMake(70, 0 ,0 ,0);
		[mainView addSubview:tennisButton];
		tennisButton.frame = CGRectMake( x, FIRST_Y_POS, tennisButton.frame.size.width, tennisButton.frame.size.height);
		[tennisButton release];
		x+=tennisButton.frame.size.width;
		
		image = [UIImage imageNamed:@"basket_choose_menu.png"];
		backetButton = [[UIButton  alloc] initWithFrame:CGRectMake(0, 0, CGImageGetWidth([image CGImage]), CGImageGetHeight([image CGImage]))];
		[backetButton setBackgroundImage:[UIImage imageNamed:@"basket_choose_menu.png"] forState:UIControlStateNormal];
		[backetButton addTarget:self action:@selector(basketballAction:) forControlEvents:UIControlEventTouchUpInside];
		backetButton.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
		[backetButton setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];
		[backetButton.titleLabel setShadowOffset:CGSizeMake(2,2)];
		[backetButton setTitle:@"Basketball" forState:UIControlStateNormal];
		backetButton.titleEdgeInsets = UIEdgeInsetsMake(70, 0 ,0 ,0);
		[mainView addSubview:backetButton];
		backetButton.frame = CGRectMake( x, FIRST_Y_POS, backetButton.frame.size.width, backetButton.frame.size.height);
		[backetButton release];
		
		x= START_X_POS;
		image = [UIImage imageNamed:@"car_choose_menu.png"];
		carButton = [[UIButton  alloc] initWithFrame:CGRectMake(0, 0, CGImageGetWidth([image CGImage]), CGImageGetHeight([image CGImage]))];
		[carButton setBackgroundImage:[UIImage imageNamed:@"car_choose_menu.png"] forState:UIControlStateNormal];
		[carButton addTarget:self action:@selector(carAction:) forControlEvents:UIControlEventTouchUpInside];
		carButton.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
		[carButton setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];
		[carButton.titleLabel setShadowOffset:CGSizeMake(2,2)];
		[carButton setTitle:@"Car" forState:UIControlStateNormal];
		carButton.titleEdgeInsets = UIEdgeInsetsMake(50, 0 ,0 ,0);
		[mainView addSubview:carButton];
		carButton.frame = CGRectMake( x, SECOND_Y_POS, carButton.frame.size.width, carButton.frame.size.height);
		[carButton release];
		x+=carButton.frame.size.width;
		
		image = [UIImage imageNamed:@"bus_choose_menu.png"];
		busButton = [[UIButton  alloc] initWithFrame:CGRectMake(0, 0, CGImageGetWidth([image CGImage]), CGImageGetHeight([image CGImage]))];
		[busButton setBackgroundImage:[UIImage imageNamed:@"bus_choose_menu.png"] forState:UIControlStateNormal];
		[busButton addTarget:self action:@selector(busAction:) forControlEvents:UIControlEventTouchUpInside];
		busButton.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
		[busButton setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];
		[busButton.titleLabel setShadowOffset:CGSizeMake(2,2)];
		[busButton setTitle:@"School Bus" forState:UIControlStateNormal];
		busButton.titleEdgeInsets = UIEdgeInsetsMake(52, 0 ,0 ,0);
		[mainView addSubview:busButton];
		busButton.frame = CGRectMake( x, SECOND_Y_POS, busButton.frame.size.width, busButton.frame.size.height);
		[busButton release];
		x+=busButton.frame.size.width;
		
		image = [UIImage imageNamed:@"airliner_choose_menu.png"];
		airplaneButton = [[UIButton  alloc] initWithFrame:CGRectMake(0, 0,  CGImageGetWidth([image CGImage]), CGImageGetHeight([image CGImage]))];
		[airplaneButton setBackgroundImage:[UIImage imageNamed:@"airliner_choose_menu.png"] forState:UIControlStateNormal];
		[airplaneButton addTarget:self action:@selector(airplaneAction:) forControlEvents:UIControlEventTouchUpInside];
		airplaneButton.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
		[airplaneButton setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];
		[airplaneButton.titleLabel setShadowOffset:CGSizeMake(2,2)];
		[airplaneButton setTitle:@"Airliner" forState:UIControlStateNormal];
		airplaneButton.titleEdgeInsets = UIEdgeInsetsMake(50, 0 ,0 ,0);
		[mainView addSubview:airplaneButton];
		airplaneButton.frame = CGRectMake( x, SECOND_Y_POS, airplaneButton.frame.size.width, airplaneButton.frame.size.height);
		[airplaneButton release];


    }
    return self;
}

/// can be changed to tag
-(void)marbleAction:(id) sender
{
		[delegate performSelector:@selector(selectImage:) withObject:[NSNumber numberWithInt:0]];
}

-(void)tennisAction:(id) sender
{
		[delegate performSelector:@selector(selectImage:) withObject:[NSNumber numberWithInt:1]];
}

-(void)basketballAction:(id) sender
{
		[delegate performSelector:@selector(selectImage:) withObject:[NSNumber numberWithInt:2]];
}

-(void)carAction:(id) sender
{
		[delegate performSelector:@selector(selectImage:) withObject:[NSNumber numberWithInt:3]];
}

-(void)busAction:(id) sender
{
		[delegate performSelector:@selector(selectImage:) withObject:[NSNumber numberWithInt:4]];
}

-(void)airplaneAction:(id) sender
{
		[delegate performSelector:@selector(selectImage:) withObject:[NSNumber numberWithInt:5]];
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
}


- (void)dealloc {
    [super dealloc];
}


@end
