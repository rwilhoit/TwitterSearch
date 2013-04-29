//
//  TwitterSearchViewController.m
//  TwitterSearch
//
//  Copyright (c) 2012 Morgan Claypool. All rights reserved.
//

#import "TwitterSearchViewController.h"
#import "TwitterSearchResultsViewController.h"
#import "TweetHistory.h"
#import "Globals.h"

static NSMutableArray *tweeterArray = nil;

@implementation TwitterSearchViewController
@synthesize searchTextField;
@synthesize tweetHistory;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSLog(@"Called initWithNibName");
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    NSLog(@"VIEWDIDLOAD: There are currently %lu objects in TweetHistory, and in TweeterArray there are %lu objects", (unsigned long)[tweetHistory count], (unsigned long)[tweeterArray count]);

    
    if(tweetHistory == nil)
    {
        NSLog(@"ALLOCATING ARRAY");
        tweetHistory = [[NSMutableArray alloc] init];
    }
    
    [super viewDidLoad];

}

- (void)viewDidUnload
{
    NSLog(@"Called viewDidUnload in TwitterSearchViewController");
    twitterHistoryTable = nil;
    [self setSearchHistoryButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.searchTextField = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// This function performs the actual Twitter Search and updates the UI with results
// It utilizes the Segue transition as specified in the TwitterSearchStoryBoard file
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender 
{
    if ([[segue identifier] isEqualToString:@"transitionToSearchResults"]) 
    {
        // Make searchTextField's keyboard disappear
        [searchTextField resignFirstResponder];
        
        // Don't search for empty strings or whitespaces
        if([searchTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ].length == 0)
            return;
        
        // Get reference to the view controller which is of type
        // TwitterSearchResultsViewController
        // Remember that the TwitterSearchResultsViewController is embedded in
        // a Navigation Controller hence we need to get it's topViewController
        TwitterSearchResultsViewController *searchViewController = (TwitterSearchResultsViewController *)[[segue destinationViewController] topViewController];
        
        // Create a Twitter Search request using the Twitter API
        NSMutableString *searchURL = [NSMutableString string];
        
        // First encoded the search terms into URL friendly form
        NSString *urlEncodedQuery = [searchTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

        // Create the search request URL
        [searchURL appendString:[NSString stringWithFormat:@"http://search.twitter.com/search.json?q=%@&rpp=100", urlEncodedQuery]];
        
        NSLog(@"Twitter Search Request URL is: %@", searchURL);
        
        //Right here is where numberOfSectionsInTableView, etc is called
        
        TWRequest *requestError = [[TWRequest alloc] initWithURL:[NSURL URLWithString:searchURL] parameters:nil requestMethod:TWRequestMethodGET];
        
        // Send the Twitter Search request and create a handler to handle the Search response
        [requestError performRequestWithHandler:^(NSData *searchResponse, NSHTTPURLResponse *requestResponse, NSError *error) 
         {
             NSLog(@"HTTP Response Status Code = %i (OK = 200)\n", [requestResponse statusCode]);
             
             if ([requestResponse statusCode] == 200) 
             {
                 // Parse the requestResponse which is in JSON into an NSDictionary object using NSJSONSerialization
                 NSError *jsonError = nil;
                 NSDictionary *searchResultsDict = [NSJSONSerialization JSONObjectWithData:searchResponse options:0 error:&jsonError];
                 
                 // Extract the Twitter messages from search response
                 NSArray *tweetMessages = [searchResultsDict objectForKey:@"results"];
                 
                 // Set the Data Source for the Table in TwitterSearchResultsViewController
                 // which displays the search results nicely
                 [searchViewController setTweetMessages:tweetMessages];
                 
                 TweetHistory *newHistoryEntry = [[TweetHistory alloc] init];
                 
                 newHistoryEntry.twitterSearchTerm = searchTextField.text;                                         //set the search term
                 NSLog(@"newHistoryEntry.twitterSearchTerm = %@", newHistoryEntry.twitterSearchTerm);              
                 newHistoryEntry.twitterSearchTermCount = [NSString stringWithFormat:@"%d",[tweetMessages count]]; //convert int number to a string
                 NSLog(@"newHistoryEntryCount.twitterSearchTerm = %@", newHistoryEntry.twitterSearchTermCount);

                 
                 // Add object to global array
                 NSMutableArray *globalArrayCopy = [Globals globalArray];
                 [globalArrayCopy addObject:newHistoryEntry];
                                  
                 NSLog(@"IN GLOBAL ARRAY THERE ARE %lu", (unsigned long)[globalArrayCopy count]);
            
                 // Update the table view
                 [searchViewController updateTableView];
             }
         }];
    }

}

// Update the table view
- (void)updateTableView
{
    NSLog(@"1: updateTableView");
    [twitterHistoryTable reloadData];
    [twitterHistoryTable reloadInputViews];
}

- (IBAction)pressSearchHistoryButton:(id)sender
{
    self.view.hidden = YES;
    UITableView *historyTableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStylePlain];
    historyTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    historyTableView.delegate = self;
    historyTableView.dataSource = self;
    
    [historyTableView reloadData];
    
    self.view = historyTableView;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"1: numberOfSectionsInTableView");
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"1: numberOfRowsInSection");
    // Add object to global array
    NSMutableArray *globalArrayCopy = [Globals globalArray];
    return [globalArrayCopy count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"1: heightForRowAtIndexPath");
    return 80;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    // The header for the section is the region name -- get this from the region at the section index.
    //Region *region = [regions objectAtIndex:section];
    return @"Search History";
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    // Add object to global array
    NSMutableArray *globalArrayCopy = [Globals globalArray];
    TweetHistory *historyEntry = [globalArrayCopy objectAtIndex:indexPath.row];
    
    // Set the Tweet search term
    cell.textLabel.text = [@"Term Searched: " stringByAppendingString:historyEntry.twitterSearchTerm];
    // Set the Tweet search term result count
	cell.detailTextLabel.text = [@"Results Returned: " stringByAppendingString:historyEntry.twitterSearchTermCount];
    cell.textLabel.numberOfLines = 4;
	cell.textLabel.adjustsFontSizeToFitWidth = YES;
	cell.textLabel.font = [UIFont systemFontOfSize:16];
	cell.textLabel.minimumFontSize = 12;
	cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

@end


