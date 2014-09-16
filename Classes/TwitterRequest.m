//
//  TwitterRequest.m
//  Chirpie
//
//  Created by Brandon Trebitowski on 6/15/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TwitterRequest.h"


@implementation TwitterRequest

@synthesize username;
@synthesize password;
@synthesize receivedData;
@synthesize delegate;
@synthesize callback;
@synthesize errorCallback;

-(void)friends_timeline:(id)requestDelegate requestSelector:(SEL)requestSelector{
	
	NSLog(@"friends_timeline:");
	isPost = NO;
	// Set the delegate and selector
	self.delegate = requestDelegate;
	self.callback = requestSelector;
	// The URL of the Twitter Request we intend to send
	NSURL *url = [NSURL URLWithString:@"http://twitter.com/statuses/friends_timeline.xml"];
	[self request:url];
}

-(void)statuses_update:(NSString *)status delegate:(id)requestDelegate requestSelector:(SEL)requestSelector; {

	NSLog(@"statuses_update:");
	isPost = YES;
	// Set the delegate and selector
	self.delegate = requestDelegate;
	self.callback = requestSelector;
	// The URL of the Twitter Request we intend to send
	NSURL *url = [NSURL URLWithString:@"http://twitter.com/statuses/update.xml"];
	requestBody = [NSString stringWithFormat:@"status=%@",status];
	[self request:url];
}

-(void)request:(NSURL *) url {
	NSLog(@"request:");
	theRequest   = [[NSMutableURLRequest alloc] initWithURL:url];
	
	if(isPost) {
		NSLog(@"ispost");
		[theRequest setHTTPMethod:@"POST"];
		[theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
		[theRequest setHTTPBody:[requestBody dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
		[theRequest setValue:[NSString stringWithFormat:@"%d",[requestBody length] ] forHTTPHeaderField:@"Content-Length"];
	}
	
	theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if (theConnection) {
		// Create the NSMutableData that will hold
		// the received data
		// receivedData is declared as a method instance elsewhere
		receivedData=[[NSMutableData data] retain];
	} else {
		// inform the user that the download could not be made
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
	NSLog(@"challenged %@",[challenge proposedCredential] );
	NSLog(@"challenge %@",challenge  );
	
	NSLog(@"challenge count attempt %d", [challenge previousFailureCount]);
	
	if ([challenge previousFailureCount] == 0) {
        NSURLCredential *newCredential;
		NSLog(@"challenge first time ");
        newCredential=[NSURLCredential credentialWithUser:[self username]
                                                 password:[self password]
                                              persistence:NSURLCredentialPersistenceForSession];//NSURLCredentialPersistenceNone];
		NSLog(@"newCredential created");
        [[challenge sender] useCredential:newCredential
               forAuthenticationChallenge:challenge];
		NSLog(@"useCredential compleate");
		//[newCredential release];
    } else {
		NSLog(@"cancelAuthenticationChallenge");
        [[challenge sender] cancelAuthenticationChallenge:challenge];
        // inform the user that the user name and password
        // in the preferences are incorrect
		NSLog(@"Invalid Username or Password");
    }
	
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	NSLog(@"didReceiveResponse:");
    // this method is called when the server has determined that it
    // has enough information to create the NSURLResponse
	
    // it can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    // receivedData is declared as a method instance elsewhere
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	NSLog(@"didReceiveData:");
	//NSLog([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
	// append the new data to the receivedData
    // receivedData is declared as a method instance elsewhere
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
	NSLog(@"didFailWithError:");
    // release the connection, and the data object
    [connection release];
    // receivedData is declared as a method instance elsewhere
    [receivedData release];
	
	[theRequest release];
	
    // inform the user
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSErrorFailingURLStringKey]);
	
	if(errorCallback) {
		[delegate performSelector:errorCallback withObject:error];
	}
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSLog(@"connectionDidFinishLoading:");
    // do something with the data
	
	if(delegate && callback) {
		if([delegate respondsToSelector:self.callback]) {
			[delegate performSelector:self.callback withObject:receivedData];
		} else {
			NSLog(@"No response from delegate");
		}
	} 
	
	// release the connection, and the data object
	[theConnection release];
    [receivedData release];
	[theRequest release];
}

-(void) dealloc {
	[super dealloc];
}


@end
