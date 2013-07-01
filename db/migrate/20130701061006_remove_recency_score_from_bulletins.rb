class RemoveRecencyScoreFromBulletins < ActiveRecord::Migration
  def change
    remove_column :bulletins, :recency_score
    remove_column :bulletins, :popularity_score
  end
end
