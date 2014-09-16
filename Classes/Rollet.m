//
//  Rollet.m
//  Measure it!
//
//  Created by idomechi on 10/24/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Rollet.h"

#define OFFSET_LEN 38

CGAffineTransform trance;
@implementation Rollet


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		measureImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yellow_line.png"]]; 
		_roller_width = measureImage.frame.size.height;
		measureImage.frame  = CGRectMake(0, 200, 250, _roller_width);
		measureImage.contentMode = UIViewContentModeTopLeft;
		measureImage.clipsToBounds = YES;	
		trance =measureImage.transform;

		measureBaseImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yellow_end.png"]];
		measureBaseImage.frame = CGRectMake(0, 0, measureBaseImage.frame.size.width,  measureBaseImage.frame.size.height);
		self.hidden = YES;
		self.backgroundColor =[UIColor clearColor];
		[self addSubview:measureImage];
		[self addSubview:measureBaseImage];
		[measureImage release];
		[measureBaseImage release];
    }
    return self;
}


-(void)setStartPoint:(CGPoint) start endPoint:(CGPoint) end
{
	self.hidden = NO;
	double measureLen = sqrt((start.x-end.x)*(start.x-end.x)+(start.y-end.y)*(start.y-end.y));
	double alpha = acos((start.x-end.x)/measureLen);
	if(end.y > start.y)
		alpha*=-1;
	
	CGRect rect = CGRectMake(start.x, start.y, measureLen, _roller_width);
	measureImage.bounds = rect;
	CGPoint center = CGPointMake(MIN(start.x,end.x)+ABS(start.x-end.x)/2,MIN(start.y,end.y)+ABS(start.y-end.y)/2);
	measureImage.center = center;
	measureImage.transform = CGAffineTransformMakeRotation(alpha);
	measureBaseImage.center = CGPointMake(start.x+((measureBaseImage.bounds.size.width-OFFSET_LEN)*cos(alpha)/2),
										  start.y+((measureBaseImage.bounds.size.width-OFFSET_LEN)*sin(alpha)/2));
	measureBaseImage.transform = CGAffineTransformMakeRotation(alpha);
//	NSLog(@"\n\n");
//	NSLog(@"alpha -- %f", alpha*180/M_PI);
//	NSLog(@"length -- %f", measureLen);
//	NSLog(@"Start point %f %f",start.x,start.y);
//	NSLog(@"EndPoint %f %f",end.x,end.y);
}

- (void)dealloc {
    [super dealloc];
}


@end
