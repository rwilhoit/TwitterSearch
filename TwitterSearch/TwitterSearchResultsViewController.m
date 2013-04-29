//
//  Twitter_SearchViewController.m
//  TwitterSearch
//
//  Copyright (c) 2012 Morgan Claypool. All rights reserved.
//

#import "TwitterSearchResultsViewController.h"
#import "TwitterSearchAppDelegate.h"
#import "TwitterSearchViewController.h"
#import "TweetEntry.h"

@implementation TwitterSearchResultsViewController
@synthesize tweetMessages;
@synthesize resultsTweetHistory;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad 
{
    [super viewDidLoad];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"searchAgain"])
    {
        NSLog(@"2: prepareForSegway");
        // a Navigation Controller hence we need to get it's topViewController
        //TwitterSearchViewResultsController *searchViewController = (TwitterSearchViewResultsController *)[[[segue destinationViewController] topViewController];
        // Pass the array
        //[searchViewController setTweetHistory:resultsTweetHistory];
        
    }
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    // Return the number of sections.
    NSLog(@"2: numberOfSectionsInTableView");
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    // Return the number of rows in the section.
    NSLog(@"2: numberOfRowsInSecion");
    return [tweetMessages count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"2: heightForRowAtIndexPath");
    return 80;
}

// Update the table view
- (void)updateTableView
{
    NSLog(@"2: updateTableView");
    [self.tableView reloadData];
    [self reloadInputViews];
}

// Set content and appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    NSLog(@"Iterating cellForRowAtIndexPath");
    NSLog(@"2: cellForRowAtIndexPath");
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) 
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    // Insert contents of a single Tweet into a cell ...
	NSDictionary *tweetMessage = [tweetMessages objectAtIndex:[indexPath row]];

    // Set the Tweet contents
    cell.textLabel.text = [tweetMessage objectForKey:@"text"];
    cell.textLabel.numberOfLines = 4;
	cell.textLabel.adjustsFontSizeToFitWidth = YES;
	cell.textLabel.font = [UIFont systemFontOfSize:12];
	cell.textLabel.minimumFontSize = 12;
	cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
	
    // Set the user name
	cell.detailTextLabel.text = [tweetMessage objectForKey:@"from_user"];
	
    // Set the user profile image
	NSURL *url = [NSURL URLWithString:[tweetMessage objectForKey:@"profile_image_url"]];
	NSData *data = [NSData dataWithContentsOfURL:url];
	cell.imageView.image = [UIImage imageWithData:data];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    NSLog(@"Called TwitterSearchResultsViewController didSelectRowAtIndexPath");
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)dealloc 
{
    
}

@end

