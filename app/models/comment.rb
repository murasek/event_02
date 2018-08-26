class Comment < ActiveRecord::Base
  validates :content, presence: true
  belongs_to :user
  belongs_to :event
  has_many :notifications, dependent: :destroy
end
