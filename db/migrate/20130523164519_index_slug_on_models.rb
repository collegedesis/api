class IndexSlugOnModels < ActiveRecord::Migration
  def change
    add_index :organizations, :slug
    add_index :bulletins, :slug
  end
end
