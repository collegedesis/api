class AddViewsTableAndCounterCacheColumn < ActiveRecord::Migration
  def up
    # create_table :views do |t|
    #   t.string   :ip
    #   t.integer  :viewable_id
    #   t.string   :viewable_type
    #   t.timestamps
    # end

    # add counter cache column
    # add_column :bulletins, :views_count, :integer, default: 0

    # Bulletin.find(:all).each do |p|
    #   Bulletin.update_counters p.id, :views_count => p.views.length
    # end
  end

  def down
  end
end
