//
//  LineMeasure.m
//  Measure it!
//
//  Created by idomechi on 10/12/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "LineMeasure.h"



@implementation LineMeasure

@synthesize start, stop, color;
@synthesize meters, foots ,animate;

- (id) init
{
	self = [super init];
	if (self != nil) {
		width = 0;
		totalWidth = 0;
	}
	return self;
}

-(void) animateBg
{

	if(animate)
	{
		if(totalWidth == 0)
			totalWidth =sqrt(pow(start.x-stop.x,2) * pow(start.y-stop.y,2));
		if( width >= totalWidth)
			animate = NO;
	}
	if(animate)
		width +=4;
}

@end
