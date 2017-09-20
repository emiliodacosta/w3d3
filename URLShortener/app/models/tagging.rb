# == Schema Information
#
# Table name: taggings
#
#  id           :integer          not null, primary key
#  topic_id     :integer          not null
#  short_url_id :integer          not null
#

class Tagging < ApplicationRecord
  validates :topic_id, :short_url_id, presence: true

  belongs_to :topic,
    primary_key: :id,
    foreign_key: :topic_id,
    class_name: "Tagtopic"

  belongs_to :short_url,
    primary_key: :id,
    foreign_key: :short_url_id,
    class_name: "ShortenedUrl"
end
