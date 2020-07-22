class Lesson < ApplicationRecord
  validates :title, :content, :course, presence: true

  belongs_to :course


  extend FriendlyId
  friendly_id :title, use: :slugged
end
