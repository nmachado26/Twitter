//
//  ProfileViewController.m
//  twitter
//
//  Created by Nicolas Machado on 7/5/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TweetCell.h"

@interface ProfileViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *userTweets;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self fetchTweets];
    [self configureValues];
    [self createRefreshControl];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)createRefreshControl{
    // Initialize a UIRefreshControl
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchTweets) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

-(void)configureValues{
    NSString *followers = [self.user.followersCount stringValue];
    NSString *following = [self.user.followingCount stringValue];
    NSString *tweetCount = [self.user.tweetCount stringValue];
    if(self.user.followingCount == 0){
        self.followingCountLabel.text = @"0";
    }
    else{
        self.followingCountLabel.text = following;
    }
    self.followersCountLabel.text = followers;
    self.tweetCountLabel.text = tweetCount;
    self.biographyLabel.text = self.user.bioString;
    self.nameLabel.text = self.user.name;
    self.screenNameLabel.text = [@"@" stringByAppendingString:self.user.screenName];
    if (self.profileImage != nil) {
        NSURL *url = [NSURL URLWithString:self.user.profilePictureURLString];
        [self.profileImage setImageWithURL:url];
        self.profileImage.layer.borderColor = [UIColor whiteColor].CGColor;
        self.profileImage.layer.borderWidth = 5;
        self.profileImage.layer.cornerRadius = 45;
        self.profileImage.clipsToBounds = true;
    }
    if (self.profileImage != nil) {
        NSURL *url = [NSURL URLWithString:self.user.backgroundPictureURLString];
        [self.backgroundImage setImageWithURL:url];
    }
}

- (void)fetchTweets{
    // Get timeline
    [[APIManager shared] getProfileTimelineWithCompletion:self.user.screenName completion:^(NSArray *tweetDictionaries, NSError *error) {
        if (tweetDictionaries) {
            self.userTweets = [Tweet tweetsWithArray:tweetDictionaries];
            NSLog(@"successfully loaded home timeline");
            
        } else {
            NSLog(@"Error getting home timeline: %@", error.localizedDescription);
        }
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell" forIndexPath:indexPath]; 
    Tweet *tweet = self.userTweets[indexPath.row];
    [cell configureTweetCell:tweet];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.userTweets.count;
}


@end
