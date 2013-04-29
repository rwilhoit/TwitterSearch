//
//  TweetEntry.h
//  TwitterSearch
//
//  Copyright (c) 2012 Morgan Claypool. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TweetEntry : NSObject 
{
	NSString *profileImageURL;
	NSString *userName;
	NSString *userTweet;
}

@property (nonatomic, retain) NSString *profileImageURL;
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *userTweet;

-(id)init:(NSString *) userTweet user:(NSString *)userName url:(NSString *)profileImageURL;

@end
