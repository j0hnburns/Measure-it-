//
//  Rollet.h
//  Measure it!
//
//  Created by idomechi on 10/24/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Rollet : UIView {
	int _angel;
	int _length;
	CGPoint _start,_end;
	UIImageView * measureImage;
	UIImageView * measureBaseImage;
	int _roller_width;
}

-(void)setStartPoint:(CGPoint) start endPoint:(CGPoint) end;

@end
