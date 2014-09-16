//
//  Measure_it_AppDelegate.m
//  Measure it!
//
//  Created by idomechi on 10/11/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "Measure_it_AppDelegate.h"
#import "Measure_it_ViewController.h"

@implementation Measure_it_AppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    

    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
	NSLog(@"applicationDidFinishLaunching");
	
}

- (void) restart
{
	[viewController clearAll];
}

- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
