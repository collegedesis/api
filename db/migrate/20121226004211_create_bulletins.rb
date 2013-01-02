class CreateBulletins < ActiveRecord::Migration
  def change
    create_table :bulletins do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
