//
//  ComposeViewController.m
//  twitter
//
//  Created by Nicolas Machado on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *tweetButton;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.profilePic.layer.cornerRadius = 23;
    self.profilePic.clipsToBounds = true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)backButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)tweetButtonClicked:(id)sender {
    [[APIManager shared] postStatusWithText:self.tweetTextBox.text completion:^(Tweet * tweet, NSError * error) {
        if (tweet) {
            //[self.tableView reloadData];
            NSLog(@"successfully tweeted");
            [self.delegate didTweet:tweet];
            
        } else {
            NSLog(@"Error tweeting: %@", error.localizedDescription);
        }
        [self dismissViewControllerAnimated:true completion:nil];
    }];
}

@end
