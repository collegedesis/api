class AddDefaultToMembershipTypeId < ActiveRecord::Migration
  def change
    change_column :memberships, :membership_type_id, :integer, :default => MEMBERSHIP_TYPE_MEMBER
  end
end
