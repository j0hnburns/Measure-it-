//
//  MyAlertView.m
//  Measure Anything
//
//  Created by idomechi on 9/30/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MyAlertView.h"


@implementation MyAlertView


- (id)initWithImage:(NSString*) name {
    if (self = [super initWithFrame:CGRectZero]) {
        // Initialization code
		UIImageView * img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
		[self addSubview:img];
		[img release];
    }
    return self;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)dealloc {
    [super dealloc];
}


@end
