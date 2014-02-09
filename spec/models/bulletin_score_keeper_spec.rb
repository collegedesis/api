require 'spec_helper'

describe BulletinScoreKeeper do
  describe "#new" do
    let(:bulletin)  { FactoryGirl.build(:bulletin) }
    let(:scorekeep) { BulletinScoreKeeper.new(bulletin) }

    it "should be initialized with a bulletin object" do
      expect(scorekeep.bulletin.class).to eq Bulletin
    end
  end

  describe "#update_score" do
    let(:bulletin)  { FactoryGirl.create(:bulletin) }
    let(:scorekeep) { BulletinScoreKeeper.new(bulletin) }

    before(:each) { scorekeep.stub(score: 100) }

    it "should update the score" do
      scorekeep.update_score
      expect(bulletin.score).to eq 100
    end

    context "new high score" do
      it "should udpate the high score" do
        expect(bulletin.high_score).to eq 0
        scorekeep.update_score
        expect(bulletin.high_score).to eq 100
      end
    end

    context "not a new high score" do
      it "should not update the high score" do
        bulletin.high_score = 200
        scorekeep.update_score
        expect(bulletin.high_score).to eq 200
      end
    end
  end
end