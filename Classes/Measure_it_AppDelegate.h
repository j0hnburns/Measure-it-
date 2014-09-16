//
//  Measure_it_AppDelegate.h
//  Measure it!
//
//  Created by idomechi on 10/11/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Measure_it_ViewController;

@interface Measure_it_AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    Measure_it_ViewController *viewController;
}
-(void) restart;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet Measure_it_ViewController *viewController;

@end

