class User < ApplicationRecord
  has_many :topics, dependent: :destroy
  has_many :replies, through: :topics
  has_many :favorite_topics, through: :favorites, source: :topic, dependent: :destroy

  has_secure_password

  validates :name, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true
end
