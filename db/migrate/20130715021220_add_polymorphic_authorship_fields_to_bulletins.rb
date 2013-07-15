class AddPolymorphicAuthorshipFieldsToBulletins < ActiveRecord::Migration
  def change
    add_column :bulletins, :author_id, :integer
    add_column :bulletins, :author_type, :string
  end
end
