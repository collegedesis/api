class AddShortenedUrlToBulletins < ActiveRecord::Migration
  def change
    add_column :bulletins, :shortened_url, :string
  end
end
