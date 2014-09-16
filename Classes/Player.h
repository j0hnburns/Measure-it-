//
//  Player.h
//  Early Reader
//
//  Created by idomechi on 9/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AVFoundation/AVFoundation.h"

@interface Player : NSObject {

}
+(void) load;
+(void)	play;
+(void)	playName:(NSString*) name;
+(void)	stop;
+(void) pause;
+(void) setState:(BOOL) state;
+(BOOL) getState;
+(BOOL) isPlaying;

@end
