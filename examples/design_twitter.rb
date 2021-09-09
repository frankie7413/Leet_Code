# frozen_string_literal: true

# Your Twitter object will be instantiated and called as such:
# obj = Twitter.new()
# obj.post_tweet(user_id, tweet_id)
# param_2 = obj.get_news_feed(user_id)
# obj.follow(follower_id, followee_id)
# obj.unfollow(follower_id, followee_id)

# Explanation
# Twitter twitter = new Twitter();
# twitter.postTweet(1, 5); // User 1 posts a new tweet (id = 5).
# twitter.getNewsFeed(1);
# // User 1's news feed should return a list with 1 tweet id -> [5]. return [5]
# twitter.follow(1, 2);    // User 1 follows user 2.
# twitter.postTweet(2, 6); // User 2 posts a new tweet (id = 6).
# twitter.getNewsFeed(1);
# // User 1's news feed should return a list with 2 tweet ids -> [6, 5].
# Tweet id 6 should precede tweet id 5 because it is posted after tweet id 5.
# twitter.unfollow(1, 2);  // User 1 unfollows user 2.
# twitter.getNewsFeed(1);
# // User 1's news feed should return a list with 1 tweet id -> [5],
# since user 1 is no longer following user 2.

# twitter object to track tweets, followers and return news feed.
class Twitter
  attr_reader :tweets, :followers

  # Initialize your data structure here.
  def initialize
    @tweets = {}
    @followers = {}
  end

  # Compose a new tweet.
  # :type user_id: Integer
  # :type tweet_id: Integer
  # :rtype: Void
  def post_tweet(user_id, tweet_id)
    return nil unless @tweets.values.flatten.select { |tweet| tweet[:tweet_id] == tweet_id }.empty?

    @tweets[user_id] ||= []
    @tweets[user_id] << { tweet_id: tweet_id, time: Time.now }
  end

  # Retrieve the 10 most recent tweet ids in the user's news feed.
  # Each item in the news feed must be posted by users who the user followed or by the user herself.
  # Tweets must be ordered from most recent to least recent.
  # :type user_id: Integer
  # :rtype: Integer[]
  def get_news_feed(user_id)
    tweets = @tweets[user_id] || []

    @followers[user_id]&.each do |follower_id|
      tweets += @tweets[follower_id] || []
    end

    tweets.sort_by { |tweet| tweet[:time] }.reverse.first(10).map { |tweet| tweet[:tweet_id] }
  end

  # Follower follows a followee. If the operation is invalid, it should be a no-op.
  # :type follower_id: Integer
  # :type followee_id: Integer
  # :rtype: Void
  def follow(follower_id, followee_id)
    return if !@followers[follower_id].nil? && @followers[follower_id].include?(followee_id)

    @followers[follower_id] ||= Set.new
    @followers[follower_id] << followee_id
  end

  # Follower unfollows a followee. If the operation is invalid, it should be a no-op.
  # :type follower_id: Integer
  # :type followee_id: Integer
  # :rtype: Void
  def unfollow(follower_id, followee_id)
    return unless @followers[follower_id]

    @followers[follower_id].delete(followee_id)
  end
end

# twitter = Twitter.new
# twitter.post_tweet(1, 5)
# twitter.get_news_feed(1)
# twitter.follow(1, 2)
# twitter.post_tweet(2, 6)
# twitter.get_news_feed(1)
# twitter.unfollow(1, 2)
# twitter.get_news_feed(1)
# twitter.follow(1, 4)
# twitter.get_news_feed(1)

# test run
twitter = Twitter.new

twitter.post_tweet(1, 5)
twitter.post_tweet(1, 3)
twitter.post_tweet(1, 101)
twitter.post_tweet(1, 13)
twitter.post_tweet(1, 10)
twitter.post_tweet(1, 2)
twitter.post_tweet(1, 94)
twitter.post_tweet(1, 505)
twitter.post_tweet(1, 333)
twitter.post_tweet(1, 22)
twitter.post_tweet(1, 11)

twitter.get_news_feed(1)
