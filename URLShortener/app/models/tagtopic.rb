# == Schema Information
#
# Table name: tagtopics
#
#  id    :integer          not null, primary key
#  topic :string           not null
#

class Tagtopic < ApplicationRecord
  validates :topic, presence: true, uniqueness: true

  has_many :taggings,
  primary_key: :id,
  foreign_key: :topic_id,
  class_name: 'Tagging'

  has_many :short_urls,
  through: :taggings
  source: :short_url

  def popular_links
    
  end

end
