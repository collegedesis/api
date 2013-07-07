class AddCodeToMembershipApplications < ActiveRecord::Migration
  def change
    add_column :membership_applications, :code, :string
  end
end
