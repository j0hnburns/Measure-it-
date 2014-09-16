//
//  Measure_it_ViewController.m
//  Measure it!
//
//  Created by idomechi on 10/11/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "Measure_it_ViewController.h"
#import "Player.h"

@implementation Measure_it_ViewController



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


-(void)showMenu:(NSTimer*)theTimer
{
	[splash removeFromSuperview];
	[self.view addSubview:photoView.view];
	[photoView chooseSource];
	//[photoView release];
}


-(void) clearAll
{
	[photoView.view removeFromSuperview];
	[photoView release];
	
	photoView = [[PhotoReciverViewController alloc] initWithNibName:nil bundle:nil];
	[self.view addSubview:photoView.view];
	[photoView chooseSource];
}




// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	photoView = [[PhotoReciverViewController alloc] initWithNibName:nil bundle:nil];
	splash= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default.png"]];
	[self.view addSubview:splash];
	[splash release];
	NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
	BOOL b = [defaults boolForKey:@"LOADED_BEFORE"];
	if(!b)
	{
		[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(showTwitterAlert:) userInfo:nil repeats:NO];
		[defaults setBool:TRUE forKey:@"LOADED_BEFORE"];
	}
	else
		[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(showMenu:) userInfo:nil repeats:NO];
	[Player load];
	[super viewDidLoad];
}


-(void) showTwitterAlert:(NSTimer*)theTimer
{
	UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Measure it! now lets you to post images to Twitter!" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];	
	[alert show];
	[alert release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	[self showMenu:nil];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
