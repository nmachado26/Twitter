//
//  APIManager.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "APIManager.h"

static NSString * const baseURLString = @"https://api.twitter.com";
static NSString * const consumerKey = @"UaSfypqyr3Ze5qAbhRQXXVKKJ";
static NSString * const consumerSecret = @"EBoxc323y4TuIdgSNcqpYtvEBRjKec9C4LbOttCD3uIkCdvqOr";

@interface APIManager()

@end

@implementation APIManager

+ (instancetype)shared {
    static APIManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (instancetype)init {
    
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSString *key = consumerKey;
    NSString *secret = consumerSecret;
    // Check for launch arguments override
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"consumer-key"]) {
        key = [[NSUserDefaults standardUserDefaults] stringForKey:@"consumer-key"];
    }
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"consumer-secret"]) {
        secret = [[NSUserDefaults standardUserDefaults] stringForKey:@"consumer-secret"];
    }
    
    self = [super initWithBaseURL:baseURL consumerKey:key consumerSecret:secret];
    if (self) {
        
    }
    return self;
}

- (void)getHomeTimelineWithCompletion:(void(^)(NSArray *tweets, NSError *error))completion {
    
    [self GET:@"1.1/statuses/home_timeline.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray *  _Nullable tweetDictionaries) {
       
       // Manually cache the tweets. If the request fails, restore from cache if possible.
       NSData *data = [NSKeyedArchiver archivedDataWithRootObject:tweetDictionaries];
       [[NSUserDefaults standardUserDefaults] setValue:data forKey:@"hometimeline_tweets"];

       completion(tweetDictionaries, nil);
       
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
       NSArray *tweetDictionaries = nil;
       
       // Fetch tweets from cache if possible
       NSData *data = [[NSUserDefaults standardUserDefaults] valueForKey:@"hometimeline_tweets"];
       if (data != nil) {
           tweetDictionaries = [NSKeyedUnarchiver unarchiveObjectWithData:data];
       }
       
       completion(tweetDictionaries, error);
   }];
}

- (void)postStatusWithText:(NSString *)text completion:(void (^)(Tweet *, NSError *))completion{
    NSString *urlString = @"1.1/statuses/update.json";
    NSDictionary *parameters = @{@"status": text};
    NSLog(@"text: %@", text);
    [self POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable tweetDictionary) {
        Tweet *tweet = [[Tweet alloc]initWithDictionary:tweetDictionary];
        completion(tweet, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

- (void)favorite:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion{
    
    NSString *urlString = @"1.1/favorites/create.json";
    NSDictionary *parameters = @{@"id": tweet.idStr};
    [self POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable tweetDictionary) {
        Tweet *tweet = [[Tweet alloc]initWithDictionary:tweetDictionary];
        completion(tweet, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

- (void)retweet:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion{
    
    NSString *urlString = @"1.1/statuses/retweet.json";
    NSDictionary *parameters = @{@"id": tweet.idStr};
    [self POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable tweetDictionary) {
        Tweet *tweet = [[Tweet alloc]initWithDictionary:tweetDictionary];
        completion(tweet, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

//- (void)unretweet:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion{
//    NSString *originalTweetID;
//    if(tweet.retweeted == false){
//        return;
//    }
//    else{
//        if(tweet.retweeted_status == nil){
//            originalTweetID = tweet.idStr;
//        }
//        else{
//            originalTweetID = tweet.retweeted_status[@"id_str"];
//        }
//    }
//    NSString *getString = [[@"https://api.twitter.com/1.1/statuses/show/" stringByAppendingString:originalTweetID] stringByAppendingString:@"json?include_my_retweet=1"];
//    Tweet *fullTweet = [self GET:getString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//         NSString *retweetID = fullTweet.retweetedByUser.idStr;
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//    }];
//}

/*
function unreweet(tweet):
// step 1
if tweet.retweeted is false
return or error // you cannot unretweet a tweet that has not retweeted
else
if tweet.retweeted_status is empty
let original_tweet_id = tweet.id_str
else // tweet was itself a retweet
let original_tweet_id = tweet.retweeted_status.id_str

// step 2
let full_tweet = GET("https://api.twitter.com/1.1/statuses/show/" + original_tweet_id + "json?include_my_retweet=1")
let retweet_id = full_tweet.current_user_retweet.id_str

// step 3
POST("https://api.twitter.com/1.1/statuses/destroy/" + retweet_id + ".json")
*/

@end
