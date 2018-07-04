//
//  TweetCell.m
//  twitter
//
//  Created by Nicolas Machado on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "User.h"
#import "Tweet.h"
//#import "APIManager.h"


@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configureTweetCell:(Tweet *)tweet {
    self.tweet = tweet;

    self.atLabel.text = [@"@" stringByAppendingString:tweet.user.name];
    self.usernameLabel.text = tweet.user.screenName;
    if (self.profilePicture != nil) {
        NSURL *url = [NSURL URLWithString:tweet.user.profilePictureURLString];
        [self.profilePicture setImageWithURL:url];
    }
    self.contentLabel.text = self.tweet.text;
    self.likesLabel.text = [NSString stringWithFormat:@"%d",self.tweet.favoriteCount];
    self.retweetsLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.dateLabel.text = self.tweet.createdAtString;
    if(self.tweet.retweetedByUser){
        self.verifiedIcon.image = [UIImage imageNamed:@"verified_icon"];
    }
    if(self.tweet.retweeted){
        self.retweetButton.imageView.image = [UIImage imageNamed:@"retweet-icon-green"];
    }
    if(self.tweet.favorited){
        self.favoriteButton.imageView.image = [UIImage imageNamed:@"favor-icon-red"];
    }
    //self.userRetweetedLabel = self.tweet.retweetedByUser;
    //self.retweetsLogo = self.tweet.retweeted; //if true, retweet logo is the green logo now. If not, it is gray
    //self.favoriteLogo = self.tweet.favorited; //if true, favorite is the red heart now. If not, it is gray.
}
- (IBAction)didTapFavorite:(id)sender {
    NSLog(@"favorite button pressed");
    //update the local tweet model
    if(self.tweet.favorited == NO){
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
    }
    //Update cell UI
    [self refreshData];
    //Send a POST request to the POST favorites/create endpoint
    [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
        }
    }];
}

- (IBAction)didTapRetweet:(id)sender {
    NSLog(@"retweet button pressed");
    if(self.tweet.retweeted == NO){
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
    }
    //Update cell UI
    [self refreshData];
    //Send a POST request to the POST favorites/create endpoint
    [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
        }
    }];
    
}

- (void)refreshData{
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
