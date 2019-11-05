class Reply < ApplicationRecord
  belongs_to :topic
  has_one :user, through: :topic

  validates :content, presence: true
end
