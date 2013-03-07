class AddUrlToBulletins < ActiveRecord::Migration
  def change
    add_column :bulletins, :url, :string
  end
end