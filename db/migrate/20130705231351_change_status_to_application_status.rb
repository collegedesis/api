class ChangeStatusToApplicationStatus < ActiveRecord::Migration
  def change
    remove_column :membership_applications, :status
    add_column :membership_applications, :application_status_id, :integer, default: 1
  end
end
