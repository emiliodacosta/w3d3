# == Schema Information
#
# Table name: shortened_urls
#
#  id           :integer          not null, primary key
#  long_url     :string           not null
#  short_url    :string           not null
#  submitter_id :integer          not null
#

class ShortenedUrl < ApplicationRecord
  validates :long_url, :short_url, :submitter_id, presence: true
  validates :short_url, uniqueness: true

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :submitter_id,
    class_name: "User"

  has_many :visits,
    primary_key: :id,
    foreign_key: :short_url,
    class_name: "Visit"

  has_many :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :user

  has_many :taggings,
  primary_key: :id,
  foreign_key: :short_url_id,
  class_name: 'Tagging'

  has_many :tagtopics,
  through: :taggings
  source: :topic

  def self.shorten!(user, long_url)
    ShortenedUrl.create!(long_url: long_url, short_url: ShortenedUrl.random_code, submitter_id: user.id)
  end

  def self.random_code
    loop do
      code = SecureRandom.urlsafe_base64(16)
      return code unless ShortenedUrl.exists?(short_url: code)
    end
  end

  def num_clicks
    Visit.where(short_url_id: self.id).count
  end

  def num_uniques
    # Visit.where(short_url_id: self.id).select(:user_id).distinct.count
    self.visitors.count
  end

  def num_recent_uniques
    Visit.where(short_url_id: self.id).where(created_at: (10.minutes.ago..Time.now)).select(:user_id).distinct.count
  end

end
