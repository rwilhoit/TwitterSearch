//
//  TweetEntry.m
//  TwitterSearch
//
//
//  Copyright (c) 2012 Morgan Claypool. All rights reserved.
//

#import "TweetEntry.h"


@implementation TweetEntry
@synthesize profileImageURL, userName, userTweet;

-(id)init:(NSString *) tweetmessage user:(NSString *)username url:(NSString *)imageURL
{
	if (self = [super init]) 
    {
		self.userTweet = tweetmessage;
		self.userName = username;
		self.profileImageURL = imageURL;
	}
	return self;
}

-(id)init 
{
	return [super init];
}

@end
