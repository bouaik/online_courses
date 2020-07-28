class Lesson < ApplicationRecord
  validates :title, :content, :course, presence: true

  belongs_to :course, counter_cache: true
  # Course.find_each {|course| Course.reset_counters(course.id, :lessons)}

  has_many :user_lessons, dependent: :destroy

  has_rich_text :content

  extend FriendlyId
  friendly_id :title, use: :slugged

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  def to_s
    title
  end

  def viewd(user)
    self.user_lessons.where(user: user).present?
  end
end
