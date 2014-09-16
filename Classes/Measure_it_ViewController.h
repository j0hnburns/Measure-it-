//
//  Measure_it_ViewController.h
//  Measure it!
//
//  Created by idomechi on 10/11/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoReciverViewController.h"

@interface Measure_it_ViewController : UIViewController {

	PhotoReciverViewController * photoView;
	UIImageView* splash;
}

-(void)showMenu:(NSTimer*)theTimer;
-(void) clearAll;

@end

