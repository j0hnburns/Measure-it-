//
//  Player.m
//  Early Reader
//
//  Created by idomechi on 9/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Player.h"

static 	AVAudioPlayer * player= nil;
static BOOL soundState =YES;
@implementation Player

+(void)play
{
	[Player playName:@""];
}
+(void)load{}

+(void)playName:(NSString*) name
{

	if(!player)
	{
		NSString *path = [[NSBundle mainBundle] pathForResource:@"measure" ofType:@"mp3"];
		player=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
		player.numberOfLoops = -1;
	}
	if(soundState)
		[player play];

}
+(void) pause
{
	if(player)
		[player pause];
}

+(void)stop
{
	if(player)
	{
		[player stop];
		[player release];
		player = nil;
	}
}

+(BOOL) isPlaying
{
	return [player isPlaying];
}
+(void) setState:(BOOL) state
{
	soundState = state;
}

+(BOOL) getState
{
	return soundState;
}
@end
