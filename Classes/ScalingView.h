//
//  ScalingView.h
//  Measure Anything
//
//  Created by idomechi on 9/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ScalingView : UIView <UIAlertViewDelegate> {

	UIView * mainView;
	UIImageView	* backgroundView;
	UIButton * marbleButton;
	UIButton * tennisButton;
	UIButton * backetButton;
	UIButton * carButton;
	UIButton * busButton;
	UIButton * airplaneButton;
	id delegate;
}

- (id)initWithFrame:(CGRect)frame;

@property (nonatomic,assign) id delegate;
@end
