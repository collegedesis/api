class AddDescriptionToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :about, :text
  end
end
