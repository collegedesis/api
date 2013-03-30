class AddPublicToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :public, :boolean, :default => true
  end
end
