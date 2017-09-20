class DropandAddShortUrlVisitColumn < ActiveRecord::Migration[5.1]
  def change
    remove_column :visits, :short_url
    add_column :visits, :short_url_id, :integer
  end
end
