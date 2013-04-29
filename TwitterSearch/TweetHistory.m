//
//  TweetHistory.m
//  TwitterSearch
//
//  Created by Raj Wilhoit on 3/11/13.
//
//

#import "TweetHistory.h"

@implementation TweetHistory

@synthesize twitterSearchTerm, twitterSearchTermCount;

-(id)init:(NSString *)tweetsearchterm count:(NSString *)tweetsearchtermcount
{
	if (self = [super init])
    {
        self.twitterSearchTerm = tweetsearchterm;
        self.twitterSearchTermCount = tweetsearchtermcount;
	}
	return self;
}

-(id)init
{
	return [super init];
}

@end

