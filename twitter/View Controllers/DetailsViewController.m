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
    self.nameLabel.text = self.tweetCell.usernameLabel.text;
    self.screenNameLabel.text = self.tweetCell.atLabel.text;
    self.contentLabel.text = self.tweetCell.contentLabel.text;
    self.dateLabel.text = self.dateLabel.text;
    self.retweetCountLabel.text = self.tweetCell.retweetsLabel.text;
    self.favoriteCountLabel.text = self.tweetCell.likesLabel.text;
    if (self.profileImage != nil) {
        self.profileImage.image = self.tweetCell.profilePicture.image;
//        NSURL *url = [NSURL URLWithString:tweet.user.profilePictureURLString];
  //      [self.profilePicture setImageWithURL:url];
        self.profileImage.layer.cornerRadius = 20;
        self.profileImage.clipsToBounds = true;
    }
    self.verifiedImage.image= self.tweetCell.verifiedIcon.image;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
