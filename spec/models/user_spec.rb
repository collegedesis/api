require 'spec_helper'

describe User do
  describe "Destroying user" do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end
    it "should delete all associated memberships on destroy" do
      org = FactoryGirl.create(:organization)
      @user.memberships.create(organization_id: org.id)
      memberships = @user.memberships
      @user.destroy
      memberships.should eq []
    end

    it "should delete all associated votes on destroy" do
      @user.votes.create(votable_id: 1)
      votes = @user.votes
      @user.destroy
      votes.should eq []
    end
    it "should delete all associated comments on destroy" do
      @user.comments.create(commentable_id: 1)
      comments = @user.comments
      @user.destroy
      comments.should eq []
    end
    it "should delete all associated bulletins on destroy" do
      bulletin = FactoryGirl.create(:bulletin_post, user_id: @user.id)
      bulletins = @user.bulletins
      @user.destroy
      bulletins.should eq []
    end
  end
end