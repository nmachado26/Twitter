//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "ComposeViewController.h"
#import "ProfileViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"

@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate, ComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tweets;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //set up delegates and data sources
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self fetchTweets];
    
    // Initialize a UIRefreshControl
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchTweets) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
}

- (void)fetchTweets{
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweetDictionaries, NSError *error) {
        if (tweetDictionaries) {
            self.tweets = [Tweet tweetsWithArray:tweetDictionaries];
            //[self.tableView reloadData];
            NSLog(@"successfully loaded home timeline");
            
        } else {
            NSLog(@"Error getting home timeline: %@", error.localizedDescription);
        }
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UINavigationController *navigationController = [segue destinationViewController];
    ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
    composeController.delegate = self;
   // segue.identifier -
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell" forIndexPath:indexPath];    //cell.tweet = self.tweets[indexPath.row];
    Tweet *tweet = self.tweets[indexPath.row];
    [cell configureTweetCell:tweet];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 160;
//    //UITableViewAutomaticDimension
//}

- (void)didTweet:(Tweet *)tweet {
    [self.tweets addObject:tweet];
    [self.refreshControl beginRefreshing];
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

- (IBAction)profileButtonPressed:(id)sender {
    UITableViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
    Tweet *tweet = self.tweets[indexPath.row];
    
    
//    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    ProfileViewController *profileViewController = [storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
//    appDelegate.window.rootViewController = profileViewController;
//    profileViewController.user = tweet.user;
//
    // get the viewcontroller instance - either the nav or the VC
    ProfileViewController *profileViewController = [storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    profileViewController.user = tweet.user;
   // UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:profileViewController];
    
    // push onto stack
    [self.navigationController pushViewController:profileViewController animated:YES];
    
    // present
    
    //[self presentViewController:navController animated:YES completion:nil];
}


@end
