class AddInstagramToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :instagram, :string
  end
end
