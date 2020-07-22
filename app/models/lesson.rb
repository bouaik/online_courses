class Lesson < ApplicationRecord
  validates :title, :content, :course, presence: true

  belongs_to :course

  has_rich_text :content

  extend FriendlyId
  friendly_id :title, use: :slugged

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  def to_s
    title
  end
end
