require 'spec_helper'

describe BulletinTweeter do
  describe "#new" do
    it "should be initialized with a bulletin object" do
      bulletin = mock_model("Bulletin")
      tweeter = BulletinTweeter.new(bulletin)
      expect(tweeter.bulletin).to eq bulletin
    end
  end

  describe "#available_title_length" do
    let(:tweeter) { BulletinTweeter.new(mock_model("Bulletin")) }

    context "mentioned_author is nil" do
      it "returns the right number" do
        tweeter.stub(:url_to_tweet) { "lkjasda" }
        tweeter.stub(:mentioned_author) { nil }

        available_length = BulletinTweeter::TOTAL_TWEET_LENGTH -
                          tweeter.url_to_tweet.length -
                          " #{BulletinTweeter::SEPARATOR} ".length

        expect(tweeter.available_title_length).to eq available_length
      end
    end

    context "mentioned_author is not nil" do
      it "returns the right number" do
        tweeter.stub(:url_to_tweet) { "lkjasda" }
        tweeter.stub(:mentioned_author) { "@best_org" }

        available_length = BulletinTweeter::TOTAL_TWEET_LENGTH -
                          tweeter.url_to_tweet.length -
                          " #{BulletinTweeter::SEPARATOR} ".length -
                          tweeter.mentioned_author.length

        expect(tweeter.available_title_length).to eq available_length
      end
    end
  end

  describe "#title_to_tweet" do
    let(:bulletin) { mock_model("Bulletin") }
    let(:tweeter) { BulletinTweeter.new(bulletin) }

    context "title longer the available_length" do
      it "removes the last three characters and appends ellipsis" do
        tweeter.stub(:available_title_length) { 100 }
        bulletin.stub(:title) { "a" * 120 }
        expect(tweeter.title_to_tweet).to eq ("a" * 97) + "..."
      end
    end

    context "title shorter than available length" do
      it "returns just the title" do
        tweeter.stub(:available_title_length) { 100 }
        bulletin.stub(:title) { "a" * 99 }
        expect(tweeter.title_to_tweet).to eq ("a" * 99)
      end
    end

    context "title is same length as available_length" do
      it "returns just the title" do
        tweeter.stub(:available_title_length) { 100 }
        bulletin.stub(:title) { "a" * 100 }
        expect(tweeter.title_to_tweet).to eq ("a" * 100)
      end
    end
  end

  describe "#url_to_tweet" do
    let(:bulletin)  { mock_model("Bulletin") }
    let(:tweeter)   { BulletinTweeter.new(bulletin) }

    it "returns the bulletin.shareable_link" do
      bulletin.stub(:shareable_link) { "http://bit.ly/randomchars" }
      expect(tweeter.url_to_tweet).to eq "http://bit.ly/randomchars"
    end
  end

  describe "#tweet_text" do
    let(:bulletin)  { mock_model("Bulletin", author_twtter: nil) }
    let(:tweeter)   { BulletinTweeter.new(bulletin) }

    before(:each) do
      tweeter.stub(:title_to_tweet)   { "Example title" }
      tweeter.stub(:url_to_tweet)     { "http://example.com" }
      tweeter.stub(:mentioned_author) { nil }
    end

    it "includes the title" do
      expect(tweeter.tweet_text).to include "Example title"
    end

    it "includes the url" do
      expect(tweeter.tweet_text).to include "http://example.com"
    end

    context "author_twitter exists" do
      it "include mentioned author" do
        tweeter.stub(:mentioned_author) { "@best_org" }
        expect(tweeter.tweet_text).to include "cc @best_org"
      end
    end

    context "author_twitter is nil" do
      it "does not include a @" do
        expect(tweeter.tweet_text).to_not include "cc"
      end

      it "includes the author and twitter in the right order" do
        expect(tweeter.tweet_text).to eq "Example title - http://example.com"
      end
    end
  end

  describe "#mentioned_author", focus: true do
    context "author has a twitter property" do
      let(:bulletin)  { mock_model("Bulletin", author_twitter: "something") }
      let(:tweeter) { BulletinTweeter.new(bulletin) }

      it "includes the author in the tweet" do
        expect(tweeter.mentioned_author).to eq "@something"
      end
    end

    context "author's twitter returns nil" do
      let(:bulletin)  { mock_model("Bulletin", author_twitter: nil) }
      let(:tweeter) { BulletinTweeter.new(bulletin) }

      it "includes the author in the tweet" do
        expect(tweeter.mentioned_author).to eq nil
      end
    end
  end

  describe "#tweet" do
    let(:bulletin)  { mock_model("Bulletin") }
    let(:tweeter)   { BulletinTweeter.new(bulletin) }

    it "should send an update to to twitter" do
      Twitter.stub(:update) { "Tweeted successfully" }
      tweeter.stub(:tweet_text) { "an awesome sauce tweet"}
      Twitter.should_receive(:update).with("an awesome sauce tweet")
      tweeter.tweet
    end

    it "should return true if successful" do
      Twitter.stub(:update) { "Tweeted successfully" }
      tweeter.stub(:tweet_text) { "an awesome sauce tweet"}
      expect(tweeter.tweet).to eq true
    end

    it "should return false if update fails" do
      # TODO how to stub a twitter error?
    end
  end
end
