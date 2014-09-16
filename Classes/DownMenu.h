//
//  DownMenu.h
//  Measure it!
//
//  Created by idomechi on 10/20/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DownMenu : UIView {

	UIImageView* background;
	UIButton * chooseButton;
	UIButton * scaleButton;
	UIButton * measureButton;
	int currentActive;
}
- (id)initWithTarget:(id) target;
- (void) setActive:(int) active;

@property (nonatomic) int currentActive;
@end
