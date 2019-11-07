class Relationship < ApplicationRecord
  belongs_to :followee, class_name: 'User', foreign_key: 'followee_id'
  belongs_to :follower, class_name: 'User', foreign_key: 'follower_id'

  validates :follower, presence: true
  validates :followee, presence: true
  validates :follower_id, :uniqueness => {:scope => :followee_id}
  validates :followee_id, :uniqueness => {:scope => :follower_id}
end
