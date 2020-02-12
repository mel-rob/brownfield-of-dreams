# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password_digest
  validates_presence_of :first_name
  enum role: %i[default admin]
  has_secure_password

  def order_videos
    videos_ordered = videos.joins(:tutorial)
                           .group('tutorials.id, videos.id')
                           .order('tutorials.id', 'videos.position')
    videos_hash = {}
    videos_ordered.each do |video|
      videos_hash[video.tutorial] ||= []
      videos_hash[video.tutorial] << video
    end
    videos_hash
  end
end
