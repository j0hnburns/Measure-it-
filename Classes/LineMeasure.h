//
//  LineMeasure.h
//  Measure it!
//
//  Created by idomechi on 10/12/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LineMeasure : NSObject {
	CGPoint start;
	CGPoint stop;
	UIColor * color;
	NSString * meters;
	NSString * foots;
	BOOL animate;
	int width;
	int totalWidth;
	
}

@property (nonatomic) CGPoint start;
@property (nonatomic) CGPoint stop;
@property (nonatomic) BOOL animate;
@property (nonatomic,retain) UIColor * color;
@property (nonatomic,retain) NSString * meters;
@property (nonatomic,retain) NSString * foots;
-(void) animateBg;
@end
