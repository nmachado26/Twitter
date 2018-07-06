//
//  User.h
//  twitter
//
//  Created by Nicolas Machado on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

// MARK: Properties
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *screenName;
@property (strong, nonatomic) NSString *profilePictureURLString;
@property (strong, nonatomic) NSString *idStr;
@property (strong, nonatomic) NSString *backgroundPictureURLString;
@property (strong, nonatomic) NSString *bioString;
@property (strong, nonatomic) NSNumber *followersCount;
@property (strong, nonatomic) NSNumber *followingCount;
@property (strong, nonatomic) NSNumber *tweetCount;
@property (nonatomic) BOOL verified;


// Create initializer
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
