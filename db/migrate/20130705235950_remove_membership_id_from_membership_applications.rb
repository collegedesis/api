class RemoveMembershipIdFromMembershipApplications < ActiveRecord::Migration
  def change
    remove_column :membership_applications, :membership_id
  end
end
