class BlogPost < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true
  validates :published, inclusion: { in: [true, false] }
  
  scope :published, -> { where(published: true) }
  scope :unpublished, -> { where(published: false) }
  scope :recent, -> { order(created_at: :desc) }
end
