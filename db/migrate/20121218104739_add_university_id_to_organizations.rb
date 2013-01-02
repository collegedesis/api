class AddUniversityIdToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :university_id, :integer
  end
end
