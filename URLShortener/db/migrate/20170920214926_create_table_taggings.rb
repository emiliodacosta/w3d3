class CreateTableTaggings < ActiveRecord::Migration[5.1]
  def change
    create_table :taggings do |t|
      t.integer :topic_id, null: false
      t.integer :short_url_id, null: false
    end
  end
end
