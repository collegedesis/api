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
    let(:bulletin) { mock_model("Bulletin") }
    let(:tweeter) { BulletinTweeter.new(bulletin) }

    it "returns the right number" do
      tweeter.stub(:url_to_tweet) { "lkjasda" }
      available_length = BulletinTweeter::TOTAL_TWEET_LENGTH - tweeter.url_to_tweet.length - BulletinTweeter::SEPARATOR.length
      expect(tweeter.available_title_length).to eq available_length
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

    context "with shortened_url" do
      it "returns the bulletin.shortened_url" do
        bulletin.stub(:shortened_url) { "http://bit.ly/randomchars" }
        expect(tweeter.url_to_tweet).to eq "http://bit.ly/randomchars"
      end
    end

    context "without shortened_url" do
      it "returns placeholder" do
        bulletin.stub(:shortened_url) { nil }
        expect(tweeter.url_to_tweet).to eq "no_url_available"
      end
    end
  end

  describe "#tweet_text" do
    let(:bulletin)  { mock_model("Bulletin") }
    let(:tweeter)   { BulletinTweeter.new(bulletin) }

    it "returns title, separator, and url in the right order" do
      tweeter.stub(:title_to_tweet) { "This thing" }
      tweeter.stub(:url_to_tweet) { "some url" }
      expect(tweeter.tweet_text).to eq "This thing - some url"
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