class AddAutoApproveMembershipsColumnToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :auto_approve_memberships, :boolean, default: true
  end
end
