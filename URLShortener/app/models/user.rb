# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true

  has_many :submitted_urls,
    primary_key: :id,
    foreign_key: :submitter_id,
    class_name: "ShortenedUrl"

  has_many :visits,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "Visit"

  has_many :visited_urls,
    Proc.new { distinct },
    through: :visits,
    source: :short_url
end
