class CreateOrganizationTypes < ActiveRecord::Migration
  def change
    create_table :organization_types do |t|
      t.string :name
      t.string :category
      t.integer :int_ref

      t.timestamps
    end
  end
end
