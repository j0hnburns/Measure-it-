//
//  CustomLabel.h
//  Measure it!
//
//  Created by idomechi on 10/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomLabel : UIView {
	NSString * _text;
	int _type;
	NSArray * array;
	NSMutableArray * foots;
}


-(void) setLength:(int) length withSize:(int) type;
@end
