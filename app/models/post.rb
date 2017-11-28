class Post < ApplicationRecord
  belongs_to :group
  belongs_to :user

  validates :content, presence: true
  scope :recent, -> { order("id DESC") } 
end
