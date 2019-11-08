class User < ApplicationRecord
  has_many :topics, dependent: :destroy
  has_many :replies, through: :topics
  has_many :favorite_topics, through: :favorites, source: :topic, dependent: :destroy

  has_secure_password

  validates :name, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true

  has_one :topic_count, dependent: :destroy

  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id'
  has_many :followees, through: :active_relationships

  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followee_id'
  has_many :followers, through: :passive_relationships

  def following?(user)
    self.followees.include?(user)
  end 

  def follow(user)
    active_relationships.create!(followee_id: user.id) if !self.following?(user) && self != user
  end
  
  def unfollow(user)
    active_relationships.find_by(followee_id: user).destroy unless self.following?(user) && self == user
  end
  
  def feed
    Topic.where(user_id: id).or(Topic.where(user_id: active_relationships.select(:followee_id))).offset.take(limit)
  end

  def total_topic
    Topic.where(user_id: id).count
  end

  def total_following
    Relationship.where(follower_id: id).count
  end

  def total_follower
    Relationship.where(followee_id: id).count
  end
end
