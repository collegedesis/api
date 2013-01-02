class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :from_email
      t.string :from_name
      t.string :subject
      t.text :body

      t.timestamps
    end
  end
end
