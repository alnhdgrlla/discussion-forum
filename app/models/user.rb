class User < ApplicationRecord
  has_many :topics, dependent: :destroy
  has_many :replies, through: :topics
  has_many :favorites, dependent: :destroy
  has_many :favorite_topics, through: :favorites, source: :topic, dependent: :destroy

  has_secure_password

  validates :name, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true

  has_one :topic_count, dependent: :destroy

  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id'
  has_many :followees, through: :active_relationships

  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followee_id'
  has_many :followers, through: :passive_relationships
  
end
