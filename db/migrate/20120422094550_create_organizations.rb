class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :university
      t.string :website
      t.string :email
      t.string :facebook
      t.string :twitter
      t.string :youtube
      t.string :city
      t.string :state
      t.integer :organization_type_id
      t.timestamps
    end
  end
end
