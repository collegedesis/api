class AddRecencyScoreToBulletins < ActiveRecord::Migration
  def change
    add_column :bulletins, :recency_score, :integer, :default => 0
  end
end
