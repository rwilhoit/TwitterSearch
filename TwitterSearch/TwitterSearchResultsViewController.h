//
//  TwitterSearchResultsViewController.h
//  TwitterSearch
//
//  Copyright (c) 2012 Morgan Claypool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Twitter/Twitter.h>

@interface TwitterSearchResultsViewController : UITableViewController 
{
	NSArray *tweetMessages;
    NSMutableArray *resultsTweetHistory;
}

@property (nonatomic, retain) NSArray *tweetMessages;
@property (nonatomic, retain) NSMutableArray *resultsTweetHistory;

- (void)updateTableView;

@end
