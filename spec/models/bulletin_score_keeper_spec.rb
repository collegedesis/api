require 'spec_helper'

describe BulletinScoreKeeper do
  describe "#new" do
    let(:bulletin)  { mock_model("Bulletin") }
    let(:scorekeep) { BulletinScoreKeeper.new(bulletin) }

    it "should be initialized with a bulletin object" do
      expect(scorekeep.bulletin.class).to eq Bulletin
    end
  end

  describe "#update_score" do
    let(:bulletin)  { FactoryGirl.create(:bulletin_post) }
    let(:scorekeep) { BulletinScoreKeeper.new(bulletin) }

    it "should update the recency score" do
      scorekeep.should_receive(:update_recency_score)
      scorekeep.update_score
    end

    it "should update the popularity score" do
      scorekeep.should_receive(:update_popularity_score)
      scorekeep.update_score
    end
  end

  describe "#update_recency_score" do
    let(:bulletin) { FactoryGirl.create(:bulletin_post) }
    let(:scorekeep) { BulletinScoreKeeper.new(bulletin) }

    it "should update the bulletin's recency score with the recency score" do
      scorekeep.stub(:recency_score) { 100 }
      scorekeep.update_recency_score
      expect(bulletin.recency_score).to eq 100
    end
  end

  describe "#update_popularity_score" do
    let(:bulletin) { FactoryGirl.create(:bulletin_post) }
    let(:scorekeep) { BulletinScoreKeeper.new(bulletin) }

    it "should update the bulletin's recency score with the recency score" do
      scorekeep.stub(:popularity_score) { 100 }
      scorekeep.update_popularity_score
      expect(bulletin.popularity_score).to eq 100
    end
  end
end