class AddHighScoreToBulletins < ActiveRecord::Migration
  def change
    add_column :bulletins, :high_score, :integer, default: 0
  end
end
