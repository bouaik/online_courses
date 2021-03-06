class Course < ApplicationRecord
    validates :title, :short_description, :language, :price, :level, presence: true
    validates :description, presence: true, length: { minimum: 5 }
    validates :title, uniqueness: true

    belongs_to :user, counter_cache: true
    # User.find_each {|user| User.reset_counters(user.id, :courses)}
    has_many :lessons, dependent: :destroy
    has_many :enrollements, dependent: :restrict_with_error
    has_many :user_lessons, through: :lessons

    has_rich_text :description

    extend FriendlyId
    friendly_id :title, use: :slugged

    scope :latest_courses, -> { limit(3).order(created_at: :desc) }
    scope :top_rated_courses, -> { limit(3).order(average_rating: :desc, created_at: :desc) }
    scope :popular_courses , -> { limit(3).order(enrollements_count: :desc, created_at: :desc) }

    scope :published, -> { where(published: true) }
    scope :approved, -> { where(approved: true) }
    scope :unpublished, -> { where(published: false) }
    scope :unapproved, -> { where(approved: false) }

    LANGUAGES = [:"English", :"Arabic", :"chinese", :"spanish"]
    def self.languages 
        LANGUAGES.map { |language| [language, language]}
    end

    LEVELS = [:"Beginner", :"Intermidiate", :"Advanced"]
    def self.levels 
        LEVELS.map { |level| [level, level]}
    end

    include PublicActivity::Model
    tracked owner: Proc.new{ |controller, model| controller.current_user }
    
    def to_s
        title
    end

    def bought(user)
        self.enrollements.where(user_id: [user.id], course_id: [self.id]).empty?
    end

    def progress(user)
        unless self.lessons_count.zero?
            user_lessons.where(user: user).count / self.lessons_count.to_f*100
        end
    end
    def update_rating
        if enrollements.any? && enrollements.where.not(rating: nil).any?
            update_column :average_rating, (enrollements.average(:rating).round(2).to_f)
        else
            update_column :average_rating, (0)
        end
    end
end
