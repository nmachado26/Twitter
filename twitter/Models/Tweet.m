//
//  Tweet.m
//  twitter
//
//  Created by Nicolas Machado on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

- (id)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if(self){
        // Is this a re-tweet?
        NSDictionary *originalTweet = dictionary[@"retweeted_status"];
        if(originalTweet != nil){
            NSDictionary *userDictionary = dictionary[@"user"];
            self.retweetedByUser = [[User alloc] initWithDictionary:userDictionary];
            
            // Change tweet to original tweet
            dictionary = originalTweet;
        }
        
        self.idStr = dictionary[@"id_str"];
        self.text = dictionary[@"text"];
        self.favoriteCount = [dictionary[@"favorite_count"] intValue];
        self.favorited = [dictionary[@"favorited"] boolValue];
        self.retweetCount = [dictionary[@"retweet_count"] intValue];
        self.retweeted = [dictionary[@"retweeted"] boolValue];
        self.retweeted_status = dictionary[@"retweeted_status"];
        
        // initialize user
        NSDictionary *user = dictionary[@"user"];
        self.user = [[User alloc] initWithDictionary:user];
        
        // TODO: Format and set createdAtString
        self.createdAtString = dictionary[@"created_at"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterShortStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
        
        [self formatDate:@"DFd"];
        
        NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:118800];
        
        self.createdAtString = [dateFormatter stringFromDate:date];
        // US English Locale (en_US)
        dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        NSLog(@"%@", [dateFormatter stringFromDate:date]); // Jan 2, 2001
        
        // French Locale (fr_FR)
        dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"];
        NSLog(@"%@", [dateFormatter stringFromDate:date]); // 2 janv. 2001
        
        // Japanese Locale (ja_JP)
        dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
        NSLog(@"%@", [dateFormatter stringFromDate:date]); // 2001/01/02
        
    }
    return self;
}

- (void)formatDate:(NSString *)date{
    
}

+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries{
    NSMutableArray *tweets = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        Tweet *tweet = [[Tweet alloc] initWithDictionary:dictionary];
        [tweets addObject:tweet];
    }
    return tweets;
}

@end
