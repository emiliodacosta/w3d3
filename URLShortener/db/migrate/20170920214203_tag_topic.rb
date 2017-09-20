class TagTopic < ActiveRecord::Migration[5.1]
  def change
    create_table :tagtopics do |t|
      t.string :topic, null: false
    end
  end
end
