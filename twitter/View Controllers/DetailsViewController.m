//
//  DetailsViewController.m
//  twitter
//
//  Created by Nicolas Machado on 7/5/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureValues];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)configureValues{
    self.nameLabel.text = self.tweetCell.usernameLabel.text;
    self.screenNameLabel.text = self.tweetCell.atLabel.text;
    self.contentLabel.text = self.tweetCell.contentLabel.text;
    self.dateLabel.text = self.dateLabel.text;
    self.retweetCountLabel.text = self.tweetCell.retweetsLabel.text;
    self.favoriteCountLabel.text = self.tweetCell.likesLabel.text;
    if (self.profileImage != nil) {
        self.profileImage.image = self.tweetCell.profilePicture.image;
        self.profileImage.layer.cornerRadius = 20;
        self.profileImage.clipsToBounds = true;
    }
    self.verifiedImage.image= self.tweetCell.verifiedIcon.image;
}

@end
