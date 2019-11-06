class Topic < ApplicationRecord
  belongs_to :user
  has_many :replies, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites

  validates :title, presence: true
  validates :content, presence: true
end
