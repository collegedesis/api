class AddOrganizationIdToMembershipApplications < ActiveRecord::Migration
  def change
    add_column :membership_applications, :organization_id, :integer
  end
end
