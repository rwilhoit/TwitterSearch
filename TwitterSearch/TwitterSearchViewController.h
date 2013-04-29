//
//  TwitterSearchViewController.h
//  TwitterSearch
//
//  Copyright (c) 2012 Morgan Claypool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Twitter/Twitter.h>
#import "TwitterSearchResultsViewController.h"

@class TwitterSearchViewController;

@interface TwitterSearchViewController : UIViewController
{
    IBOutlet UITableView *twitterHistoryTable;
	NSMutableArray *tweetHistory;
}

@property (strong, nonatomic) IBOutlet UITextField *searchTextField;
@property (strong, nonatomic) IBOutlet UIButton *searchHistoryButton;
@property (nonatomic, retain) NSMutableArray *tweetHistory;

- (IBAction)pressSearchHistoryButton:(id)sender;

@end
