//
//  TweetHistory.h
//  TwitterSearch
//
//  Created by Raj Wilhoit on 3/11/13.
//
//

#import <Foundation/Foundation.h>

@interface TweetHistory : NSObject
{
    NSString *twitterSearchTerm;
    NSString *twitterSearchTermCount;
}

@property (nonatomic, retain) NSString *twitterSearchTerm;
@property (nonatomic, retain) NSString *twitterSearchTermCount;

-(id)init:(NSString *)twitterSearchTerm count:(NSString *)twitterSearchTermCount;


@end
