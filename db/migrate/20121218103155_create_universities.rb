class CreateUniversities < ActiveRecord::Migration
  def change
    create_table :universities do |t|
      t.string :name
      t.string :city
      t.string :state
      t.string :zip

      t.timestamps
    end
  end
end
