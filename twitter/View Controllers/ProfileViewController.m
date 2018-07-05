//
//  ProfileViewController.m
//  twitter
//
//  Created by Nicolas Machado on 7/5/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *followers = [self.user.followersCount stringValue];
    NSString *following = [self.user.followingCount stringValue];
    if(self.user.followingCount == 0){
        self.followingCountLabel.text = @"0";
    }
    else{
        self.followingCountLabel.text = following;
    }
    self.followersCountLabel.text = followers;
    self.biographyLabel.text = self.user.bioString;
    self.nameLabel.text = self.user.name;
    self.screenNameLabel.text = self.user.screenName;
    if (self.profileImage != nil) {
        NSURL *url = [NSURL URLWithString:self.user.profilePictureURLString];
        [self.profileImage setImageWithURL:url];
         self.profileImage.layer.borderColor = [UIColor blackColor].CGColor;
        self.profileImage.layer.borderWidth = 5;
        self.profileImage.layer.cornerRadius = 45;
        self.profileImage.clipsToBounds = true;
    }
    if (self.profileImage != nil) {
        NSURL *url = [NSURL URLWithString:self.user.backgroundPictureURLString];
        [self.backgroundImage setImageWithURL:url];
        //self.backgroundImage.clipsToBounds = true;
    }
    
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
