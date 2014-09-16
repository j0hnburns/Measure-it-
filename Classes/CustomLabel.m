//
//  CustomLabel.m
//  Measure it!
//
//  Created by idomechi on 10/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "CustomLabel.h"

#define LETTER_OFFSET 1

@implementation CustomLabel


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		self.backgroundColor = [UIColor clearColor];
		NSMutableArray * temp = [[NSMutableArray alloc] initWithCapacity:10];

		for(int i=0;i<10;i++)
			[temp addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i]]];
		array = [[NSArray arrayWithArray:temp] retain];
		[temp release];
		

		_text = nil;
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
	int x = 0;
	int frameWidth;
	UIImage * image;
	int width;
	int height;
	for(int i=0;i<[_text length];i++)
	{
		int index = [_text characterAtIndex:i]-'0';
		image = [array objectAtIndex:index];
		width = CGImageGetWidth([image CGImage]);
		height = CGImageGetHeight([image CGImage]);
		CGRect rect = CGRectMake(x, 0, width, height);
		[image drawInRect:rect blendMode:kCGBlendModeXOR alpha:1];
		x+=width-LETTER_OFFSET;
		frameWidth = x;
		self.frame =CGRectMake(320-frameWidth, self.frame.origin.y, 320, self.frame.size.height);

	}
	
	switch (_type) {
		case 0:
			image = [UIImage imageNamed:@"in.png"];
			break;
		case 1:
			image = [UIImage imageNamed:@"ft.png"];
			break;
		case 2:
			image = [UIImage imageNamed:@"cm.png"];
			break;
		case 3:
			image = [UIImage imageNamed:@"m.png"];
			break;
		default:
			break;
	}
	width = CGImageGetWidth([image CGImage]);
	height = CGImageGetHeight([image CGImage]);
	if(_type == 0 || _type ==2)
		frameWidth+=75;
	else
		frameWidth+=60;	
	self.frame =CGRectMake(320-frameWidth, self.frame.origin.y, 320, self.frame.size.height);
	CGRect innerrect = CGRectMake(x, abs(self.frame.size.height-height) - 3, width, height);
	[image drawInRect:innerrect];


}

-(void) setLength:(int) length withSize:(int) type
{	[_text release];
	_text = [[NSString stringWithFormat:@"%d",length] retain];
	_type = type;

	[self setNeedsDisplay];
}

- (void)dealloc {
	[array release];
	[_text release];
    [super dealloc];
}


@end
