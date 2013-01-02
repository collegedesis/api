class RemoveUniversityNameAndStateFromOrganizations < ActiveRecord::Migration
  def change
    remove_column :organizations, :university
    remove_column :organizations, :state
  end
end
