//
//  GlassToolar.h
//  Measure Anything
//
//  Created by idomechi on 9/30/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GlassToolar : UIView {

	UIButton * clearButton;
	UIButton * newButton;
	UIButton * saveButton;
	UIButton * shareButton;
}
- (id)initWithFrame:(CGRect)frame target:(id) target;
- (void) menuAppear;
- (void) menuDisappear:(BOOL) removeFromSuperview;
@end
