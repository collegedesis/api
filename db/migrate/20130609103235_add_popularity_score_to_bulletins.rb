class AddPopularityScoreToBulletins < ActiveRecord::Migration
  def change
    add_column :bulletins, :popularity_score, :integer, :default => 0
  end
end
