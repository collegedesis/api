class AddExpirationFieldsToBulletins < ActiveRecord::Migration
  def change
    add_column :bulletins, :expiration_date, :datetime
    add_column :bulletins, :expired, :boolean, default: false
  end
end
