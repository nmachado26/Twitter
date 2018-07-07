# Project 4 - *Twitter*

**Twitter** is a basic twitter app to read and compose tweets the [Twitter API](https://apps.twitter.com/).

Time spent: **19** hours spent in total

## User Stories

The following **required** functionality is completed:

- [YES ] User sees app icon in home screen and styled launch screen
- [ YES] User can sign in using OAuth login flow
- [ YES] User can Logout
- [ YES] User can view last 20 tweets from their home timeline
- [ YES] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp.
- [ YES] User can pull to refresh.
- [ YES] User can tap the retweet and favorite buttons in a tweet cell to retweet and/or favorite a tweet.
- [ ] User can compose a new tweet by tapping on a compose button.
- [ YES] Using AutoLayout, the Tweet cell should adjust it's layout for iPhone 7, Plus and SE device sizes as well as accommodate device rotation.
- [ YES] The current signed in user will be persisted across restarts

The following **optional** features are implemented:

- [ YES] Tweet Details Page: User can tap on a tweet to view it, with controls to retweet, favorite, and reply.
- [ YES] User can view their profile in a *profile tab*
- Contains the user header view: picture and tagline
- Contains a section with the users basic stats: # tweets, # following, # followers
- [ YES] Profile view should include that user's timeline
- [ ] User should display the relative timestamp for each tweet "8m", "7h"
- [ YES] User should be able to unretweet and unfavorite and should decrement the retweet and favorite count. Refer to [[this guide|unretweeting]] for help on implementing unretweeting.
- [ ] Links in tweets are clickable.
- [ YES] User can tap the profile image in any tweet to see another user's profile
- Contains the user header view: picture and tagline
- Contains a section with the users basic stats: # tweets, # following, # followers
- [ ] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.
- [ ] When composing, you should have a countdown for the number of characters remaining for the tweet (out of 140) (**1 point**)
- [ YES] After creating a new tweet, a user should be able to view it in the timeline immediately without refetching the timeline from the network.
- [ ] User can reply to any tweet, and replies should be prefixed with the username and the reply_id should be set when posting the tweet (**2 points**)
- [ ] User sees embedded images in tweet if available 
- [ ] User can switch between timeline, mentions, or profile view through a tab bar (**3 points**)
- [ ] Profile Page: pulling down the profile page should blur and resize the header image. (**4 points**)


The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Discussing delegates and its implementation and uses with peers would be extremely helpful for me, as this is one of the topics that I am having a hard time understanding its functionality and uses in the code. 
2. I also want to discuss constraints and its manipulation with labels, especially as they can vary in size. 

## Video Walkthrough

Here's a walkthrough of implemented user stories:

ADDED THE GIF TO THE REPO!  nmachado26/Twitter/twitterGifRecord1.gif 

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app. I had some tough challenges while building this app. Firstly, my autolayout was not conforming, and I spent a significant amount of time learning the intricacies and secrets of autolayout to help with my app. Also, the flow of information and API manipulation was a definitely difficult concept, which I decided to focus on this project to learn as much as possible. With this focus and a lot of code study, I have a better understanding of GET and POST API implementations, but I still need further learning in these topics, as I definitely do not feel entirely confident yet. I am hoping to emphasize this during the coming next week also. I also want to play around and learn about the flow and the pros and cons of different implementations (segue styles/manners, types of push/modal, etc) that would be best for the situation and goal that I have.

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library

## License

Copyright [2018] [Nicolas Machado]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
