class AddDownloadFieldsToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :email, :string
    add_column :purchases, :download_code, :string
    add_column :purchases, :expired, :boolean, default: :false
  end
end
